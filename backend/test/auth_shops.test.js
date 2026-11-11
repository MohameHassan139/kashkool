import { test, beforeEach, afterEach, after } from 'node:test';
import assert from 'node:assert/strict';
import { api, auth, closeAll, closeDb, createShop, freshDb, login } from './helpers/setup.js';

let db;
beforeEach(async () => { db = await freshDb(); });
afterEach(async () => { await closeDb(db); });
after(closeAll);

test('health and remote config are public', async () => {
  await api().get('/health').expect(200);
  const res = await api().get('/v1/config').expect(200);
  assert.equal(res.body.minSupportedVersion, '1.0.0');
});

test('protected routes need a valid token', async () => {
  await api().get('/v1/me').expect(401);
  await api().get('/v1/me').set(auth('not-a-token')).expect(401);
});

test('login, /me, refresh token rotation, logout', async () => {
  const { token, refreshToken } = await login('owner@test.com');
  const me = await api().get('/v1/me').set(auth(token)).expect(200);
  assert.equal(me.body.user.email, 'owner@test.com');

  const refreshed = await api().post('/v1/auth/refresh').send({ refreshToken }).expect(200);
  assert.ok(refreshed.body.accessToken);
  // The old refresh token can't be reused after rotation.
  await api().post('/v1/auth/refresh').send({ refreshToken }).expect(401);

  await api().post('/v1/auth/logout').send({ refreshToken: refreshed.body.refreshToken }).expect(204);
  await api().post('/v1/auth/refresh').send({ refreshToken: refreshed.body.refreshToken }).expect(401);
});

test('email registration stores a password hash and email login issues tokens', async () => {
  const registered = await api().post('/v1/auth/email/register').send({
    email: '  owner@EXAMPLE.com ',
    password: 'correct horse battery',
    name: 'Owner',
  }).expect(201);
  assert.equal(registered.body.user.email, 'owner@example.com');
  assert.ok(registered.body.accessToken);
  assert.ok(registered.body.refreshToken);

  const stored = await db.collection('users').findOne({ email: 'owner@example.com' });
  assert.notEqual(stored.passwordHash, 'correct horse battery');
  assert.ok(stored.passwordSalt);

  const login = await api().post('/v1/auth/email/login').send({
    email: 'OWNER@example.com',
    password: 'correct horse battery',
  }).expect(200);
  const me = await api().get('/v1/me').set(auth(login.body.accessToken)).expect(200);
  assert.equal(me.body.user.email, 'owner@example.com');
});

test('email login rejects incorrect credentials without revealing account existence', async () => {
  await api().post('/v1/auth/email/register').send({
    email: 'owner@example.com',
    password: 'correct horse battery',
  }).expect(201);

  const wrongPassword = await api().post('/v1/auth/email/login').send({
    email: 'owner@example.com',
    password: 'wrong password',
  }).expect(401);
  const missingAccount = await api().post('/v1/auth/email/login').send({
    email: 'missing@example.com',
    password: 'wrong password',
  }).expect(401);
  assert.equal(wrongPassword.body.error, missingAccount.body.error);

  await api().post('/v1/auth/email/register').send({
    email: 'owner@example.com',
    password: 'another password',
  }).expect(409);
});

test('shop registration is idempotent for the owner and blocked for others', async () => {
  const a = await login('a@test.com');
  const b = await login('b@test.com');
  const first = await createShop(a.token, 'shop-1', { shopCode: 'ab12cd' });
  assert.equal(first.status, 201);
  assert.equal(first.body.shop.shopCode, 'AB12CD');
  const again = await createShop(a.token, 'shop-1');
  assert.equal(again.status, 200);
  assert.equal(again.body.created, false);
  const stolen = await createShop(b.token, 'shop-1');
  assert.equal(stolen.status, 409);
});

test('a user cannot see or touch another shop', async () => {
  const a = await login('a@test.com');
  const b = await login('b@test.com');
  await createShop(a.token, 'shop-a');
  await api().get('/v1/shops/shop-a').set(auth(b.token)).expect(404);
  await api().patch('/v1/shops/shop-a').set(auth(b.token)).send({ name: 'hacked' }).expect(404);
  await api().get('/v1/shops/shop-a/sync/pull').set(auth(b.token)).expect(404);
  const list = await api().get('/v1/shops').set(auth(b.token)).expect(200);
  assert.equal(list.body.shops.length, 0);
});

test('devices get stable letter prefixes', async () => {
  const a = await login('a@test.com');
  await createShop(a.token, 'shop-1');
  const d1 = await api().post('/v1/shops/shop-1/devices').set(auth(a.token)).send({ deviceId: 'dev-1' }).expect(201);
  const d2 = await api().post('/v1/shops/shop-1/devices').set(auth(a.token)).send({ deviceId: 'dev-2' }).expect(201);
  const d1again = await api().post('/v1/shops/shop-1/devices').set(auth(a.token)).send({ deviceId: 'dev-1' }).expect(200);
  assert.equal(d1.body.prefix, 'A');
  assert.equal(d2.body.prefix, 'B');
  assert.equal(d1again.body.prefix, 'A');
});

test('owner invites an employee; employee joins with default permissions', async () => {
  const owner = await login('owner@test.com');
  const emp = await login('emp@test.com');
  await createShop(owner.token, 'shop-1');

  await api().post('/v1/shops/shop-1/invites').set(auth(emp.token)).send({}).expect(404); // not a member yet
  const invite = await api().post('/v1/shops/shop-1/invites').set(auth(owner.token)).send({}).expect(201);
  assert.equal(invite.body.code.length, 8);

  const joined = await api().post('/v1/invites/accept').set(auth(emp.token)).send({ code: invite.body.code.toLowerCase() }).expect(200);
  assert.equal(joined.body.role, 'employee');
  assert.equal(joined.body.permissions.delete, false);

  // Code is single-use.
  const other = await login('other@test.com');
  await api().post('/v1/invites/accept').set(auth(other.token)).send({ code: invite.body.code }).expect(404);

  // Employee can't manage members; owner can deactivate the employee.
  await api().get('/v1/shops/shop-1/members').set(auth(emp.token)).expect(403);
  const members = await api().get('/v1/shops/shop-1/members').set(auth(owner.token)).expect(200);
  assert.equal(members.body.members.length, 2);
  await api().patch(`/v1/shops/shop-1/members/${emp.user.id}`).set(auth(owner.token)).send({ active: false }).expect(200);
  await api().get('/v1/shops/shop-1').set(auth(emp.token)).expect(404);
});

test('trial can be used once per account', async () => {
  const a = await login('a@test.com');
  await createShop(a.token, 'shop-1');
  await createShop(a.token, 'shop-2');
  const t = await api().post('/v1/shops/shop-1/trial').set(auth(a.token)).expect(200);
  assert.equal(t.body.entitlement.tier, 'installments_pro');
  assert.equal(t.body.entitlement.source, 'trial');
  await api().post('/v1/shops/shop-2/trial').set(auth(a.token)).expect(409);
});

test('account deletion removes owned shops and their data', async () => {
  const a = await login('a@test.com');
  await createShop(a.token, 'shop-1');
  await api().delete('/v1/me').set(auth(a.token)).send({}).expect(400);
  await api().delete('/v1/me').set(auth(a.token)).send({ confirm: 'DELETE' }).expect(204);
  assert.equal(await db.collection('shops').countDocuments({ id: 'shop-1' }), 0);
  assert.equal(await db.collection('users').countDocuments({}), 0);
});

test('several dev users and shops without a code can coexist (unique indexes)', async () => {
  const a = await login('a@test.com');
  const b = await login('b@test.com');
  assert.equal((await createShop(a.token, 'shop-a')).status, 201);
  assert.equal((await createShop(b.token, 'shop-b')).status, 201);
  const c = await login('c@test.com');
  assert.equal((await createShop(c.token, 'shop-c', { shopCode: 'ZZZZ99' })).status, 201);
  const d = await login('d@test.com');
  const dup = await createShop(d.token, 'shop-d', { shopCode: 'ZZZZ99' });
  assert.equal(dup.status, 201);
  assert.equal(dup.body.shop.shopCode, null, 'taken code is skipped, not an error');
});
