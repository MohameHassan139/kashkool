export const TIER_RANK = { free: 0, pro: 1, installments_pro: 2 };

const ACTIVE_PLAY_STATES = new Set([
  'SUBSCRIPTION_STATE_ACTIVE',
  'SUBSCRIPTION_STATE_IN_GRACE_PERIOD',
  'SUBSCRIPTION_STATE_CANCELED', // still valid until expiry
]);

/**
 * Highest active tier for a shop from: Play subscriptions, the free trial, and referral bonus days.
 * Pure function — easy to test.
 */
export function computeEntitlement({ subscriptions = [], shop = {}, now = new Date() }) {
  const t = now.getTime();
  const candidates = [{ tier: 'free', expiresAt: null, source: 'free' }];

  for (const s of subscriptions) {
    const exp = s.expiresAt ? new Date(s.expiresAt).getTime() : 0;
    if (ACTIVE_PLAY_STATES.has(s.state) && exp > t && TIER_RANK[s.tier] !== undefined) {
      candidates.push({ tier: s.tier, expiresAt: new Date(exp).toISOString(), source: 'play' });
    }
  }
  if (shop.trialEndsAt && new Date(shop.trialEndsAt).getTime() > t) {
    candidates.push({ tier: 'installments_pro', expiresAt: new Date(shop.trialEndsAt).toISOString(), source: 'trial' });
  }
  if (shop.bonusProUntil && new Date(shop.bonusProUntil).getTime() > t) {
    candidates.push({ tier: 'pro', expiresAt: new Date(shop.bonusProUntil).toISOString(), source: 'referral_bonus' });
  }

  candidates.sort((a, b) => TIER_RANK[b.tier] - TIER_RANK[a.tier] || (Date.parse(b.expiresAt || 0) - Date.parse(a.expiresAt || 0)));
  return candidates[0];
}

export const hasTier = (entitlement, tier) => TIER_RANK[entitlement.tier] >= TIER_RANK[tier];

/** Adds `days` to whichever is later: now or the current end date. */
export function extendDate(current, days, now = new Date()) {
  const base = current && new Date(current).getTime() > now.getTime() ? new Date(current) : now;
  return new Date(base.getTime() + days * 24 * 60 * 60 * 1000);
}
