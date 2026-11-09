import { computeEntitlement } from './entitlement.js';

const DAY = 86400_000;
const dayKey = (d) => new Date(d).toISOString().slice(0, 10);

/** Last `days` calendar days (UTC) as yyyy-mm-dd, oldest first. */
export function lastDays(days, now = new Date()) {
  const out = [];
  for (let i = days - 1; i >= 0; i--) out.push(dayKey(now.getTime() - i * DAY));
  return out;
}

/** Counts dates per day for the last `days` days. */
export function perDay(dates, days, now = new Date()) {
  const keys = lastDays(days, now);
  const counts = Object.fromEntries(keys.map((k) => [k, 0]));
  for (const d of dates) {
    if (!d) continue;
    const k = dayKey(d);
    if (k in counts) counts[k] += 1;
  }
  return keys.map((k) => ({ day: k, count: counts[k] }));
}

/**
 * Builds the overview numbers from shops, members, users, subscriptions and referrals.
 * Metadata only: no customer names or amounts.
 */
export function buildOverview({ shops, members, users, subscriptions, referrals, activity = [], tierPrices, now = new Date() }) {
  const t = now.getTime();
  const within = (d, days) => d && t - new Date(d).getTime() <= days * DAY;
  const subsByShop = new Map();
  for (const s of subscriptions) {
    if (!subsByShop.has(s.shopId)) subsByShop.set(s.shopId, []);
    subsByShop.get(s.shopId).push(s);
  }

  const tiers = { free: 0, pro: 0, installments_pro: 0 };
  const sources = { free: 0, play: 0, trial: 0, referral_bonus: 0 };
  let mrr = 0;
  let trialStarted = 0;
  let trialConverted = 0;
  const types = {};

  for (const shop of shops) {
    const subs = subsByShop.get(shop.id) || [];
    const ent = computeEntitlement({ subscriptions: subs, shop, now });
    tiers[ent.tier] = (tiers[ent.tier] || 0) + 1;
    sources[ent.source] = (sources[ent.source] || 0) + 1;
    if (ent.source === 'play') mrr += tierPrices[ent.tier] || 0;
    if (shop.trialEndsAt) {
      trialStarted += 1;
      if (subs.some((s) => s.tier)) trialConverted += 1;
    }
    types[shop.type || 'other'] = (types[shop.type || 'other'] || 0) + 1;
  }

  const employees = members.filter((m) => m.role === 'employee' && m.active !== false).length;

  return {
    shops: {
      total: shops.length,
      new7d: shops.filter((s) => within(s.createdAt, 7)).length,
      active1d: shops.filter((s) => within(s.lastSyncAt, 1)).length,
      active7d: shops.filter((s) => within(s.lastSyncAt, 7)).length,
      active30d: shops.filter((s) => within(s.lastSyncAt, 30)).length,
      byType: types,
    },
    users: {
      total: users.length,
      active7d: users.filter((u) => within(u.lastLoginAt, 7)).length,
      employees,
    },
    revenue: {
      tiers,
      sources,
      payingShops: sources.play,
      estimatedMrrEgp: mrr,
      trialStarted,
      trialConverted,
      trialConversionRate: trialStarted ? Math.round((trialConverted / trialStarted) * 1000) / 10 : null,
    },
    referrals: {
      pending: referrals.filter((r) => r.status === 'pending').length,
      rewarded: referrals.filter((r) => r.status === 'rewarded').length,
      qualified: referrals.filter((r) => r.status === 'qualified').length,
    },
    charts: {
      newShops: perDay(shops.map((s) => s.createdAt), 30, now),
      activeShops: perDay(activity.map((a) => `${a.day}T12:00:00.000Z`), 30, now),
      newUsers: perDay(users.map((u) => u.createdAt), 30, now),
    },
    generatedAt: now.toISOString(),
  };
}
