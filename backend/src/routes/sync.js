import { Router } from 'express';
import { z } from 'zod';
import { getDb, withTransaction } from '../db.js';
import { requireAuth, requireMember, requireTier } from '../middleware/auth.js';
import { canRead, checkWritePermission } from '../services/permissions.js';
import {
  SYNC_COLLECTIONS,
  SYNC_COLLECTION_NAMES,
  filterForReader,
  planWrite,
  sanitizeRecord,
} from '../sync/collections.js';
import { asyncHandler, parseBody } from '../utils/http.js';

export const syncRouter = Router();

const MAX_PUSH = 500;
const DEFAULT_PULL = 500;
const MAX_PULL = 1000;

const pushSchema = z.object({
  deviceId: z.string().regex(/^[A-Za-z0-9_\-]{1,64}$/),
  changes: z
    .array(z.object({ collection: z.enum(SYNC_COLLECTION_NAMES), record: z.record(z.string(), z.unknown()) }))
    .max(MAX_PUSH),
});

/**
 * PUSH — the app uploads local changes.
 *
 * Every accepted row gets a per-shop, ever-increasing `serverSeq`, assigned inside one
 * transaction together with the writes. Pull uses `serverSeq` as its cursor, so a device
 * never misses or double-applies a change, and device clocks are never trusted.
 *
 * Response: one result per change, in the same order:
 *   { collection, id, status: 'inserted' | 'updated' | 'unchanged' | 'rejected', reason? }
 */
syncRouter.post(
  '/v1/shops/:shopId/sync/push',
  requireAuth,
  requireMember(),
  requireTier('pro'),
  asyncHandler(async (req, res) => {
    const { deviceId, changes } = parseBody(pushSchema, req.body);
    const shopId = req.shop.id;
    const results = changes.map((c) => ({ collection: c.collection, id: c.record?.id ?? null, status: 'pending' }));

    // 1) Validate every record (no DB access).
    const valid = [];
    changes.forEach((change, index) => {
      const { record, error } = sanitizeRecord(change.collection, change.record);
      if (error) {
        results[index] = { ...results[index], status: 'rejected', reason: error };
      } else {
        valid.push({ index, collection: change.collection, record });
      }
    });

    // The same row twice in one batch: keep the last one.
    const lastIndexByKey = new Map();
    for (const v of valid) lastIndexByKey.set(`${v.collection}:${v.record.id}`, v.index);
    const toWrite = valid.filter((v) => {
      const keep = lastIndexByKey.get(`${v.collection}:${v.record.id}`) === v.index;
      if (!keep) results[v.index] = { ...results[v.index], status: 'unchanged', reason: 'duplicate_in_batch' };
      return keep;
    });

    if (toWrite.length > 0) {
      await withTransaction(async (session, db) => {
        // 2) Load existing rows per collection.
        const existingByKey = new Map();
        const byCollection = new Map();
        for (const v of toWrite) {
          if (!byCollection.has(v.collection)) byCollection.set(v.collection, []);
          byCollection.get(v.collection).push(v.record.id);
        }
        for (const [name, ids] of byCollection) {
          const rows = await db.collection(name).find({ shopId, id: { $in: ids } }, { session }).toArray();
          for (const row of rows) existingByKey.set(`${name}:${row.id}`, row);
        }

        // 3) Decide each write (permissions + append-only rules).
        const writes = [];
        const now = new Date();
        for (const v of toWrite) {
          const def = SYNC_COLLECTIONS[v.collection];
          const existing = existingByKey.get(`${v.collection}:${v.record.id}`);
          const denied = checkWritePermission({
            collection: v.collection,
            def,
            member: req.member,
            incoming: v.record,
            existing,
            userId: req.userId,
            now: now.getTime(),
          });
          if (denied) {
            results[v.index] = { ...results[v.index], status: 'rejected', reason: denied };
            continue;
          }
          const plan = planWrite(v.collection, v.record, existing);
          if (plan.op === 'unchanged') {
            results[v.index] = { ...results[v.index], status: 'unchanged' };
            continue;
          }
          writes.push({ ...v, plan });
        }
        if (writes.length === 0) return;

        // 4) Reserve a block of sequence numbers for this shop.
        const shop = await reserveSeq(db, shopId, writes.length, session);
        let seq = shop.seq - writes.length;

        // 5) Apply.
        for (const w of writes) {
          seq += 1;
          const coll = db.collection(w.collection);
          if (w.plan.op === 'insert') {
            const doc = {
              ...w.plan.doc,
              shopId,
              deviceId: w.plan.doc.deviceId || deviceId,
              createdBy: req.userId,
              pushedBy: req.userId,
              serverSeq: seq,
              serverCreatedAt: now,
              serverUpdatedAt: now,
            };
            if (doc.deletedAt === undefined) doc.deletedAt = null;
            await coll.insertOne(doc, { session });
            results[w.index] = { ...results[w.index], status: 'inserted' };
          } else {
            await coll.updateOne(
              { shopId, id: w.record.id },
              { $set: { ...w.plan.set, serverSeq: seq, serverUpdatedAt: now } },
              { session },
            );
            results[w.index] = { ...results[w.index], status: 'updated' };
          }
        }
      });
    }

    const db = await getDb();
    const shop = await db
      .collection('shops')
      .findOneAndUpdate({ id: shopId }, { $set: { lastSyncAt: new Date() } }, { returnDocument: 'after', projection: { seq: 1 } });
    // One row per shop per day the shop synced (daily active shops in the admin dashboard).
    const day = new Date().toISOString().slice(0, 10);
    await db
      .collection('shop_activity')
      .updateOne({ shopId, day }, { $setOnInsert: { shopId, day, createdAt: new Date() } }, { upsert: true });
    res.json({ results, serverSeq: shop?.seq ?? 0, serverTime: new Date().toISOString() });
  }),
);

/**
 * PULL — the app downloads every change after `since` (its last cursor).
 * Call repeatedly until `hasMore` is false; save `cursor` locally after applying each page.
 * For a brand-new device, start with since=0.
 */
syncRouter.get(
  '/v1/shops/:shopId/sync/pull',
  requireAuth,
  requireMember(),
  requireTier('pro'),
  asyncHandler(async (req, res) => {
    const q = parseBody(
      z.object({
        since: z.coerce.number().int().min(0).default(0),
        limit: z.coerce.number().int().min(1).max(MAX_PULL).default(DEFAULT_PULL),
      }),
      req.query,
    );
    const db = await getDb();
    const shopId = req.shop.id;
    const readable = SYNC_COLLECTION_NAMES.filter((name) => canRead(req.member, SYNC_COLLECTIONS[name]));

    const batches = await Promise.all(
      readable.map(async (name) => {
        const rows = await db
          .collection(name)
          .find({ shopId, serverSeq: { $gt: q.since } })
          .sort({ serverSeq: 1 })
          .limit(q.limit + 1)
          .toArray();
        return rows.map((row) => ({ collection: name, row }));
      }),
    );

    const merged = batches.flat().sort((a, b) => a.row.serverSeq - b.row.serverSeq);
    const page = merged.slice(0, q.limit);
    const hasMore = merged.length > q.limit;

    const employeeHidesSuppliers = req.member.role !== 'owner' && !req.member.permissions?.suppliers;
    const changes = [];
    for (const { collection, row } of page) {
      if (employeeHidesSuppliers && collection === 'transactions' && row.partyType === 'supplier') continue;
      changes.push({ collection, record: filterForReader(collection, row, req.member) });
    }

    const cursor = page.length ? page[page.length - 1].row.serverSeq : q.since;
    res.json({ changes, cursor, hasMore, serverTime: new Date().toISOString() });
  }),
);

/** Atomically reserves `count` sequence numbers; returns the shop with the new `seq`. */
export async function reserveSeq(db, shopId, count, session) {
  return db
    .collection('shops')
    .findOneAndUpdate({ id: shopId }, { $inc: { seq: count } }, { returnDocument: 'after', session });
}
