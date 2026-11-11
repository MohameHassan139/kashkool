import { Router } from 'express';
import { randomUUID } from 'node:crypto';
import { z } from 'zod';
import { config } from '../config.js';
import { getDb } from '../db.js';
import { requireAuth } from '../middleware/auth.js';
import { verifyGoogleIdToken } from '../services/google.js';
import { issueTokens, revokeRefreshToken, rotateRefreshToken } from '../services/tokens.js';
import { hashPassword, verifyPassword } from '../services/password.js';
import { deleteShopData } from '../services/shopData.js';
import { asyncHandler, badRequest, conflict, HttpError, notFound, parseBody } from '../utils/http.js';
import { rateLimit } from '../utils/rateLimit.js';

export const authRouter = Router();
const authLimiter = rateLimit({ windowMs: 15 * 60_000, max: 30 });
const emailAuthLimiter = rateLimit({ windowMs: 15 * 60_000, max: 10 });

const publicUser = (u) => ({ id: u.id, email: u.email, name: u.name, createdAt: u.createdAt });
const emailPasswordSchema = z.object({
  email: z.string().trim().email().max(254).transform((email) => email.toLowerCase()),
  password: z.string().min(8).max(128),
});

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

authRouter.post(
  '/v1/auth/email/register',
  emailAuthLimiter,
  asyncHandler(async (req, res) => {
    const body = parseBody(emailPasswordSchema.extend({ name: z.string().trim().min(1).max(80).optional() }), req.body);
    const db = await getDb();
    if (await db.collection('users').findOne({ email: body.email })) {
      throw conflict('email_already_registered', 'An account already uses this email');
    }

    const now = new Date();
    const credentials = await hashPassword(body.password);
    const user = {
      id: randomUUID(),
      email: body.email,
      name: body.name ?? null,
      googleSub: null,
      ...credentials,
      createdAt: now,
      lastLoginAt: now,
      trialUsedAt: null,
      deletedAt: null,
    };
    try {
      await db.collection('users').insertOne(user);
    } catch (error) {
      if (error?.code === 11000) throw conflict('email_already_registered', 'An account already uses this email');
      throw error;
    }
    res.status(201).json({ user: publicUser(user), ...(await issueTokens(db, user.id, 'email')) });
  }),
);

authRouter.post(
  '/v1/auth/email/login',
  emailAuthLimiter,
  asyncHandler(async (req, res) => {
    const body = parseBody(emailPasswordSchema, req.body);
    const db = await getDb();
    const user = await db.collection('users').findOne({ email: body.email, deletedAt: null });
    if (!user?.passwordHash || !user.passwordSalt || !(await verifyPassword(body.password, user.passwordSalt, user.passwordHash))) {
      throw new HttpError(401, 'invalid_credentials', 'Invalid email or password');
    }
    await db.collection('users').updateOne({ id: user.id }, { $set: { lastLoginAt: new Date() } });
    res.json({ user: publicUser(user), ...(await issueTokens(db, user.id, 'email')) });
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
