# Kashkool Backend (Node.js + MongoDB on Vercel)

Cloud backup, multi-device sync, employees, statement links, referrals and Google Play
subscriptions for the Kashkool app. **The app stays local-first**: it works fully offline,
and this API is only used for the paid cloud features.

> This replaces the Supabase/PowerSync plan in `docs/backend/ARCHITECTURE.md`.
> Same rules still apply: money rows are append-only, derived values are never synced,
> every row belongs to a shop, and device clocks are never trusted for ordering.

## Stack
- Node.js 22, Express 4, MongoDB driver 6 (no ORM), zod validation
- Deployed as one Vercel serverless function (`api/index.js`), daily Vercel Cron
- MongoDB Atlas (multi-document transactions are used for sync)

## Run locally
```bash
cd backend
npm install
cp .env.example .env      # then fill in the values (a ready .env may already exist)
npm run dev               # http://localhost:3000
npm test                  # 32 tests (in-memory DB). Real DB: MONGODB_TEST_URI=<uri> npm test
```
With `ALLOW_DEV_LOGIN=true` (local only) you can get a token without Google:
```bash
curl -X POST localhost:3000/v1/auth/dev -H "Content-Type: application/json" -d '{"email":"me@test.com"}'
```

## Deploy to Vercel
1. **MongoDB Atlas → Network Access → Add IP Address → `0.0.0.0/0`**
   (Vercel has no fixed IPs. Security comes from the password, so use a strong one.)
2. Push this folder to GitHub (the `.env` file is git-ignored — keep it that way).
3. vercel.com → **Add New → Project** → import the repo → **Root Directory: `backend`**.
4. **Environment Variables** — add everything from `.env.example`:
   - `MONGODB_URI`, `MONGODB_DB=kashkool`
   - `JWT_SECRET` (new random value for production), `CRON_SECRET`
   - `GOOGLE_CLIENT_IDS` (from Google Cloud Console, when Google Sign-In is set up)
   - `PUBLIC_BASE_URL` = your Vercel URL (set after the first deploy, then redeploy)
   - `REQUIRE_SUBSCRIPTION=false` during beta
   - Do **not** set `ALLOW_DEV_LOGIN` on Vercel (it is ignored there anyway).
5. Deploy, then open `https://<your-app>.vercel.app/health` → `{"status":"ok","db":"ok"}`.

Alternative with the CLI: `npm i -g vercel` → `vercel` (inside `backend/`) → `vercel --prod`.

## API overview
All `/v1/...` routes except auth, config and webhooks need `Authorization: Bearer <accessToken>`.
Errors are JSON: `{ "error": "<code>", "message": "...", "details"?: [...] }`.

| Method | Path | Who | Purpose |
|---|---|---|---|
| GET | `/health` | public | Server + DB check |
| GET | `/v1/config` | public | Remote config: min version, flags, announcement |
| POST | `/v1/auth/google` | public | `{ idToken }` from Google Sign-In → tokens |
| POST | `/v1/auth/refresh` | public | `{ refreshToken }` → new pair (old one stops working) |
| POST | `/v1/auth/logout` | public | `{ refreshToken }` |
| GET | `/v1/me` | user | Profile + shops |
| DELETE | `/v1/me` | user | `{ confirm: "DELETE" }` deletes the account and owned shops (Play policy) |
| POST | `/v1/shops` | user | Register the local shop `{ id, name, type, phone?, shopCode? }` |
| GET | `/v1/shops` | user | Shops I belong to |
| GET/PATCH | `/v1/shops/:shopId` | member / owner | Details + entitlement / edit profile & payment info |
| POST | `/v1/shops/:shopId/devices` | member | `{ deviceId }` → `{ prefix: "A" }` for plan numbers |
| POST | `/v1/shops/:shopId/sync/push` | member | Upload changes (see below) |
| GET | `/v1/shops/:shopId/sync/pull?since=&limit=` | member | Download changes |
| POST | `/v1/shops/:shopId/invites` | owner | Employee invite code (8 chars, 48 h) |
| POST | `/v1/invites/accept` | user | `{ code }` → join as employee |
| GET | `/v1/shops/:shopId/members` | owner | List members |
| PATCH | `/v1/shops/:shopId/members/:userId` | owner | `{ active?, permissions? }` |
| POST | `/v1/shops/:shopId/trial` | owner | Start 14-day trial (once per account) |
| GET | `/v1/shops/:shopId/entitlement` | member | Current tier |
| POST | `/v1/shops/:shopId/subscription/verify` | owner | `{ purchaseToken }` after a Play purchase |
| POST | `/v1/shops/:shopId/referral` | owner | `{ code }` of the shop that recommended the app |
| GET | `/v1/shops/:shopId/referrals` | owner | My referrals + months earned |
| POST/GET | `/v1/shops/:shopId/statement-links` | member | Create `{ customerId, expiresInDays: 7|30|90|null }` / list |
| DELETE | `/v1/shops/:shopId/statement-links/:linkId` | member | Revoke |
| GET | `/s/:token` | public | Customer statement page (Arabic, RTL, no-index) |
| POST | `/v1/webhooks/play-rtdn?token=` | Google | Play Real-Time Developer Notifications |
| GET | `/api/cron/referrals` | Vercel Cron | Daily referral qualification |

## Sync contract (for the Flutter app)

Synced collections (same as the Drift tables, snake_case names):
`customers, suppliers, transactions, installment_plans, installments, installment_events,
installment_attachments, cash_days, expenses, settings`.

**Record format:** a flat JSON object with an `id` (the local UUID) and the table's fields in
camelCase. Values must be strings, numbers, booleans or null — no nested objects.
- Money fields end in `Piasters` and must be integers.
- Date fields end in `At` or `Date` and must be ISO-8601 strings (`2026-11-09T10:00:00.000Z`).
- The server ignores `shopId`, `serverSeq`, `serverUpdatedAt`, `serverCreatedAt` from the client.
- `installments.paidPiasters`/`status`/`paidAt` are **temporarily** synced because the app still stores them
  (fix F6). After F6 they become derived values and the server will drop them again.

**Push** `POST /v1/shops/:shopId/sync/push`
```json
{ "deviceId": "…", "changes": [ { "collection": "transactions", "record": { "id": "…", "partyType": "customer", "partyId": "…", "type": "debt", "amountPiasters": 15000, "occurredAt": "2026-11-09T10:00:00.000Z", "deletedAt": null } } ] }
```
Up to 500 changes per call. Response has one result per change, in order:
`inserted | updated | unchanged | rejected (+reason)`. Mark a local row as synced when its
status is anything except `rejected`. Show rejected ones in a "sync problems" list.

Rules the server enforces:
- `transactions`, `installment_events`, `installment_attachments` are **append-only**:
  after the first push only `deletedAt` and `supersededById` can be set (once, never cleared).
  An edit in the app = soft-delete the old row + push a new row.
- Soft-deleted rows stay deleted.
- Installment plan prices (`totalPricePiasters`, `downPaymentPiasters`, `cashPricePiasters`, markup,
  `customerId`, `planNumber`) are fixed after the first push.
- Employees: permissions from spec 15 (no deleting, no suppliers/drawer/settings by default,
  can correct their own transaction within 10 minutes).

**Pull** `GET /v1/shops/:shopId/sync/pull?since=<cursor>&limit=500`
```json
{ "changes": [ { "collection": "customers", "record": { … , "serverSeq": 42 } } ], "cursor": 42, "hasMore": false }
```
Apply the page in one local DB transaction, then save `cursor`. Repeat while `hasMore`.
A new device starts with `since=0`. Upsert by `id` (the server version wins for pulled rows).

**Suggested app loop:** on app start, after each local write (debounced ~30 s), and from a
"زامن دلوقتي" button: push all unsynced rows → pull until `hasMore=false`.

## Not included yet
- **Photo upload** (Vercel has no disk; add Vercel Blob or S3 later — rows keep `photoPath` locally).
- **Admin dashboard** (spec 22): for now edit data in MongoDB Atlas. `app_config` → `{ _id: "global", minSupportedVersion, flags, announcement }`.
- **Notebook import with AI** (spec 17).

## Security notes
- Refresh tokens, invite codes and statement-link tokens are stored only as SHA-256 hashes.
- Every query is scoped by `shopId` + membership; other shops return 404.
- Rate limits on login, invites and public pages are per serverless instance (basic protection).
- Rotate the MongoDB password if it was ever shared in a chat or committed.
