import { config } from '../config.js';
import { extendDate } from './entitlement.js';

const dayKey = (d) => new Date(d).toISOString().slice(0, 10);

/**
 * Qualifies pending referrals (spec 19): the referred shop must have ≥10 transactions
 * on ≥3 different days. Uses server receive time, so backdated records don't count.
 */
export async function qualifyReferrals(db, now = new Date()) {
  const pending = await db.collection('referrals').find({ status: 'pending' }).limit(500).toArray();
  const summary = { checked: pending.length, rewarded: 0, qualifiedWithoutReward: 0 };

  for (const ref of pending) {
    const txs = await db
      .collection('transactions')
      .find({ shopId: ref.referredShopId, deletedAt: null }, { projection: { serverCreatedAt: 1 } })
      .limit(1000)
      .toArray();
    const days = new Set(txs.filter((t) => t.serverCreatedAt).map((t) => dayKey(t.serverCreatedAt)));
    if (txs.length < 10 || days.size < 3) continue;

    const yearAgo = new Date(now.getTime() - 365 * 86400_000);
    const rewardsThisYear = await db
      .collection('referrals')
      .countDocuments({ referrerShopId: ref.referrerShopId, status: 'rewarded', rewardedAt: { $gte: yearAgo } });

    const referred = await db.collection('shops').findOne({ id: ref.referredShopId });
    if (referred) {
      await db
        .collection('shops')
        .updateOne({ id: referred.id }, { $set: { bonusProUntil: extendDate(referred.bonusProUntil, config.referredRewardDays, now) } });
    }

    if (rewardsThisYear < config.maxReferralRewardsPerYear) {
      const referrer = await db.collection('shops').findOne({ id: ref.referrerShopId });
      if (referrer) {
        await db
          .collection('shops')
          .updateOne({ id: referrer.id }, { $set: { bonusProUntil: extendDate(referrer.bonusProUntil, config.referrerRewardDays, now) } });
      }
      await db.collection('referrals').updateOne({ referredShopId: ref.referredShopId }, { $set: { status: 'rewarded', qualifiedAt: now, rewardedAt: now } });
      summary.rewarded += 1;
    } else {
      await db.collection('referrals').updateOne({ referredShopId: ref.referredShopId }, { $set: { status: 'qualified', qualifiedAt: now } });
      summary.qualifiedWithoutReward += 1;
    }
  }
  return summary;
}
