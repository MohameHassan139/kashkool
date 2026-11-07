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
- No ads, ever.

## Tech stack (do not change without asking)
- **Flutter** (latest stable), Dart null-safety. Android first, iOS later.
- State management: **Riverpod** (with code generation).
- Local database: **Drift** (SQLite). All data lives locally first.
- Navigation: **go_router**.
- Notifications: **flutter_local_notifications** + **workmanager** for the daily reminder.
- External links: **url_launcher** (WhatsApp `wa.me`, `sms:`, `tel:`).
- PDF: **pdf** + **printing**; sharing via **share_plus**.
- Home widget: **home_widget**.
- Biometric lock: **local_auth**.
- Cloud (Phase 2 only): **Supabase** (auth + Postgres + storage). Do NOT add cloud code in Phase 1.

## Architecture
Feature-first folders, clean separation:

```
lib/
  core/            # theme, router, db, utils, constants, localization
  features/
    customers/     # data/ domain/ presentation/
    transactions/
    suppliers/
    collection/    # daily collection screen + reminders
    cash_drawer/
    installments/  # Phase 2
    settings/
  shared/widgets/
```

- Repositories wrap Drift DAOs; UI never talks to the DB directly.
- Money is stored as **integer piasters** (قروش), never double.
- Every table has `id` (UUID string), `createdAt`, `updatedAt`, `deletedAt` (soft delete)
  so cloud sync in Phase 2 is easy.

## UI / UX rules
- **Arabic first, RTL**, Egyptian colloquial wording (e.g. "عليه", "دفع", "خالصين").
  English localization later — use ARB files from day one (`flutter_localizations`).
- Big touch targets (min 56dp), big numbers, high contrast. Font: **Cairo** or **Tajawal**.
- The two primary actions everywhere: **"عليه" (add debt)** in red and **"دفع" (payment)** in green.
- Any common action must take **≤ 3 taps**.
- Material 3, light + dark themes.
- Phone numbers: accept Egyptian format `01XXXXXXXXX`; convert to `201XXXXXXXXX` for WhatsApp.

## Phase 1 — MVP (free, local only)
Build in this order; finish and test each before moving on.

1. **Project setup**: Flutter project, folders, theme, RTL, Arabic font, router, Drift DB.
2. **Customers**: add/edit/delete (name, phone, notes, credit limit). List with search,
   sorted by highest balance. Customer details screen with full transaction history.
3. **Transactions**: "عليه" (debt) and "دفع" (payment) with amount, note, date,
   optional photo (camera/gallery, stored locally). Running balance per customer.
4. **Credit limit (حد الدين)**: warning dialog when a new debt exceeds the customer's limit.
5. **Customer rating**: auto-computed badge — green / yellow / red — based on average
   days to settle and current overdue amount. Show on list and details.
6. **Suppliers ledger (دفتر الموردين)**: same as customers but reversed (money the shop owes).
7. **Daily collection + WhatsApp reminder**:
   - One local notification per day (user picks time): "عندك X عملاء عليهم Y جنيه".
   - Tapping opens **Collection screen**: list of customers due, each with a WhatsApp button.
   - Button opens `https://wa.me/20XXXXXXXXXX?text=<url-encoded message>`.
   - On return to app, ask "اتبعت؟" and save `lastReminderAt`.
   - Fallback `sms:` button if no WhatsApp.
   - Message template is editable in settings, with placeholders:
     `{customer_name} {shop_name} {balance} {last_transaction} {payment_info}`.
8. **Customer statement PDF**: generate PDF of a customer's transactions and share it.
9. **Cash drawer closing (تقفيل الدرج)**: daily screen — cash in, InstaPay/wallet in,
   expenses out, expected drawer total, actual count, difference. Save history per day.
10. **Home screen widget**: total receivables + today's collections.
11. **Growth footer**: every WhatsApp message, PDF, and invoice ends with
    "اتعمل بكشكول — جرّبه ببلاش: <link>" (removable only in paid tier later).
12. **Settings**: shop name, phone, InstaPay/wallet info, reminder time, message template,
    biometric/PIN lock, privacy mode (hide amounts), manual export/import of DB file.

## Phase 2 — Paid (cloud) — DO NOT START until Phase 1 is approved
- Supabase auth (phone OTP), backup & sync, multi-device.
- **Installments (الأقساط)**: down payment, installment amount, schedule, per-installment
  reminders, late tracking. Highest-value paid feature.
- **Employee permissions**: employee can add sales/debts but cannot delete, edit, or see profits.
- Subscription paywall (Google Play Billing).

## Phase 3
- **Notebook import via camera**: photograph paper notebook pages, AI extracts
  names + amounts, user reviews before saving. (First 5 pages free.)
- **Offers/greetings broadcaster**: pick a customer group + template (Ramadan, Eid,
  offers), then send one-by-one via the WhatsApp launcher.
- Referral program (1 free Pro month per referred shop).

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
