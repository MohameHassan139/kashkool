import { test, beforeEach, afterEach, after } from 'node:test';
import assert from 'node:assert/strict';
import request from 'supertest';
import { app, api, auth, closeAll, closeDb, createShop, freshDb, login, push, tx } from './helpers/setup.js';
import { config } from '../src/config.js';
import { buildOverview, perDay } from '../src/services/adminStats.js';

let db;
beforeEach(async () => {
  db = await freshDb();
});
afterEach(async () => {
  await closeDb(db);
});
after(closeAll);

async function adminAgent(email = 'boss@test.com') {
  const agent = request.agent(app);
  await agent.post('/admin/api/dev-login').set('X-Kashkool-Admin', '1').send({ email }).expect(200);
  return agent;
}

test('admin page is served with a strict CSP and no indexing', async () => {
  const res = await api().get('/admin').expect(200);
  assert.match(res.headers['content-type'], /text\/html/);
  assert.match(res.headers['content-security-policy'], /script-src 'self' https:\/\/accounts\.google\.com\/gsi\/client/);
  assert.match(res.headers['content-security-policy'], /frame-ancestors 'none'/);
  assert.match(res.headers['x-robots-tag'], /noindex/);
  assert.ok(res.text.includes('/admin/app.js'));
  await api().get('/admin/app.js').expect(200).expect('Content-Type', /javascript/);
  await api().get('/admin/style.css').expect(200).expect('Content-Type', /css/);
});

test('admin API needs an allowed admin session', async () => {
  await api().get('/admin/api/overview').expect(401);
  await api().post('/admin/api/dev-login').send({ email: 'random@test.com' }).expect(403);
  const agent = await adminAgent();
  const me = await agent.get('/admin/api/me').expect(200);
  assert.equal(me.body.email, 'boss@test.com');

  // A normal app user token is not an admin session.
  const user = await login('boss@test.com');
  await api().get('/admin/api/overview').set(auth(user.token)).expect(401);
});

test('removing an email from ADMIN_EMAILS locks it out immediately', async () => {
  const agent = await adminAgent();
  const saved = config.adminEmails;
  config.adminEmails = [];
  try {
    await agent.get('/admin/api/overview').expect(403);
  } finally {
    config.adminEmails = saved;
  }
});

test('changes require the admin header (CSRF guard)', async () => {
  const owner = await login('owner@test.com');
  await createShop(owner.token, 'shop-1');
  const agent = await adminAgent();
  await agent.post('/admin/api/shops/shop-1/grant').send({ days: 30, reason: 'support' }).expect(403);
  const ok = await agent.post('/admin/api/shops/shop-1/grant').set('X-Kashkool-Admin', '1').send({ days: 30, reason: 'support' }).expect(200);
  assert.ok(ok.body.bonusProUntil);

  const ent = await api().get('/v1/shops/shop-1/entitlement').set(auth(owner.token)).expect(200);
  assert.equal(ent.body.entitlement.tier, 'pro');

  const audit = await agent.get('/admin/api/audit').expect(200);
  assert.equal(audit.body.entries[0].action, 'grant_pro_days');
  assert.equal(audit.body.entries[0].details.reason, 'support');
  assert.equal(audit.body.entries[0].ip, undefined);
});

test('overview, shop list and shop details show metadata only', async () => {
  const owner = await login('owner@test.com');
  await createShop(owner.token, 'shop-1', { type: 'mobile', shopCode: 'NOUR01' });
  const other = await login('other@test.com');
  await createShop(other.token, 'shop-2');
  await push(owner.token, 'shop-1', [
    { collection: 'customers', record: { id: 'c-1', name: 'سر العميل', phone: '01099999999' } },
    { collection: 'transactions', record: tx('t-1', { amountPiasters: 777700, note: 'ملاحظة سرية' }) },
  ]);
  await api().post('/v1/shops/shop-2/trial').set(auth(other.token)).expect(200);

  const agent = await adminAgent();
  const o = await agent.get('/admin/api/overview').expect(200);
  assert.equal(o.body.shops.total, 2);
  assert.equal(o.body.shops.active1d, 1);
  assert.equal(o.body.shops.byType.mobile, 1);
  assert.equal(o.body.revenue.sources.trial, 1);
  assert.equal(o.body.charts.newShops.length, 30);
  assert.equal(o.body.charts.activeShops.at(-1).count, 1);

  const list = await agent.get('/admin/api/shops?q=owner@test.com').expect(200);
  assert.equal(list.body.total, 1);
  assert.equal(list.body.shops[0].ownerEmail, 'owner@test.com');
  assert.ok(list.body.shops[0].lastSyncAt);

  const byCode = await agent.get('/admin/api/shops?q=nour01').expect(200);
  assert.equal(byCode.body.total, 1);

  const detail = await agent.get('/admin/api/shops/shop-1').expect(200);
  assert.equal(detail.body.recordCounts.customers, 1);
  assert.equal(detail.body.recordCounts.transactions, 1);
  const raw = JSON.stringify(detail.body);
  for (const secret of ['سر العميل', '01099999999', '777700', 'ملاحظة سرية']) {
    assert.ok(!raw.includes(secret), `admin must not see ${secret}`);
  }
  await agent.get('/admin/api/shops/nope').expect(404);
});

test('remote config: validated, saved, and public endpoint hides who edited it', async () => {
  const agent = await adminAgent();
  await agent.put('/admin/api/config').set('X-Kashkool-Admin', '1').send({ minSupportedVersion: 'abc' }).expect(400);
  await agent
    .put('/admin/api/config')
    .set('X-Kashkool-Admin', '1')
    .send({ minSupportedVersion: '1.2.0', latestVersion: '1.3.0', flags: { cloudBackup: true }, announcement: { text: 'تحديث جديد', level: 'info' } })
    .expect(200);
  const pub = await api().get('/v1/config').expect(200);
  assert.equal(pub.body.minSupportedVersion, '1.2.0');
  assert.equal(pub.body.flags.cloudBackup, true);
  assert.equal(pub.body.announcement.text, 'تحديث جديد');
  assert.equal(pub.body.updatedBy, undefined);
});

test('logout clears the session', async () => {
  const agent = await adminAgent();
  await agent.post('/admin/api/logout').expect(204);
  await agent.get('/admin/api/me').expect(401);
});

test('buildOverview revenue and conversion', () => {
  const now = new Date('2026-11-09T12:00:00Z');
  const o = buildOverview({
    now,
    tierPrices: { pro: 79, installments_pro: 149 },
    shops: [
      { id: 'a', type: 'grocery', createdAt: '2026-11-08T00:00:00Z', trialEndsAt: '2026-10-01T00:00:00Z' },
      { id: 'b', type: 'mobile', createdAt: '2026-10-01T00:00:00Z' },
      { id: 'c', type: 'mobile', createdAt: '2026-11-09T00:00:00Z', trialEndsAt: '2026-11-20T00:00:00Z' },
    ],
    subscriptions: [
      { shopId: 'a', tier: 'pro', state: 'SUBSCRIPTION_STATE_ACTIVE', expiresAt: '2026-12-01T00:00:00Z' },
      { shopId: 'b', tier: 'installments_pro', state: 'SUBSCRIPTION_STATE_ACTIVE', expiresAt: '2026-12-01T00:00:00Z' },
    ],
    members: [{ role: 'employee' }, { role: 'owner' }],
    users: [],
    referrals: [],
  });
  assert.equal(o.revenue.estimatedMrrEgp, 79 + 149);
  assert.equal(o.revenue.payingShops, 2);
  assert.equal(o.revenue.trialStarted, 2);
  assert.equal(o.revenue.trialConverted, 1);
  assert.equal(o.revenue.trialConversionRate, 50);
  assert.equal(o.shops.new7d, 2);
  assert.equal(o.users.employees, 1);
  assert.deepEqual(perDay(['2026-11-09T01:00:00Z', '2026-11-09T05:00:00Z'], 2, now), [
    { day: '2026-11-08', count: 0 },
    { day: '2026-11-09', count: 2 },
  ]);
});
