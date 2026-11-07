# 14 — Installments (الأقساط) ⭐

**Phase:** 2 · **Tier:** Paid (headline feature) · **Depends on:** 02, 03, 07

## User story
As a mobile/electronics/furniture shop owner, I sell on installments and need
to track every plan, who is late, and remind customers on each due date.

## Data model
`installment_plans`
| Field | Type | Notes |
|---|---|---|
| id, timestamps | — | |
| customerId | text | |
| itemDescription | text | e.g. "Samsung A15" |
| totalPricePiasters | int | price after markup |
| downPaymentPiasters | int | المقدّم |
| installmentCount | int | |
| frequency | enum | monthly / weekly |
| startDate | date | first due date |
| guarantorName / guarantorPhone | text? | الضامن |
| notes / photoPath | text? | contract/ID photo |
| status | enum | active / completed / cancelled |

`installments` (generated schedule)
| Field | Type | Notes |
|---|---|---|
| planId, index | — | |
| dueDate | date | |
| amountPiasters | int | last one absorbs rounding |
| paidPiasters | int | supports partial payment |
| paidAt | datetime? | |

## Screens
- **New plan wizard**: customer → item & price → down payment → count & frequency
  → preview schedule table → save. Down payment recorded as a payment.
- **Plans list**: filters (active / late / completed), each with progress bar (paid x of n).
- **Plan details**: schedule with status per row (paid ✓ / due today / late in red / upcoming),
  "سجّل دفع قسط" button, WhatsApp reminder for this installment.
- **Today**: section in Collection tab "أقساط مستحقة النهارده / متأخرة".

## Reminders
- Daily notification includes installments due today and overdue.
- Optional message to customer 1 day before due date.
- Template placeholders: `{item}` `{installment_number}` `{installment_count}` `{due_date}` `{amount}` `{remaining_total}`.

## Business rules
- Remaining total = total − down payment − Σ paid.
- Early full settlement option with optional discount.
- Late = dueDate < today and not fully paid; counts toward customer rating (05).

## Acceptance Criteria
- [ ] Schedule generation correct incl. rounding and month-end dates (e.g. start 31 Jan).
- [ ] Partial payments carry correctly to the same installment.
- [ ] Late detection and reminders work.
- [ ] Unit tests for schedule + remaining calculations.
