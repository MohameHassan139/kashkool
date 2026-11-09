import { Router } from 'express';
import { z } from 'zod';
import { config } from '../config.js';
import { getDb } from '../db.js';
import { requireAuth, requireMember, requireTier } from '../middleware/auth.js';
import { buildStatement, renderMessagePage, renderStatementPage } from '../services/statement.js';
import { randomToken, sha256 } from '../utils/crypto.js';
import { asyncHandler, notFound, parseBody } from '../utils/http.js';
import { rateLimit } from '../utils/rateLimit.js';

export const statementLinksRouter = Router();

const linkView = (l) => ({
  id: l.id,
  customerId: l.customerId,
  createdAt: l.createdAt,
  expiresAt: l.expiresAt,
  revokedAt: l.revokedAt,
  openCount: l.openCount,
  lastOpenedAt: l.lastOpenedAt,
});

/** Creates a link. The token is returned once; only its hash is stored. */
statementLinksRouter.post(
  '/v1/shops/:shopId/statement-links',
  requireAuth,
  requireMember(),
  requireTier('pro'),
  asyncHandler(async (req, res) => {
    const body = parseBody(
      z.object({
        customerId: z.string().min(1).max(64),
        expiresInDays: z.union([z.literal(7), z.literal(30), z.literal(90), z.null()]).default(30),
      }),
      req.body,
    );
    const db = await getDb();
    const customer = await db.collection('customers').findOne({ shopId: req.shop.id, id: body.customerId, deletedAt: null });
    if (!customer) throw notFound('customer_not_synced', 'Customer not found on the server — sync first');

    const token = randomToken(24);
    const now = new Date();
    const link = {
      id: randomToken(9),
      shopId: req.shop.id,
      customerId: body.customerId,
      tokenHash: sha256(token),
      createdBy: req.userId,
      createdAt: now,
      expiresAt: body.expiresInDays ? new Date(now.getTime() + body.expiresInDays * 86400_000) : null,
      revokedAt: null,
      openCount: 0,
      lastOpenedAt: null,
    };
    await db.collection('statement_links').insertOne(link);
    const base = config.publicBaseUrl || `${req.protocol}://${req.get('host')}`;
    res.status(201).json({ url: `${base}/s/${token}`, link: linkView(link) });
  }),
);

statementLinksRouter.get(
  '/v1/shops/:shopId/statement-links',
  requireAuth,
  requireMember(),
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const filter = { shopId: req.shop.id };
    if (typeof req.query.customerId === 'string') filter.customerId = req.query.customerId;
    const links = await db.collection('statement_links').find(filter).sort({ createdAt: -1 }).limit(100).toArray();
    res.json({ links: links.map(linkView) });
  }),
);

statementLinksRouter.delete(
  '/v1/shops/:shopId/statement-links/:linkId',
  requireAuth,
  requireMember(),
  asyncHandler(async (req, res) => {
    const db = await getDb();
    const result = await db
      .collection('statement_links')
      .updateOne({ shopId: req.shop.id, id: req.params.linkId, revokedAt: null }, { $set: { revokedAt: new Date() } });
    if (result.matchedCount === 0) throw notFound('link_not_found');
    res.status(204).end();
  }),
);

/** Public page the customer opens from WhatsApp. */
statementLinksRouter.get(
  '/s/:token',
  rateLimit({ windowMs: 60_000, max: 30 }),
  asyncHandler(async (req, res) => {
    res.set({
      'Cache-Control': 'no-store',
      'X-Robots-Tag': 'noindex, nofollow',
      'Referrer-Policy': 'no-referrer',
      'Content-Security-Policy': "default-src 'none'; style-src 'unsafe-inline'; base-uri 'none'; form-action 'none'",
    });
    res.type('html');

    const token = String(req.params.token || '');
    if (!/^[A-Za-z0-9_-]{20,64}$/.test(token)) {
      return res.status(404).send(renderMessagePage('اللينك ده مش موجود', 'اتأكد من اللينك أو اطلب لينك جديد من المحل.'));
    }
    const db = await getDb();
    const link = await db.collection('statement_links').findOne({ tokenHash: sha256(token) });
    if (!link) return res.status(404).send(renderMessagePage('اللينك ده مش موجود', 'اتأكد من اللينك أو اطلب لينك جديد من المحل.'));
    if (link.revokedAt || (link.expiresAt && new Date(link.expiresAt) <= new Date())) {
      return res.status(410).send(renderMessagePage('اللينك ده مبقاش شغال', 'اطلب لينك جديد من المحل.'));
    }

    const [shop, customer] = await Promise.all([
      db.collection('shops').findOne({ id: link.shopId, deletedAt: null }),
      db.collection('customers').findOne({ shopId: link.shopId, id: link.customerId, deletedAt: null }),
    ]);
    if (!shop || !customer) {
      return res.status(410).send(renderMessagePage('اللينك ده مبقاش شغال', 'اطلب لينك جديد من المحل.'));
    }

    const [transactions, plans] = await Promise.all([
      db.collection('transactions').find({ shopId: shop.id, partyType: 'customer', partyId: customer.id, deletedAt: null }).toArray(),
      db.collection('installment_plans').find({ shopId: shop.id, customerId: customer.id, deletedAt: null }).toArray(),
    ]);
    const schedules = {};
    if (plans.length) {
      const rows = await db
        .collection('installments')
        .find({ shopId: shop.id, planId: { $in: plans.map((p) => p.id) }, deletedAt: null })
        .toArray();
      for (const r of rows) (schedules[r.planId] ||= []).push(r);
    }

    await db.collection('statement_links').updateOne({ id: link.id }, { $inc: { openCount: 1 }, $set: { lastOpenedAt: new Date() } });
    const statement = buildStatement({ customer, transactions, plans, schedules });
    res.send(renderStatementPage({ shop, statement }));
  }),
);
