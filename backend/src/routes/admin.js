import { Router } from 'express';
import { readFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import jwt from 'jsonwebtoken';
import { z } from 'zod';
import { config } from '../config.js';
import { getDb } from '../db.js';
import { buildOverview } from '../services/adminStats.js';
import { computeEntitlement, extendDate } from '../services/entitlement.js';
import { verifyGoogleIdToken } from '../services/google.js';
import { SYNC_COLLECTION_NAMES } from '../sync/collections.js';
import { readCookie, setCookie } from '../utils/cookies.js';
import { asyncHandler, forbidden, notFound, parseBody, unauthorized } from '../utils/http.js';
import { rateLimit } from '../utils/rateLimit.js';

/**
 * Internal admin dashboard (spec 22): /admin (web page) + /admin/api (JSON).
 *
 * - Sign-in with Google; only emails in ADMIN_EMAILS get in.
 * - Session = HttpOnly, SameSite=Strict cookie (8 hours).
 * - Admins see metadata only (counts, dates, tiers), never customers' names or amounts.
 * - Every change an admin makes is written to `admin_audit`.
 */
export const adminRouter = Router();

const COOKIE = 'kk_admin';
const PUBLIC_DIR = join(dirname(fileURLToPath(import.meta.url)), '..', 'admin', 'public');
const ASSETS = {
  '/admin': { file: 'index.html', type: 'text/html; charset=utf-8' },
  '/admin/app.js': { file: 'app.js', type: 'text/javascript; charset=utf-8' },
  '/admin/style.css': { file: 'style.css', type: 'text/css; charset=utf-8' },
};
const assetCache = new Map();

const ADMIN_CSP = [
  "default-src 'self'",
  "script-src 'self' https://accounts.google.com/gsi/client",
  // Inline style attributes are used for chart bar widths (all values are numbers we generate).
  "style-src 'self' 'unsafe-inline' https://accounts.google.com/gsi/style",
  "frame-src https://accounts.google.com/gsi/",
  "connect-src 'self' https://accounts.google.com/gsi/",
  "img-src 'self' data: https://*.googleusercontent.com",
  "base-uri 'none'",
  "form-action 'none'",
  "frame-ancestors 'none'",
].join('; ');

// ---------- web page ----------

for (const [route, asset] of Object.entries(ASSETS)) {
  adminRouter.get(route, (req, res) => {
    if (!assetCache.has(asset.file)) assetCache.set(asset.file, readFileSync(join(PUBLIC_DIR, asset.file)));
    res.set({
      'Content-Type': asset.type,
      'Content-Security-Policy': ADMIN_CSP,
      'Cache-Control': 'no-store',
      'X-Robots-Tag': 'noindex, nofollow',
      // Google's sign-in popup needs to talk back to this page.
      'Cross-Origin-Opener-Policy': 'same-origin-allow-popups',
    });
    res.send(assetCache.get(asset.file));
  });
}

// ---------- auth ----------

const isAllowed = (email) => config.adminEmails.includes(String(email || '').toLowerCase());

function startSession(req, res, email) {
  const token = jwt.sign({ typ: 'admin', email }, config.jwtSecret, {
    algorithm: 'HS256',
    issuer: 'kashkool-admin',
    expiresIn: config.adminSessionHours * 3600,
  });
  setCookie(res, COOKIE, token, { maxAgeSeconds: config.adminSessionHours * 3600, secure: req.secure, path: '/admin' });
}

const requireAdmin = asyncHandler(async (req, res, next) => {
  const token = readCookie(req, COOKIE);
  if (!token) throw unauthorized('Admin sign-in required');
  let payload;
  try {
    payload = jwt.verify(token, config.jwtSecret, { algorithms: ['HS256'], issuer: 'kashkool-admin' });
  } catch {
    throw unauthorized('Admin session expired');
  }
  // Re-check the allowlist on every request, so removing an email locks it out immediately.
  if (payload.typ !== 'admin' || !isAllowed(payload.email)) throw forbidden('not_admin', 'This account is not an admin');
  // Extra CSRF guard on top of SameSite=Strict: changes must come from our own page.
  if (req.method !== 'GET' && req.get('x-kashkool-admin') !== '1') throw forbidden('csrf', 'Missing admin header');
  req.adminEmail = payload.email;
  next();
});

async function audit(db, req, action, target, details) {
  await db.collection('admin_audit').insertOne({
    adminEmail: req.adminEmail,
    action,
    target: target ?? null,
    details: details ?? null,
    ip: req.ip,
    createdAt: new Date(),
  });
}

const loginLimiter = rateLimit({ windowMs: 15 * 60_000, max: 20 });

adminRouter.get('/admin/api/public-config', (req, res) => {
  res.json({ googleClientId: config.googleClientIds[0] ?? null, devLogin: config.allowDevLogin });
});

adminRouter.post(
  '/admin/api/login',
  loginLimiter,
  asyncHandler(async (req, res) => {
    const { credential } = parseBody(z.object({ credential: z.string().min(20) }), req.body);
    const profile = await verifyGoogleIdToken(credential);
    if (!isAllowed(profile.email)) throw forbidden('not_admin', 'This Google account is not allowed');
    startSession(req, res, profile.email);
    req.adminEmail = profile.email;
    await audit(await getDb(), req, 'login');
    res.json({ email: profile.email });
  }),
);

/** Local development only (ALLOW_DEV_LOGIN=true, never on Vercel). */
adminRouter.post(
  '/admin/api/dev-login',
  asyncHandler(async (req, res) => {
    if (!config.allowDevLogin) throw notFound();
    const { email } = parseBody(z.object({ email: z.string().email() }), req.body);
    if (!isAllowed(email)) throw forbidden('not_admin', 'Not in ADMIN_EMAILS');
    startSession(req, res, email.toLowerCase());
    res.json({ email: email.toLowerCase() });
  }),
);

adminRouter.post('/admin/api/logout', (req, res) => {
  setCookie(res, COOKIE, '', { maxAgeSeconds: 0, secure: req.secure, path: '/admin' });
  res.status(204).end();
});

adminRouter.get('/admin/api/me', requireAdmin, (req, res) => res.json({ email: req.adminEmail }));

// ---------- data ----------

adminRouter.get(
  '/admin/api/overview',
  requireAdmin,
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const since = new Date(Date.now() - 31 * 86400_000).toISOString().slice(0, 10);
    const [shops, members, users, subscriptions, referrals, activity] = await Promise.all([
      db.collection('shops').find({ deletedAt: null }).toArray(),
      db.collection('members').find({}).toArray(),
      db.collection('users').find({ deletedAt: null }).toArray(),
      db.collection('subscriptions').find({}).toArray(),
      db.collection('referrals').find({}).toArray(),
      db.collection('shop_activity').find({ day: { $gte: since } }).toArray(),
    ]);
    res.json(buildOverview({ shops, members, users, subscriptions, referrals, activity, tierPrices: config.tierPrices }));
  }),
);

function shopSummary(shop, owner, subs, memberCount) {
  const ent = computeEntitlement({ subscriptions: subs, shop });
  return {
    id: shop.id,
    name: shop.name,
    type: shop.type,
    ownerEmail: owner?.email ?? null,
    createdAt: shop.createdAt,
    lastSyncAt: shop.lastSyncAt ?? null,
    tier: ent.tier,
    tierSource: ent.source,
    tierExpiresAt: ent.expiresAt,
    members: memberCount,
    devices: (shop.devices || []).length,
  };
}

adminRouter.get(
  '/admin/api/shops',
  requireAdmin,
  asyncHandler(async (req, res) => {
    const q = parseBody(
      z.object({
        q: z.string().trim().max(100).optional(),
        sort: z.enum(['newest', 'lastSync', 'name']).default('newest'),
        page: z.coerce.number().int().min(1).default(1),
      }),
      req.query,
    );
    const db = await getDb();
    const pageSize = 50;
    let shops = await db.collection('shops').find({ deletedAt: null }).toArray();
    const users = await db.collection('users').find({}, { projection: { id: 1, email: 1 } }).toArray();
    const userById = new Map(users.map((u) => [u.id, u]));

    if (q.q) {
      const needle = q.q.toLowerCase();
      shops = shops.filter(
        (s) =>
          String(s.name || '').toLowerCase().includes(needle) ||
          String(userById.get(s.ownerUserId)?.email || '').includes(needle) ||
          s.id === q.q ||
          String(s.shopCode || '').toLowerCase() === needle,
      );
    }
    const time = (d) => (d ? new Date(d).getTime() : 0);
    shops.sort((a, b) =>
      q.sort === 'name'
        ? String(a.name).localeCompare(String(b.name), 'ar')
        : q.sort === 'lastSync'
          ? time(b.lastSyncAt) - time(a.lastSyncAt)
          : time(b.createdAt) - time(a.createdAt),
    );

    const total = shops.length;
    const pageShops = shops.slice((q.page - 1) * pageSize, q.page * pageSize);
    const ids = pageShops.map((s) => s.id);
    const [subs, members] = await Promise.all([
      db.collection('subscriptions').find({ shopId: { $in: ids } }).toArray(),
      db.collection('members').find({ shopId: { $in: ids }, active: { $ne: false } }).toArray(),
    ]);
    res.json({
      total,
      page: q.page,
      pageSize,
      shops: pageShops.map((s) =>
        shopSummary(
          s,
          userById.get(s.ownerUserId),
          subs.filter((x) => x.shopId === s.id),
          members.filter((m) => m.shopId === s.id).length,
        ),
      ),
    });
  }),
);

adminRouter.get(
  '/admin/api/shops/:shopId',
  requireAdmin,
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const shop = await db.collection('shops').findOne({ id: req.params.shopId });
    if (!shop) throw notFound('shop_not_found');
    const [members, subs, referralsIn, referralsOut] = await Promise.all([
      db.collection('members').find({ shopId: shop.id }).toArray(),
      db.collection('subscriptions').find({ shopId: shop.id }).toArray(),
      db.collection('referrals').findOne({ referredShopId: shop.id }),
      db.collection('referrals').find({ referrerShopId: shop.id }).toArray(),
    ]);
    const users = await db.collection('users').find({ id: { $in: members.map((m) => m.userId) } }).toArray();
    const userById = new Map(users.map((u) => [u.id, u]));

    // Counts only — no customer names or amounts.
    const counts = {};
    await Promise.all(
      SYNC_COLLECTION_NAMES.map(async (name) => {
        counts[name] = await db.collection(name).countDocuments({ shopId: shop.id, deletedAt: null });
      }),
    );
    const activity = await db.collection('shop_activity').find({ shopId: shop.id }).sort({ day: -1 }).limit(30).toArray();

    res.json({
      shop: {
        ...shopSummary(shop, userById.get(shop.ownerUserId), subs, members.filter((m) => m.active !== false).length),
        phone: shop.phone ?? null,
        shopCode: shop.shopCode ?? null,
        trialEndsAt: shop.trialEndsAt ?? null,
        bonusProUntil: shop.bonusProUntil ?? null,
        syncSequence: shop.seq ?? 0,
      },
      members: members.map((m) => ({
        email: userById.get(m.userId)?.email ?? null,
        role: m.role,
        active: m.active !== false,
        createdAt: m.createdAt,
      })),
      devices: (shop.devices || []).map((d) => ({ prefix: d.prefix, label: d.label ?? null, firstSeenAt: d.firstSeenAt })),
      subscriptions: subs.map((s) => ({ tier: s.tier, state: s.state, productId: s.productId, expiresAt: s.expiresAt, updatedAt: s.updatedAt })),
      referredBy: referralsIn ? { status: referralsIn.status, createdAt: referralsIn.createdAt } : null,
      referralsMade: referralsOut.map((r) => ({ status: r.status, createdAt: r.createdAt, rewardedAt: r.rewardedAt })),
      recordCounts: counts,
      activeDays: activity.map((a) => a.day),
    });
  }),
);

/** Gives a shop free Pro days (support / compensation). */
adminRouter.post(
  '/admin/api/shops/:shopId/grant',
  requireAdmin,
  asyncHandler(async (req, res) => {
    const body = parseBody(z.object({ days: z.number().int().min(1).max(365), reason: z.string().trim().min(3).max(200) }), req.body);
    const db = await getDb();
    const shop = await db.collection('shops').findOne({ id: req.params.shopId });
    if (!shop) throw notFound('shop_not_found');
    const bonusProUntil = extendDate(shop.bonusProUntil, body.days);
    await db.collection('shops').updateOne({ id: shop.id }, { $set: { bonusProUntil } });
    await audit(db, req, 'grant_pro_days', shop.id, { days: body.days, reason: body.reason, bonusProUntil });
    res.json({ bonusProUntil });
  }),
);

adminRouter.get(
  '/admin/api/subscriptions',
  requireAdmin,
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const subs = await db.collection('subscriptions').find({}).sort({ updatedAt: -1 }).limit(500).toArray();
    const shops = await db.collection('shops').find({ id: { $in: subs.map((s) => s.shopId) } }, { projection: { id: 1, name: 1 } }).toArray();
    const nameById = new Map(shops.map((s) => [s.id, s.name]));
    res.json({
      subscriptions: subs.map((s) => ({
        shopId: s.shopId,
        shopName: nameById.get(s.shopId) ?? null,
        tier: s.tier,
        state: s.state,
        productId: s.productId,
        expiresAt: s.expiresAt,
        lastNotificationType: s.lastNotificationType ?? null,
        updatedAt: s.updatedAt,
      })),
    });
  }),
);

adminRouter.get(
  '/admin/api/referrals',
  requireAdmin,
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const refs = await db.collection('referrals').find({}).sort({ createdAt: -1 }).limit(500).toArray();
    const ids = [...new Set(refs.flatMap((r) => [r.referrerShopId, r.referredShopId]))];
    const shops = await db.collection('shops').find({ id: { $in: ids } }, { projection: { id: 1, name: 1 } }).toArray();
    const nameById = new Map(shops.map((s) => [s.id, s.name]));
    res.json({
      referrals: refs.map((r) => ({
        referrerShopId: r.referrerShopId,
        referrerName: nameById.get(r.referrerShopId) ?? null,
        referredShopId: r.referredShopId,
        referredName: nameById.get(r.referredShopId) ?? null,
        status: r.status,
        createdAt: r.createdAt,
        rewardedAt: r.rewardedAt,
      })),
    });
  }),
);

const configSchema = z.object({
  minSupportedVersion: z.string().regex(/^\d+\.\d+\.\d+$/),
  latestVersion: z.string().regex(/^\d+\.\d+\.\d+$/),
  flags: z.record(z.string().regex(/^[A-Za-z0-9_]{1,40}$/), z.union([z.boolean(), z.number(), z.string().max(200)])),
  announcement: z
    .object({ text: z.string().trim().min(1).max(300), level: z.enum(['info', 'warning']).default('info') })
    .nullable(),
});

adminRouter.get(
  '/admin/api/config',
  requireAdmin,
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const doc = await db.collection('app_config').findOne({ _id: 'global' });
    const { _id, ...rest } = doc || {};
    res.json({ minSupportedVersion: '1.0.0', latestVersion: '1.0.0', flags: {}, announcement: null, ...rest });
  }),
);

adminRouter.put(
  '/admin/api/config',
  requireAdmin,
  asyncHandler(async (req, res) => {
    const body = parseBody(configSchema, req.body);
    const db = await getDb();
    await db
      .collection('app_config')
      .updateOne({ _id: 'global' }, { $set: { ...body, updatedAt: new Date(), updatedBy: req.adminEmail } }, { upsert: true });
    await audit(db, req, 'update_config', 'global', body);
    res.json(body);
  }),
);

adminRouter.get(
  '/admin/api/audit',
  requireAdmin,
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const rows = await db.collection('admin_audit').find({}).sort({ createdAt: -1 }).limit(200).toArray();
    res.json({ entries: rows.map(({ _id, ip, ...r }) => r) });
  }),
);
