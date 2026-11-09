import { test, beforeEach, afterEach, after } from 'node:test';
import assert from 'node:assert/strict';
import { api, auth, closeAll, closeDb, createShop, freshDb, login, push, tx } from './helpers/setup.js';
import { computeEntitlement, extendDate } from '../src/services/entitlement.js';
import { mapPlaySubscription } from '../src/services/play.js';
import { buildStatement, formatMoney } from '../src/services/statement.js';
import { devicePrefixFor } from '../src/services/shopData.js';

let db;
let owner;
beforeEach(async () => {
  db = await freshDb();
  owner = await login('owner@test.com');
  await createShop(owner.token, 'shop-1', { paymentInfo: 'nour@instapay', shopCode: 'NOUR01' });
});
afterEach(async () => { await closeDb(db); });
after(closeAll);

async function seedCustomer() {
  await push(owner.token, 'shop-1', [
    { collection: 'customers', record: { id: 'cust-1', name: 'أحمد <script>alert(1)</script> محمد' } },
    { collection: 'transactions', record: tx('t-1', { amountPiasters: 50000, note: 'سكر <b>وزيت</b>' }) },
    { collection: 'transactions', record: tx('t-2', { type: 'payment', amountPiasters: 20000, occurredAt: '2026-11-02T10:00:00Z' }) },
    // Installment payment must not affect the credit balance.
    { collection: 'transactions', record: tx('t-3', { type: 'payment', amountPiasters: 300000, installmentPlanId: 'p-1' }) },
    { collection: 'installment_plans', record: { id: 'p-1', customerId: 'cust-1', itemDescription: 'Samsung A15', totalPricePiasters: 1200000, downPaymentPiasters: 200000, installmentCount: 10, status: 'active' } },
    ...Array.from({ length: 10 }, (_, i) => ({
      collection: 'installments',
      record: { id: `i-${i + 1}`, planId: 'p-1', installmentIndex: i + 1, amountPiasters: 100000, dueDate: `2026-${String(12).padStart(2, '0')}-0${(i % 9) + 1}` },
    })),
  ]);
}

test('statement link: create, open (escaped, separate installments), revoke', async () => {
  await api().post('/v1/shops/shop-1/statement-links').set(auth(owner.token)).send({ customerId: 'missing' }).expect(404);
  await seedCustomer();
  const created = await api().post('/v1/shops/shop-1/statement-links').set(auth(owner.token)).send({ customerId: 'cust-1' }).expect(201);
  assert.match(created.body.url, /^https:\/\/kashkool\.test\/s\/[A-Za-z0-9_-]{20,}$/);
  const path = new URL(created.body.url).pathname;

  const page = await api().get(path).expect(200);
  assert.match(page.headers['x-robots-tag'], /noindex/);
  assert.ok(page.text.includes('300 جنيه'), 'credit balance 500-200 = 300');
  assert.ok(page.text.includes('Samsung A15'));
  assert.ok(page.text.includes('المتبقي: 9,000 جنيه'), 'plan remaining 12000 - 3000');
  assert.ok(page.text.includes('nour@instapay'));
  assert.ok(!page.text.includes('<script>alert'), 'customer name is escaped');
  assert.ok(!page.text.includes('<b>وزيت'), 'notes are escaped');
  assert.ok(!page.text.includes('01012345678'));

  const links = await api().get('/v1/shops/shop-1/statement-links?customerId=cust-1').set(auth(owner.token)).expect(200);
  assert.equal(links.body.links[0].openCount, 1);

  await api().delete(`/v1/shops/shop-1/statement-links/${created.body.link.id}`).set(auth(owner.token)).expect(204);
  await api().get(path).expect(410);
  await api().get('/s/short').expect(404);
  await api().get('/s/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa').expect(404);
});

test('expired statement links stop working', async () => {
  await seedCustomer();
  const created = await api().post('/v1/shops/shop-1/statement-links').set(auth(owner.token)).send({ customerId: 'cust-1', expiresInDays: 7 }).expect(201);
  await db.collection('statement_links').updateOne({ id: created.body.link.id }, { $set: { expiresAt: new Date(Date.now() - 1000) } });
  await api().get(new URL(created.body.url).pathname).expect(410);
});

test('buildStatement computes next due installment with FIFO', () => {
  const s = buildStatement({
    customer: { name: 'أحمد محمد' },
    transactions: [
      { type: 'payment', amountPiasters: 200000, installmentPlanId: 'p', occurredAt: '2026-01-01' },
      { type: 'payment', amountPiasters: 150000, installmentPlanId: 'p', occurredAt: '2026-02-01' },
    ],
    plans: [{ id: 'p', totalPricePiasters: 1200000, downPaymentPiasters: 200000 }],
    schedules: { p: [1, 2, 3].map((i) => ({ installmentIndex: i, amountPiasters: 100000, dueDate: `2026-0${i + 1}-01` })) },
  });
  assert.equal(s.customerFirstName, 'أحمد');
  assert.equal(s.balance, 0);
  assert.equal(s.plans[0].remaining, 850000);
  assert.deepEqual(s.plans[0].nextDue, { date: '2026-03-01', amount: 50000 });
  assert.equal(formatMoney(123456), '1,234.56 جنيه');
});

test('referral: qualifies after real activity and rewards both shops', async () => {
  const newOwner = await login('new@test.com');
  await createShop(newOwner.token, 'shop-2');
  await api().post('/v1/shops/shop-2/referral').set(auth(newOwner.token)).send({ code: 'nour01' }).expect(201);
  await api().post('/v1/shops/shop-2/referral').set(auth(newOwner.token)).send({ code: 'NOUR01' }).expect(409);
  await api().post('/v1/shops/shop-1/referral').set(auth(owner.token)).send({ code: 'NOUR01' }).expect(400); // self

  // 10 transactions spread over 3 days (server time).
  const changes = Array.from({ length: 10 }, (_, i) => ({ collection: 'transactions', record: tx(`r-${i}`) }));
  await push(newOwner.token, 'shop-2', changes);
  const days = ['2026-11-01T10:00:00Z', '2026-11-02T10:00:00Z', '2026-11-03T10:00:00Z'];
  let i = 0;
  for (const doc of await db.collection('transactions').find({ shopId: 'shop-2' }).toArray()) {
    await db.collection('transactions').updateOne({ _id: doc._id }, { $set: { serverCreatedAt: new Date(days[i++ % 3]) } });
  }

  await api().get('/api/cron/referrals').expect(401);
  const run = await api().get('/api/cron/referrals').set('Authorization', 'Bearer cron_test_secret').expect(200);
  assert.equal(run.body.rewarded, 1);

  const ent1 = await api().get('/v1/shops/shop-1/entitlement').set(auth(owner.token)).expect(200);
  assert.equal(ent1.body.entitlement.tier, 'pro');
  assert.equal(ent1.body.entitlement.source, 'referral_bonus');
  const refs = await api().get('/v1/shops/shop-1/referrals').set(auth(owner.token)).expect(200);
  assert.equal(refs.body.monthsEarned, 1);
});

test('referral does not qualify with too little activity', async () => {
  const newOwner = await login('new@test.com');
  await createShop(newOwner.token, 'shop-2');
  await api().post('/v1/shops/shop-2/referral').set(auth(newOwner.token)).send({ code: 'NOUR01' }).expect(201);
  await push(newOwner.token, 'shop-2', [{ collection: 'transactions', record: tx('r-1') }]);
  const run = await api().get('/api/cron/referrals').set('Authorization', 'Bearer cron_test_secret').expect(200);
  assert.equal(run.body.rewarded, 0);
});

test('entitlement picks the best active source', () => {
  const now = new Date('2026-11-09T00:00:00Z');
  assert.equal(computeEntitlement({ now }).tier, 'free');
  const e = computeEntitlement({
    now,
    shop: { bonusProUntil: '2026-12-01T00:00:00Z' },
    subscriptions: [
      { state: 'SUBSCRIPTION_STATE_ACTIVE', tier: 'installments_pro', expiresAt: '2026-12-09T00:00:00Z' },
      { state: 'SUBSCRIPTION_STATE_EXPIRED', tier: 'installments_pro', expiresAt: '2027-01-01T00:00:00Z' },
    ],
  });
  assert.deepEqual([e.tier, e.source], ['installments_pro', 'play']);
  const expired = computeEntitlement({ now, subscriptions: [{ state: 'SUBSCRIPTION_STATE_ACTIVE', tier: 'pro', expiresAt: '2026-11-01T00:00:00Z' }] });
  assert.equal(expired.tier, 'free');
  assert.equal(extendDate('2026-11-20T00:00:00Z', 30, now).toISOString(), '2026-12-20T00:00:00.000Z');
  assert.equal(extendDate('2026-10-01T00:00:00Z', 30, now).toISOString(), '2026-12-09T00:00:00.000Z');
});

test('Google Play response mapping', () => {
  const m = mapPlaySubscription(
    {
      subscriptionState: 'SUBSCRIPTION_STATE_ACTIVE',
      acknowledgementState: 'ACKNOWLEDGEMENT_STATE_ACKNOWLEDGED',
      externalAccountIdentifiers: { obfuscatedExternalAccountId: 'shop-1' },
      lineItems: [{ productId: 'kashkool_pro_monthly', expiryTime: '2026-12-09T00:00:00Z' }],
    },
    { kashkool_pro_monthly: 'pro' },
  );
  assert.equal(m.tier, 'pro');
  assert.equal(m.linkedShopId, 'shop-1');
  assert.equal(m.expiresAt.toISOString(), '2026-12-09T00:00:00.000Z');
  assert.equal(mapPlaySubscription({ lineItems: [{ productId: 'other' }] }, {}).tier, null);
});

test('webhook rejects calls without the secret token', async () => {
  await api().post('/v1/webhooks/play-rtdn').send({}).expect(401);
});

test('device prefixes continue after Z', () => {
  assert.deepEqual([0, 1, 25, 26, 27, 51, 52].map(devicePrefixFor), ['A', 'B', 'Z', 'AA', 'AB', 'AZ', 'BA']);
});

test('errors never leak internals', async () => {
  const res = await api().post('/v1/auth/dev').set('Content-Type', 'application/json').send('{bad json').expect(400);
  assert.equal(res.body.error, 'invalid_json');
  await api().get('/nope').expect(404);
});
