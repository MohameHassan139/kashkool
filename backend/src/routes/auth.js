import { Router } from 'express';
import { randomBytes, randomUUID, scryptSync, timingSafeEqual } from 'node:crypto';
import { z } from 'zod';
import { config } from '../config.js';
import { getDb } from '../db.js';
import { requireAuth } from '../middleware/auth.js';
import { verifyGoogleIdToken } from '../services/google.js';
import { issueTokens, revokeRefreshToken, rotateRefreshToken } from '../services/tokens.js';
import { deleteShopData } from '../services/shopData.js';
import { asyncHandler, badRequest, conflict, notFound, parseBody, unauthorized } from '../utils/http.js';
import { rateLimit } from '../utils/rateLimit.js';

export const authRouter = Router();
const authLimiter = rateLimit({ windowMs: 15 * 60_000, max: 30 });

const publicUser = (u) => ({ id: u.id, email: u.email, name: u.name, createdAt: u.createdAt });

function hashPassword(password) {
  const salt = randomBytes(16).toString('hex');
  const hash = scryptSync(password, salt, 64).toString('hex');
  return { hash, salt };
}

function verifyPassword(password, hash, salt) {
  if (!password || !hash || !salt) return false;
  const computed = scryptSync(password, salt, 64);
  const stored = Buffer.from(hash, 'hex');
  if (computed.length !== stored.length) return false;
  return timingSafeEqual(computed, stored);
}

async function upsertUser(db, { googleSub, email, name }) {
  const now = new Date();
  const filter = googleSub ? { googleSub } : { email, googleSub: null };
  const user = await db.collection('users').findOneAndUpdate(
    filter,
    {
      $set: { email, name, lastLoginAt: now },
      $setOnInsert: { id: randomUUID(), googleSub: googleSub ?? null, createdAt: now, trialUsedAt: null, deletedAt: null },
    },
    { upsert: true, returnDocument: 'after' },
  );
  return user;
}

/** Standard Email + Password Register */
authRouter.post(
  '/v1/auth/register',
  authLimiter,
  asyncHandler(async (req, res) => {
    const body = parseBody(
      z.object({
        email: z.string().email().max(120),
        password: z.string().min(6).max(128),
        name: z.string().trim().max(80).optional(),
        deviceLabel: z.string().max(80).optional(),
      }),
      req.body,
    );
    const email = body.email.toLowerCase().trim();
    const db = await getDb();
    const existing = await db.collection('users').findOne({ email, deletedAt: null });
    if (existing) {
      throw conflict('email_taken', 'Email is already registered');
    }
    const { hash, salt } = hashPassword(body.password);
    const now = new Date();
    const user = {
      id: randomUUID(),
      email,
      name: body.name?.trim() || null,
      passwordHash: hash,
      passwordSalt: salt,
      googleSub: null,
      createdAt: now,
      lastLoginAt: now,
      trialUsedAt: null,
      deletedAt: null,
    };
    await db.collection('users').insertOne(user);
    const tokens = await issueTokens(db, user.id, body.deviceLabel);
    res.status(201).json({ user: publicUser(user), ...tokens });
  }),
);

/** Standard Email + Password Login */
authRouter.post(
  '/v1/auth/login',
  authLimiter,
  asyncHandler(async (req, res) => {
    const body = parseBody(
      z.object({
        email: z.string().email(),
        password: z.string().min(1),
        deviceLabel: z.string().max(80).optional(),
      }),
      req.body,
    );
    const email = body.email.toLowerCase().trim();
    const db = await getDb();
    const user = await db.collection('users').findOne({ email, deletedAt: null });
    if (!user || !user.passwordHash || !verifyPassword(body.password, user.passwordHash, user.passwordSalt)) {
      throw badRequest('invalid_credentials', 'Invalid email or password');
    }
    const now = new Date();
    await db.collection('users').updateOne({ id: user.id }, { $set: { lastLoginAt: now } });
    const tokens = await issueTokens(db, user.id, body.deviceLabel);
    res.json({ user: publicUser(user), ...tokens });
  }),
);

/** Google Sign-In: the app sends the ID token it got from Google. */
authRouter.post(
  '/v1/auth/google',
  authLimiter,
  asyncHandler(async (req, res) => {
    const body = parseBody(z.object({ idToken: z.string().min(20), deviceLabel: z.string().max(80).optional() }), req.body);
    const profile = await verifyGoogleIdToken(body.idToken);
    const db = await getDb();
    const user = await upsertUser(db, profile);
    const tokens = await issueTokens(db, user.id, body.deviceLabel);
    res.json({ user: publicUser(user), ...tokens });
  }),
);

/** Local development only (ALLOW_DEV_LOGIN=true, never on Vercel). */
authRouter.post(
  '/v1/auth/dev',
  authLimiter,
  asyncHandler(async (req, res) => {
    if (!config.allowDevLogin) throw notFound();
    const body = parseBody(z.object({ email: z.string().email(), name: z.string().max(80).optional() }), req.body);
    const db = await getDb();
    const user = await upsertUser(db, { googleSub: null, email: body.email.toLowerCase(), name: body.name ?? null });
    res.json({ user: publicUser(user), ...(await issueTokens(db, user.id, 'dev')) });
  }),
);

authRouter.post(
  '/v1/auth/refresh',
  authLimiter,
  asyncHandler(async (req, res) => {
    const { refreshToken } = parseBody(z.object({ refreshToken: z.string().min(20) }), req.body);
    res.json(await rotateRefreshToken(await getDb(), refreshToken));
  }),
);

authRouter.post(
  '/v1/auth/logout',
  asyncHandler(async (req, res) => {
    const { refreshToken } = parseBody(z.object({ refreshToken: z.string().min(20) }), req.body);
    await revokeRefreshToken(await getDb(), refreshToken);
    res.status(204).end();
  }),
);

authRouter.get(
  '/v1/me',
  requireAuth,
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const user = await db.collection('users').findOne({ id: req.userId, deletedAt: null });
    if (!user) throw notFound('user_not_found');
    const memberships = await db.collection('members').find({ userId: req.userId, active: { $ne: false } }).toArray();
    res.json({ user: publicUser(user), shops: memberships.map((m) => ({ shopId: m.shopId, role: m.role })) });
  }),
);

/**
 * Account deletion (required by Google Play).
 * Deletes the user, their memberships, and ALL data of shops they own.
 */
authRouter.delete(
  '/v1/me',
  requireAuth,
  asyncHandler(async (req, res) => {
    const { confirm } = parseBody(z.object({ confirm: z.literal('DELETE') }), req.body);
    if (confirm !== 'DELETE') throw badRequest('confirmation_required');
    const db = await getDb();
    const owned = await db.collection('members').find({ userId: req.userId, role: 'owner' }).toArray();
    for (const m of owned) await deleteShopData(db, m.shopId);
    await db.collection('members').deleteMany({ userId: req.userId });
    await db.collection('refresh_tokens').deleteMany({ userId: req.userId });
    await db.collection('users').deleteOne({ id: req.userId });
    res.status(204).end();
  }),
);
