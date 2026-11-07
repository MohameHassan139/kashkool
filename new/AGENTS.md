# Kashkool (كشكول) — Agent Instructions

> Working name: **Kashkool**. Replace everywhere if the final name changes.

## What we are building
A mobile app for small Egyptian shop owners (grocery, pharmacy, mobile phone shops,
spare parts, hardware) that replaces the paper notebook ("الكشكول") used to track
customer credit ("الشُكُك"), supplier debts, daily cash, and installments.

Target user: non-technical shop owner, often older, using a mid/low-end Android phone,
frequently with weak or no internet. **Simplicity beats features.**

## Business model
- **Free tier = fully local** (works offline forever, no account needed).
- **Paid tier = cloud** (backup, sync, multi-device, employees) + Pro features.
  - Pro: **79 EGP / month** (cloud sync & backup, multi-device, employees, statement link, remove footer).
  - Installments Pro: **149 EGP / month** (all Pro features + full installments engine, contracts, guarantor tracking).
- No ads, ever.

## Tech stack (do not change without asking)
- **Flutter** (latest stable), Dart null-safety. Android first, iOS later.
- State management: **Riverpod** (with code generation).
- Local database: **Drift** encrypted with **SQLCipher** (`drift` + `sqlcipher_flutter_libs`) with device key stored via `flutter_secure_storage`. All data lives locally first.
- Navigation: **go_router**.
- Notifications: **flutter_local_notifications** + **workmanager** for the daily reminder (with aggressive battery-optimization handling for Xiaomi/Oppo/Realme/Transsion).
- External links: **url_launcher** (WhatsApp `wa.me`, `sms:`, `tel:`).
- PDF: **pdf** + **printing**; sharing via **share_plus**.
- Home widget: **home_widget**.
- Biometric lock: **local_auth**.
- Cloud & Sync (Phase 2): **PowerSync** client replication + **Supabase** (Frankfurt `eu-central-1` region for lowest latency to Egypt ~50-70ms) with PostgreSQL, Supabase Auth (Google Sign-In first, phone OTP later), Supabase Storage, and Deno Edge Functions. Do NOT add cloud code in Phase 1.
- In-App Subscriptions: **Google Play Billing** (`in_app_purchase`). Any external payment gateway must comply with Google Play's regional billing policies for Egypt.

## Architecture
Feature-first folders, clean separation:

```
lib/
  core/            # theme, router, db, security, utils, constants, localization
  features/
    onboarding/    # shop setup & type-based customization
    customers/     # data/ domain/ presentation/
    transactions/  # append-only financial records
    suppliers/
    collection/    # daily collection screen + reminders
    cash_drawer/
    installments/  # Phase 2 (offline-capable)
    settings/
  shared/widgets/
```

- Repositories wrap Drift DAOs; UI never talks to the DB directly.
- Money is stored as **integer piasters** (قروش), never double (1 EGP = 100 piasters).
- **Core schema rule**: Every table has:
  - `id` (UUID v4 string)
  - `shopId` (UUID string, references `shops.id`)
  - `deviceId` (UUID string, identifier of the device creating the record)
  - `createdBy` (UUID string, user/device identifier)
  - `createdAt` (UTC datetime)
  - `updatedAt` (UTC datetime)
  - `deletedAt` (nullable UTC datetime, soft delete)
- **Shops table**: Added from Phase 1 (`shops`: `id`, `name`, `shopType`, `phone`, `address`, `currency`, `createdAt`, `updatedAt`, `deletedAt`). Local mode seeds a default shop on first run.
- **Append-only financial records**: Transactions and payments are **never hard-edited**. An edit is recorded as a soft-delete of the previous record (`deletedAt = now()`) plus insertion of a new record. This maintains an immutable audit trail and avoids sync conflicts.
- **Derived values computed locally**: Customer balances, supplier balances, installment `paidPiasters`, installment statuses, FIFO customer rating badges, and cash drawer differences are **computed locally from ledger records** and are **never synced** over the wire.
- **Privacy & Egypt Law 151/2020 Compliance**: Customer and guarantor National ID fields are strictly **optional**. All user data is encrypted at rest (SQLCipher). Transparent Privacy Policy and Terms of Service must be provided.

## UI / UX rules
- **Arabic first, RTL**, Egyptian colloquial wording (e.g. "عليه", "دفع", "خالصين").
  English localization later — use ARB files from day one (`flutter_localizations`).
- Big touch targets (min 56dp), big numbers, high contrast. Font: **Cairo** or **Tajawal**.
- The two primary actions everywhere: **"عليه" (add debt)** in red and **"دفع" (payment)** in green.
- Any common action must take **≤ 3 taps**.
- Material 3, light + dark themes.
- Phone numbers: accept Egyptian format `01XXXXXXXXX`; convert to `201XXXXXXXXX` for WhatsApp.

## Build Order

### Phase 1 — MVP (free, local only)
0. **Onboarding (00)**: Shop name, phone, shop type (grocery, mobile, electronics, pharmacy, other). Toggles installments visibility. Notification & battery permission guidance. Creates default `shops` row.
1. **Project setup (01)**: Flutter project, folders, theme, RTL, Arabic font, router, Drift DB with SQLCipher encryption, base mixin with `shopId/deviceId/createdBy`.
2. **Settings & Shop Info (12 - Basic setup)**: Setup shop profile (name, phone, InstaPay/wallet info), reminder time, message template before daily collection is built.
3. **Customers (02)**: Add/edit/delete (name, phone, notes, credit limit). List with search, sorted by highest balance. Details screen with full ledger history.
4. **Transactions (03)**: Append-only "عليه" (debt) and "دفع" (payment) with amount, note, date, optional photo. Running balance dynamically computed.
5. **Credit limit (04)**: Warning dialog when a new debt exceeds the customer's limit.
6. **Customer rating (05)**: FIFO auto-computed badge — green / yellow / red.
7. **Suppliers ledger (06)**: Same as customers but reversed (money the shop owes).
8. **Daily collection + WhatsApp reminder (07)**:
   - Daily local notification + fallback **recompute on app open** (for aggressive battery-killing OEMs).
   - Opens **Collection screen**: customers due, WhatsApp `wa.me` 1-tap launcher, return confirmation "اتبعت؟".
   - Fallback `sms:` button if no WhatsApp.
   - Message template with placeholders and growth footer.
9. **Customer statement PDF (08)**: Generate PDF of customer transactions and share via WhatsApp/system.
10. **Cash drawer closing (09)**: Daily screen — cash in, digital in, expenses out, expected vs actual count.
11. **Home screen widget (10)**: Total receivables + today's collections.
12. **Growth footer (11)**: Append "اتعمل بكشكول — جرّبه ببلاش: <link>" to messages and PDFs (removable only in paid tier).
13. **Security, App Lock & Backup (12 - Security)**: Biometric/PIN lock, privacy mode (`•••`), `.kashkool` zip export/import.

### Phase 2 — Paid (Cloud & Scalability)
14. **Cloud Sync & Accounts (13)**: Supabase (Frankfurt `eu-central-1`) + PowerSync engine. Google Sign-In first, phone OTP later. Strict RLS by shop membership.
15. **Installments System (14)**: Down payment, installment schedule, collision-safe `planNumber` (device-prefixed), contract/receipt photos, WhatsApp reminders, early settlement. (1 active plan free for trial).
16. **Employee permissions (15)**: Multi-user shop access (`shop_members`), role-based UI and RLS restrictions.
17. **Subscription paywall (16)**: Google Play Billing (Pro 79 EGP / Installments Pro 149 EGP), entitlement checks, grace periods.
18. **Shareable Statement Web Link (20)**: Pro web link (`kashkool.app/s/{token}`) with expiry and revocation.
19. **Crash Reporting & Privacy Analytics (21)**: Sentry/Crashlytics + privacy-friendly metrics (no PII).

### Phase 3 — Growth & Intelligence
20. **Notebook import via camera (17)**: Photograph paper notebook pages, AI vision extracts rows for review.
21. **Offers/greetings broadcaster (18)**: Send seasonal greetings/offers to customer groups via WhatsApp queue.
22. **Referral program (19)**: Earn free Pro months (+30 days) for qualified referred shops.
23. **Internal Admin Dashboard (22)**: Operations dashboard for shop management, subscriptions, fraud check, remote config.

## Working rules for the agent
- **Detailed specs live in `docs/features/`** (index: `docs/features/README.md`).
  Before planning any feature, read its spec file; its Acceptance Criteria are the definition of done.
  If a spec conflicts with this file, ask the user.
- Before writing code for a feature, show a short plan and wait for approval.
- Keep changes small; one feature per task.
- Write unit tests for repositories and balance/rating calculations.
- Run `flutter analyze` and `flutter test` before saying a task is done.
- Never hard-code user-facing strings — put them in ARB files.
- Do not add packages outside the stack above without asking.
- Explain decisions to the user in **Egyptian Arabic**; code, comments, and commits in English.
