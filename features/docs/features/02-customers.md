# 02 — Customers (العملاء)

**Phase:** 1 · **Tier:** Free · **Depends on:** 01

## User story
As a shop owner, I want a list of my customers with how much each one owes me,
so I can stop using my paper notebook.

## Data model — `customers`
| Field | Type | Notes |
|---|---|---|
| id, createdAt, updatedAt, deletedAt | — | standard |
| name | text | required, 2–60 chars |
| phone | text? | optional, validated Egyptian mobile |
| notes | text? | e.g. "جار الدور التاني" |
| creditLimitPiasters | int? | null = no limit (see 04) |
| lastReminderAt | datetime? | used by 07 |
| snoozedUntil | datetime? | used by 07 |

Balance is **computed** from transactions (see 03), not stored. Add a DB view or
query that returns `customer + balance + lastTransactionAt`.

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
- Fields: name, phone (with "pick from contacts" button — `flutter_contacts`), notes, credit limit.
- Duplicate check: warn if same phone or very similar name exists.

### Customer details
- Header: name, phone (tap → call), balance large, rating badge.
- Two big buttons: **عليه** (red) / **دفع** (green) → opens 03.
- Secondary actions: WhatsApp reminder (07), Statement PDF (08), Edit, Delete.
- Transaction history list, newest first, with running balance.

## Business rules
- Delete = soft delete. If balance ≠ 0, show strong warning.
- Deleted customers hidden from all lists; restorable from Settings → "المحذوفات" (optional).

## Acceptance Criteria
- [ ] CRUD works and survives app restart.
- [ ] Balance and total receivables update instantly after a transaction.
- [ ] Search works with Arabic letter variants.
- [ ] List with 2,000 customers scrolls smoothly on a low-end device.
- [ ] Repository unit tests: create, update, soft delete, balance query.
