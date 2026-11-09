import { SYNC_COLLECTION_NAMES } from '../sync/collections.js';

/** Permanently removes a shop and everything that belongs to it. */
export async function deleteShopData(db, shopId) {
  await Promise.all([
    ...SYNC_COLLECTION_NAMES.map((name) => db.collection(name).deleteMany({ shopId })),
    db.collection('members').deleteMany({ shopId }),
    db.collection('invites').deleteMany({ shopId }),
    db.collection('statement_links').deleteMany({ shopId }),
    db.collection('subscriptions').deleteMany({ shopId }),
    db.collection('shop_activity').deleteMany({ shopId }),
    db.collection('referrals').deleteMany({ $or: [{ referredShopId: shopId }, { referrerShopId: shopId }] }),
  ]);
  await db.collection('shops').deleteOne({ id: shopId });
}

/** Letters A..Z, then AA, AB… — used as an offline-safe prefix for installment plan numbers. */
export function devicePrefixFor(index) {
  let n = index;
  let out = '';
  do {
    out = String.fromCharCode(65 + (n % 26)) + out;
    n = Math.floor(n / 26) - 1;
  } while (n >= 0);
  return out;
}
