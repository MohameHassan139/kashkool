# 02 — Customers (العملاء)

**Phase:** 1 · **Tier:** Free · **Depends on:** 00, 01

## User story
As a shop owner, I want a list of my customers with how much each one owes me, so I can stop using my paper notebook.

## Data model — `customers`
| Field | Type | Notes |
|---|---|---|
| id | text | UUID v4 (Primary Key) |
| shopId | text | FK → shops.id |
| deviceId | text | Creating device UUID |
| createdBy | text | Creator user/device UUID |
| createdAt | datetime | UTC |
| updatedAt | datetime | UTC |
| deletedAt | datetime? | Nullable UTC soft delete |
| name | text | Required, 2–60 chars |
| phone | text? | Optional, validated Egyptian mobile (`01XXXXXXXXX`) |
| nationalId | text? | **Optional** (اختياري) — compliant with Egypt Law 151/2020 |
| notes | text? | e.g. "جار الدور التاني", "أبو يوسف" |
| creditLimitPiasters | int? | Null = no limit (see 04) |
| lastReminderAt | datetime? | Used by 07 (UTC) |
| snoozedUntil | datetime? | Used by 07 (UTC) |

> [!IMPORTANT]
> **Derived Balance Rule**: Balance is **strictly computed** from ledger transactions (Σ debts − Σ payments, excluding soft-deleted rows) and is **never stored as a database column or synced over the wire**. This prevents desynchronization and race conditions across multiple devices.

## Screens
### Customers list
- Top: total receivables card ("ليك عند الناس: 12,450 ج.م").
- Search bar (name or phone, Arabic-normalized: ignore أ/إ/آ → ا, ة → ه, ى → ي).
- Sort: highest balance (default), name, last activity.
- Filter chips: الكل · عليهم فلوس · خالصين.
- Each row: name, rating badge (05), balance (red if > 0), last activity relative date.
- FAB: "+ عميل جديد".
- Empty state with illustration and "ضيف أول عميل".

### Add / edit customer
- Fields: name, phone (with "pick from contacts" button — `flutter_contacts`), national ID (explicitly labeled "اختياري"), notes, credit limit.
- Duplicate check: warn if same phone or very similar name exists.

### Customer details
- Header: name, phone (tap → call), balance large, rating badge.
- Two big buttons: **عليه** (red) / **دفع** (green) → opens 03.
- Secondary actions: WhatsApp reminder (07), Statement PDF (08), Share Web Link (20 - Pro), Edit, Delete.
- Transaction history list, newest first, with running balance computed on the fly.

## Business rules
- **Append-Only & Soft Delete**: Delete = soft delete (`deletedAt = now()`). If balance ≠ 0, show strong warning.
- Deleted customers are hidden from all lists; restorable from Settings → "المحذوفات".
- In multi-device sync (Phase 2), all customer records partition strictly by `shopId`.

## Acceptance Criteria
- [ ] CRUD works offline and survives app restart.
- [ ] Balance and total receivables update instantly after any transaction.
- [ ] Search works with Arabic letter variants and phone sub-strings.
- [ ] National ID is optional; leaving it empty never triggers validation errors.
- [ ] List with 2,000 customers scrolls at 60fps on a low-end device.
- [ ] Repository unit tests: create, update, soft delete, dynamic balance query.
