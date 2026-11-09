import { getDb } from '../db.js';
import { config } from '../config.js';
import { verifyAccessToken } from '../services/tokens.js';
import { computeEntitlement, hasTier } from '../services/entitlement.js';
import { asyncHandler, forbidden, notFound, unauthorized, HttpError } from '../utils/http.js';

/** Requires `Authorization: Bearer <accessToken>`; sets req.userId. */
export const requireAuth = asyncHandler(async (req, res, next) => {
  const header = req.get('authorization') || '';
  const [scheme, token] = header.split(' ');
  if (scheme !== 'Bearer' || !token) throw unauthorized();
  req.userId = verifyAccessToken(token);
  next();
});

/**
 * Loads the shop from `:shopId` and the caller's membership.
 * Options: { ownerOnly }.
 */
export const requireMember = ({ ownerOnly = false } = {}) =>
  asyncHandler(async (req, res, next) => {
    const db = await getDb();
    const shopId = req.params.shopId;
    const [shop, member] = await Promise.all([
      db.collection('shops').findOne({ id: shopId, deletedAt: null }),
      db.collection('members').findOne({ shopId, userId: req.userId }),
    ]);
    // Same answer for "no shop" and "not a member" so shop IDs can't be probed.
    if (!shop || !member || member.active === false) throw notFound('shop_not_found', 'Shop not found');
    if (ownerOnly && member.role !== 'owner') throw forbidden('owner_only', 'Only the shop owner can do this');
    req.shop = shop;
    req.member = member;
    next();
  });

export async function loadEntitlement(db, shop) {
  const subscriptions = await db.collection('subscriptions').find({ shopId: shop.id }).toArray();
  return computeEntitlement({ subscriptions, shop });
}

/** Blocks paid features when REQUIRE_SUBSCRIPTION=true and the shop's tier is too low. */
export const requireTier = (tier) =>
  asyncHandler(async (req, res, next) => {
    if (!config.requireSubscription) return next();
    const db = await getDb();
    const entitlement = await loadEntitlement(db, req.shop);
    if (!hasTier(entitlement, tier)) {
      throw new HttpError(402, 'subscription_required', `This feature needs the ${tier} plan`);
    }
    req.entitlement = entitlement;
    next();
  });
