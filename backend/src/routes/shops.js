import { Router } from 'express';
import { z } from 'zod';
import { config } from '../config.js';
import { getDb } from '../db.js';
import { loadEntitlement, requireAuth, requireMember } from '../middleware/auth.js';
import { extendDate } from '../services/entitlement.js';
import { EMPLOYEE_DEFAULT_PERMISSIONS, PERMISSION_KEYS } from '../services/permissions.js';
import { devicePrefixFor } from '../services/shopData.js';
import { randomCode, sha256 } from '../utils/crypto.js';
import { asyncHandler, badRequest, conflict, forbidden, notFound, parseBody } from '../utils/http.js';
import { rateLimit } from '../utils/rateLimit.js';

export const shopsRouter = Router();
shopsRouter.use('/v1/shops', requireAuth);
shopsRouter.use('/v1/invites', requireAuth);

const SHOP_TYPES = ['grocery', 'mobile', 'electronics', 'furniture', 'pharmacy', 'spare_parts', 'other'];
const idSchema = z.string().regex(/^[A-Za-z0-9_\-]{1,64}$/);

const publicShop = (s) => ({
  id: s.id,
  name: s.name,
  type: s.type,
  phone: s.phone ?? null,
  address: s.address ?? null,
  paymentInfo: s.paymentInfo ?? null,
  shopCode: s.shopCode ?? null,
  trialEndsAt: s.trialEndsAt ?? null,
  bonusProUntil: s.bonusProUntil ?? null,
  createdAt: s.createdAt,
});

const shopFields = {
  name: z.string().trim().min(1).max(80),
  type: z.enum(SHOP_TYPES).default('other'),
  phone: z.string().max(20).nullish(),
  address: z.string().max(200).nullish(),
  paymentInfo: z.string().max(300).nullish(),
};

/**
 * Registers the local shop on the server (first time cloud is enabled).
 * `id` is the shopId the app already uses locally, so no local data has to change.
 */
shopsRouter.post(
  '/v1/shops',
  asyncHandler(async (req, res) => {
    const body = parseBody(
      z.object({ id: idSchema, ...shopFields, shopCode: z.string().regex(/^[A-Za-z0-9]{4,12}$/).optional() }),
      req.body,
    );
    const db = await getDb();

    // 1 Account = 1 Shop rule:
    // If the user already owns an active shop, return their existing shop.
    const userOwnedShop = await db.collection('shops').findOne({ ownerUserId: req.userId, deletedAt: null });
    if (userOwnedShop) {
      return res.json({ shop: publicShop(userOwnedShop), created: false });
    }

    // If the user is already a member of an active shop, return that shop.
    const userMember = await db.collection('members').findOne({ userId: req.userId, active: { $ne: false } });
    if (userMember) {
      const memberShop = await db.collection('shops').findOne({ id: userMember.shopId, deletedAt: null });
      if (memberShop) {
        return res.json({ shop: publicShop(memberShop), created: false });
      }
    }

    const existing = await db.collection('shops').findOne({ id: body.id });
    if (existing) {
      const member = await db.collection('members').findOne({ shopId: body.id, userId: req.userId, active: { $ne: false } });
      if (!member) throw conflict('shop_id_taken', 'This shop is registered to another account');
      return res.json({ shop: publicShop(existing), created: false });
    }
    const now = new Date();
    const shop = {
      id: body.id,
      name: body.name,
      type: body.type,
      phone: body.phone ?? null,
      address: body.address ?? null,
      paymentInfo: body.paymentInfo ?? null,
      ownerUserId: req.userId,
      seq: 0,
      deviceCounter: 0,
      devices: [],
      trialEndsAt: null,
      bonusProUntil: null,
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    };
    if (body.shopCode) {
      const taken = await db.collection('shops').findOne({ shopCode: body.shopCode.toUpperCase() });
      if (!taken) shop.shopCode = body.shopCode.toUpperCase();
    }
    await db.collection('shops').insertOne(shop);
    await db.collection('members').insertOne({
      shopId: shop.id,
      userId: req.userId,
      role: 'owner',
      permissions: {},
      active: true,
      createdAt: now,
    });
    res.status(201).json({ shop: publicShop(shop), created: true });
  }),
);

shopsRouter.get(
  '/v1/shops',
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const members = await db.collection('members').find({ userId: req.userId, active: { $ne: false } }).toArray();
    const ids = members.map((m) => m.shopId);
    const shops = ids.length ? await db.collection('shops').find({ id: { $in: ids }, deletedAt: null }).toArray() : [];
    const roleOf = Object.fromEntries(members.map((m) => [m.shopId, m.role]));
    res.json({ shops: shops.map((s) => ({ ...publicShop(s), role: roleOf[s.id] })) });
  }),
);

shopsRouter.get(
  '/v1/shops/:shopId',
  requireMember(),
  asyncHandler(async (req, res) => {
    const db = await getDb();
    res.json({
      shop: publicShop(req.shop),
      role: req.member.role,
      permissions: req.member.role === 'owner' ? null : req.member.permissions,
      entitlement: await loadEntitlement(db, req.shop),
    });
  }),
);

shopsRouter.patch(
  '/v1/shops/:shopId',
  requireMember({ ownerOnly: true }),
  asyncHandler(async (req, res) => {
    const body = parseBody(z.object(shopFields).partial(), req.body);
    const db = await getDb();
    const shop = await db.collection('shops').findOneAndUpdate(
      { id: req.shop.id },
      { $set: { ...body, updatedAt: new Date() } },
      { returnDocument: 'after' },
    );
    res.json({ shop: publicShop(shop) });
  }),
);

/** Registers a device and returns its letter prefix (A, B, …) for offline-safe plan numbers. */
shopsRouter.post(
  '/v1/shops/:shopId/devices',
  requireMember(),
  asyncHandler(async (req, res) => {
    const { deviceId, label } = parseBody(z.object({ deviceId: idSchema, label: z.string().max(60).optional() }), req.body);
    const db = await getDb();
    const found = req.shop.devices?.find((d) => d.deviceId === deviceId);
    if (found) return res.json({ deviceId, prefix: found.prefix });

    const shop = await db.collection('shops').findOneAndUpdate(
      { id: req.shop.id, 'devices.deviceId': { $ne: deviceId } },
      { $inc: { deviceCounter: 1 } },
      { returnDocument: 'after' },
    );
    if (!shop) {
      const again = await db.collection('shops').findOne({ id: req.shop.id });
      const d = again.devices.find((x) => x.deviceId === deviceId);
      return res.json({ deviceId, prefix: d?.prefix });
    }
    const prefix = devicePrefixFor(shop.deviceCounter - 1);
    await db.collection('shops').updateOne(
      { id: req.shop.id },
      { $push: { devices: { deviceId, prefix, userId: req.userId, label: label ?? null, firstSeenAt: new Date() } } },
    );
    res.status(201).json({ deviceId, prefix });
  }),
);

// ---------- Employees (spec 15) ----------

shopsRouter.post(
  '/v1/shops/:shopId/invites',
  requireMember({ ownerOnly: true }),
  asyncHandler(async (req, res) => {
    const body = parseBody(
      z.object({ permissions: z.partialRecord(z.enum(PERMISSION_KEYS), z.boolean()).optional() }),
      req.body ?? {},
    );
    const db = await getDb();
    const code = randomCode(8);
    const expiresAt = new Date(Date.now() + 48 * 3600_000);
    await db.collection('invites').insertOne({
      codeHash: sha256(code),
      shopId: req.shop.id,
      role: 'employee',
      permissions: { ...EMPLOYEE_DEFAULT_PERMISSIONS, ...(body.permissions || {}) },
      createdBy: req.userId,
      usedBy: null,
      createdAt: new Date(),
      expiresAt,
    });
    res.status(201).json({ code, expiresAt });
  }),
);

shopsRouter.post(
  '/v1/invites/accept',
  rateLimit({ windowMs: 15 * 60_000, max: 20, keyFn: (req) => req.userId }),
  asyncHandler(async (req, res) => {
    const { code } = parseBody(z.object({ code: z.string().trim().toUpperCase().pipe(z.string().length(8)) }), req.body);
    const db = await getDb();
    const invite = await db.collection('invites').findOneAndUpdate(
      { codeHash: sha256(code), usedBy: null, expiresAt: { $gt: new Date() } },
      { $set: { usedBy: req.userId, usedAt: new Date() } },
      { returnDocument: 'after' },
    );
    if (!invite) throw notFound('invite_invalid', 'Invite code is invalid or expired');
    const existing = await db.collection('members').findOne({ shopId: invite.shopId, userId: req.userId });
    if (existing) {
      if (existing.role === 'owner') throw badRequest('already_owner', 'You already own this shop');
      await db.collection('members').updateOne(
        { shopId: invite.shopId, userId: req.userId },
        { $set: { active: true, permissions: invite.permissions } },
      );
    } else {
      await db.collection('members').insertOne({
        shopId: invite.shopId,
        userId: req.userId,
        role: 'employee',
        permissions: invite.permissions,
        active: true,
        createdAt: new Date(),
      });
    }
    const shop = await db.collection('shops').findOne({ id: invite.shopId });
    res.json({ shop: publicShop(shop), role: 'employee', permissions: invite.permissions });
  }),
);

shopsRouter.get(
  '/v1/shops/:shopId/members',
  requireMember({ ownerOnly: true }),
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const members = await db.collection('members').find({ shopId: req.shop.id }).toArray();
    const users = await db.collection('users').find({ id: { $in: members.map((m) => m.userId) } }).toArray();
    const byId = Object.fromEntries(users.map((u) => [u.id, u]));
    res.json({
      members: members.map((m) => ({
        userId: m.userId,
        email: byId[m.userId]?.email ?? null,
        name: byId[m.userId]?.name ?? null,
        role: m.role,
        active: m.active !== false,
        permissions: m.role === 'owner' ? null : m.permissions,
        createdAt: m.createdAt,
      })),
    });
  }),
);

shopsRouter.patch(
  '/v1/shops/:shopId/members/:userId',
  requireMember({ ownerOnly: true }),
  asyncHandler(async (req, res) => {
    const body = parseBody(
      z.object({
        active: z.boolean().optional(),
        permissions: z.partialRecord(z.enum(PERMISSION_KEYS), z.boolean()).optional(),
      }),
      req.body,
    );
    const db = await getDb();
    const target = await db.collection('members').findOne({ shopId: req.shop.id, userId: req.params.userId });
    if (!target) throw notFound('member_not_found');
    if (target.role === 'owner') throw forbidden('cannot_modify_owner', 'The owner cannot be changed');
    const set = {};
    if (body.active !== undefined) set.active = body.active;
    if (body.permissions) set.permissions = { ...target.permissions, ...body.permissions };
    await db.collection('members').updateOne({ shopId: req.shop.id, userId: target.userId }, { $set: set });
    res.json({ userId: target.userId, ...set });
  }),
);

// ---------- Trial, entitlement, referral ----------

/** Starts the 14-day free trial (once per Google account). */
shopsRouter.post(
  '/v1/shops/:shopId/trial',
  requireMember({ ownerOnly: true }),
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const user = await db.collection('users').findOneAndUpdate(
      { id: req.userId, trialUsedAt: null },
      { $set: { trialUsedAt: new Date() } },
      { returnDocument: 'after' },
    );
    if (!user) throw conflict('trial_already_used', 'The free trial was already used on this account');
    const trialEndsAt = extendDate(null, config.trialDays);
    await db.collection('shops').updateOne({ id: req.shop.id }, { $set: { trialEndsAt } });
    res.json({ trialEndsAt, entitlement: await loadEntitlement(db, { ...req.shop, trialEndsAt }) });
  }),
);

shopsRouter.get(
  '/v1/shops/:shopId/entitlement',
  requireMember(),
  asyncHandler(async (req, res) => {
    res.json({ entitlement: await loadEntitlement(await getDb(), req.shop), subscriptionRequired: config.requireSubscription });
  }),
);

/** The new shop enters the code of the shop that recommended the app (spec 19). */
shopsRouter.post(
  '/v1/shops/:shopId/referral',
  requireMember({ ownerOnly: true }),
  asyncHandler(async (req, res) => {
    const { code } = parseBody(z.object({ code: z.string().trim().toUpperCase().pipe(z.string().regex(/^[A-Z0-9]{4,12}$/)) }), req.body);
    const db = await getDb();
    const referrer = await db.collection('shops').findOne({ shopCode: code, deletedAt: null });
    if (!referrer) throw notFound('referral_code_not_found', 'Referral code not found');
    if (referrer.id === req.shop.id || referrer.ownerUserId === req.userId) {
      throw badRequest('self_referral', 'You cannot refer your own shop');
    }
    const already = await db.collection('referrals').findOne({ referredShopId: req.shop.id });
    if (already) throw conflict('referral_exists', 'This shop already has a referral');
    await db.collection('referrals').insertOne({
      referrerShopId: referrer.id,
      referredShopId: req.shop.id,
      status: 'pending',
      createdAt: new Date(),
      qualifiedAt: null,
      rewardedAt: null,
    });
    res.status(201).json({ status: 'pending' });
  }),
);

shopsRouter.get(
  '/v1/shops/:shopId/referrals',
  requireMember({ ownerOnly: true }),
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const list = await db.collection('referrals').find({ referrerShopId: req.shop.id }).sort({ createdAt: -1 }).toArray();
    res.json({
      shopCode: req.shop.shopCode ?? null,
      referrals: list.map((r) => ({ status: r.status, createdAt: r.createdAt, rewardedAt: r.rewardedAt })),
      monthsEarned: list.filter((r) => r.status === 'rewarded').length,
    });
  }),
);
