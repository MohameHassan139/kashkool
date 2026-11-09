/** Shared test setup: env, app, database (fake or real via MONGODB_TEST_URI). */
process.env.JWT_SECRET ||= 'test_secret_that_is_definitely_longer_than_32_chars';
process.env.MONGODB_URI ||= 'mongodb://unused-in-tests';
process.env.ALLOW_DEV_LOGIN = 'true';
process.env.PUBLIC_BASE_URL = 'https://kashkool.test';
process.env.CRON_SECRET = 'cron_test_secret';
delete process.env.VERCEL;

const { MongoClient } = await import('mongodb');
const { setDbForTesting, ensureIndexes } = await import('../../src/db.js');
const { createFakeDb } = await import('./fakeDb.js');
const { createApp } = await import('../../src/app.js');
const request = (await import('supertest')).default;

let realClient = null;

export async function freshDb() {
  let db;
  if (process.env.MONGODB_TEST_URI) {
    realClient ??= await new MongoClient(process.env.MONGODB_TEST_URI).connect();
    db = realClient.db(`kashkool_test_${Date.now()}_${Math.floor(Math.random() * 1e6)}`);
  } else {
    db = createFakeDb();
  }
  await ensureIndexes(db);
  setDbForTesting(db);
  return db;
}

export async function closeDb(db) {
  if (realClient && db?.dropDatabase) await db.dropDatabase();
}

export async function closeAll() {
  await realClient?.close();
  realClient = null;
}

export const app = createApp();
export const api = () => request(app);

export async function login(email) {
  const res = await api().post('/v1/auth/dev').send({ email, name: email.split('@')[0] }).expect(200);
  return { token: res.body.accessToken, refreshToken: res.body.refreshToken, user: res.body.user };
}

export const auth = (token) => ({ Authorization: `Bearer ${token}` });

export async function createShop(token, id = 'shop-1', extra = {}) {
  const res = await api().post('/v1/shops').set(auth(token)).send({ id, name: 'سوبر ماركت النور', type: 'grocery', ...extra });
  return res;
}

export const tx = (id, overrides = {}) => ({
  id,
  partyType: 'customer',
  partyId: 'cust-1',
  type: 'debt',
  amountPiasters: 10000,
  occurredAt: '2026-11-01T10:00:00.000Z',
  createdAt: '2026-11-01T10:00:00.000Z',
  updatedAt: '2026-11-01T10:00:00.000Z',
  deletedAt: null,
  ...overrides,
});

export async function push(token, shopId, changes, deviceId = 'device-a') {
  return api().post(`/v1/shops/${shopId}/sync/push`).set(auth(token)).send({ deviceId, changes });
}

export async function pull(token, shopId, since = 0, limit) {
  const q = limit ? `?since=${since}&limit=${limit}` : `?since=${since}`;
  return api().get(`/v1/shops/${shopId}/sync/pull${q}`).set(auth(token));
}
