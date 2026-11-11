import { MongoClient } from 'mongodb';
import { config, assertConfig } from './config.js';
import { SYNC_COLLECTION_NAMES } from './sync/collections.js';

/**
 * Serverless-friendly MongoDB connection: the client is created once per warm
 * function instance and reused across requests.
 */
let client = null;
let dbPromise = null;
let testDb = null;

/** Tests inject an in-memory database here. */
export function setDbForTesting(db) {
  testDb = db;
}

export async function getDb() {
  if (testDb) return testDb;
  if (!dbPromise) {
    assertConfig();
    client = new MongoClient(config.mongoUri, {
      maxPoolSize: 10,
      serverSelectionTimeoutMS: 8000,
      appName: 'kashkool-backend',
    });
    dbPromise = client
      .connect()
      .then(async (c) => {
        const db = c.db(config.dbName);
        await ensureIndexes(db);
        return db;
      })
      .catch((err) => {
        dbPromise = null;
        client = null;
        throw err;
      });
  }
  return dbPromise;
}

/**
 * Runs `fn(session)` inside a MongoDB transaction (Atlas is a replica set).
 * In tests (no real client) it runs `fn(undefined)` directly.
 */
export async function withTransaction(fn) {
  const db = await getDb();
  if (testDb || !client) return fn(undefined, db);
  const session = client.startSession();
  try {
    let result;
    await session.withTransaction(async () => {
      result = await fn(session, db);
    });
    return result;
  } finally {
    await session.endSession();
  }
}

export async function ensureIndexes(db) {
  const tasks = [
    db.collection('users').createIndex(
      { googleSub: 1 },
      { unique: true, partialFilterExpression: { googleSub: { $type: 'string' } } },
    ),
    db.collection('users').createIndex({ email: 1 }),
    db.collection('users').createIndex(
      { email: 1 },
      { unique: true, partialFilterExpression: { passwordHash: { $type: 'string' } } },
    ),
    db.collection('refresh_tokens').createIndex({ tokenHash: 1 }, { unique: true }),
    db.collection('refresh_tokens').createIndex({ expiresAt: 1 }, { expireAfterSeconds: 0 }),
    db.collection('shops').createIndex({ id: 1 }, { unique: true }),
    db.collection('shops').createIndex(
      { shopCode: 1 },
      { unique: true, partialFilterExpression: { shopCode: { $type: 'string' } } },
    ),
    db.collection('members').createIndex({ shopId: 1, userId: 1 }, { unique: true }),
    db.collection('members').createIndex({ userId: 1 }),
    db.collection('invites').createIndex({ codeHash: 1 }, { unique: true }),
    db.collection('invites').createIndex({ expiresAt: 1 }, { expireAfterSeconds: 0 }),
    db.collection('statement_links').createIndex({ tokenHash: 1 }, { unique: true }),
    db.collection('statement_links').createIndex({ shopId: 1, customerId: 1 }),
    db.collection('referrals').createIndex({ referredShopId: 1 }, { unique: true }),
    db.collection('referrals').createIndex({ referrerShopId: 1 }),
    db.collection('referrals').createIndex({ status: 1 }),
    db.collection('subscriptions').createIndex({ purchaseTokenHash: 1 }, { unique: true }),
    db.collection('subscriptions').createIndex({ shopId: 1 }),
    db.collection('shop_activity').createIndex({ shopId: 1, day: 1 }, { unique: true }),
    db.collection('shop_activity').createIndex({ day: 1 }),
    db.collection('admin_audit').createIndex({ createdAt: -1 }),
  ];
  for (const name of SYNC_COLLECTION_NAMES) {
    tasks.push(db.collection(name).createIndex({ shopId: 1, id: 1 }, { unique: true }));
    tasks.push(db.collection(name).createIndex({ shopId: 1, serverSeq: 1 }));
  }
  await Promise.all(tasks);
}

export async function pingDb() {
  const db = await getDb();
  if (testDb) return true;
  await db.command({ ping: 1 });
  return true;
}
