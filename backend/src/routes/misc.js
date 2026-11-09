import { Router } from 'express';
import { config } from '../config.js';
import { getDb, pingDb } from '../db.js';
import { qualifyReferrals } from '../services/referrals.js';
import { safeEqual } from '../utils/crypto.js';
import { asyncHandler, unauthorized } from '../utils/http.js';

export const miscRouter = Router();

miscRouter.get('/', (req, res) => res.json({ name: 'kashkool-backend', status: 'ok' }));

miscRouter.get(
  '/health',
  asyncHandler(async (req, res) => {
    await pingDb();
    res.json({ status: 'ok', db: 'ok', time: new Date().toISOString() });
  }),
);

const DEFAULT_APP_CONFIG = {
  minSupportedVersion: '1.0.0',
  latestVersion: '1.0.0',
  flags: {},
  announcement: null,
};

/**
 * Remote config (feature flags, forced update, announcements).
 * Edit the document `{ _id: "global" }` in the `app_config` collection in MongoDB Atlas.
 */
miscRouter.get(
  '/v1/config',
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const doc = await db.collection('app_config').findOne({ _id: 'global' });
    // Never expose who edited it or when.
    const { _id, updatedBy, updatedAt, ...rest } = doc || {};
    res.set('Cache-Control', 'public, max-age=300');
    res.json({ ...DEFAULT_APP_CONFIG, ...rest, subscriptionRequired: config.requireSubscription });
  }),
);

/** Vercel Cron (see vercel.json). Vercel sends `Authorization: Bearer <CRON_SECRET>`. */
miscRouter.get(
  '/api/cron/referrals',
  asyncHandler(async (req, res) => {
    const expected = config.cronSecret ? `Bearer ${config.cronSecret}` : null;
    if (!expected || !safeEqual(req.get('authorization'), expected)) throw unauthorized('Bad cron secret');
    res.json(await qualifyReferrals(await getDb()));
  }),
);
