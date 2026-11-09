import { Router } from 'express';
import { z } from 'zod';
import { config } from '../config.js';
import { getDb } from '../db.js';
import { loadEntitlement, requireAuth, requireMember } from '../middleware/auth.js';
import { fetchPlaySubscription, mapPlaySubscription } from '../services/play.js';
import { safeEqual, sha256 } from '../utils/crypto.js';
import { asyncHandler, badRequest, conflict, parseBody, unauthorized } from '../utils/http.js';

export const subscriptionsRouter = Router();

/**
 * The app calls this after a successful Google Play purchase.
 * In the app, set `applicationUserName` (obfuscatedAccountId) to the shopId when buying,
 * so a purchase token can't be reused for another shop.
 */
subscriptionsRouter.post(
  '/v1/shops/:shopId/subscription/verify',
  requireAuth,
  requireMember({ ownerOnly: true }),
  asyncHandler(async (req, res) => {
    const { purchaseToken } = parseBody(z.object({ purchaseToken: z.string().min(10).max(4096) }), req.body);
    const db = await getDb();
    const tokenHash = sha256(purchaseToken);

    const other = await db.collection('subscriptions').findOne({ purchaseTokenHash: tokenHash });
    if (other && other.shopId !== req.shop.id) throw conflict('purchase_used_by_other_shop', 'This purchase belongs to another shop');

    const mapped = mapPlaySubscription(await fetchPlaySubscription(purchaseToken));
    if (!mapped.tier) throw badRequest('unknown_product', 'This product is not a Kashkool plan');
    if (mapped.linkedShopId && mapped.linkedShopId !== req.shop.id) {
      throw conflict('purchase_for_other_shop', 'This purchase was made for another shop');
    }

    await db.collection('subscriptions').updateOne(
      { purchaseTokenHash: tokenHash },
      {
        $set: { ...mapped, shopId: req.shop.id, purchaseToken, updatedAt: new Date() },
        $setOnInsert: { createdAt: new Date(), userId: req.userId },
      },
      { upsert: true },
    );
    res.json({ entitlement: await loadEntitlement(db, req.shop), subscription: { state: mapped.state, tier: mapped.tier, expiresAt: mapped.expiresAt } });
  }),
);

/**
 * Google Play Real-Time Developer Notifications (Pub/Sub push subscription).
 * Configure the push endpoint as: https://<your-app>/v1/webhooks/play-rtdn?token=<PLAY_PUBSUB_TOKEN>
 */
subscriptionsRouter.post(
  '/v1/webhooks/play-rtdn',
  asyncHandler(async (req, res) => {
    if (!config.play.pubsubToken || !safeEqual(req.query.token, config.play.pubsubToken)) throw unauthorized('Bad webhook token');
    const data = req.body?.message?.data;
    if (!data) return res.status(204).end();

    let payload;
    try {
      payload = JSON.parse(Buffer.from(data, 'base64').toString('utf8'));
    } catch {
      return res.status(204).end(); // malformed: acknowledge so Pub/Sub stops retrying
    }
    const token = payload?.subscriptionNotification?.purchaseToken;
    if (!token) return res.status(204).end(); // test notifications, one-time products, etc.

    const db = await getDb();
    const existing = await db.collection('subscriptions').findOne({ purchaseTokenHash: sha256(token) });
    if (!existing) return res.status(204).end(); // app hasn't called /verify yet; it will

    const mapped = mapPlaySubscription(await fetchPlaySubscription(token));
    await db.collection('subscriptions').updateOne(
      { purchaseTokenHash: sha256(token) },
      { $set: { ...mapped, updatedAt: new Date(), lastNotificationType: payload.subscriptionNotification.notificationType ?? null } },
    );
    res.status(204).end();
  }),
);
