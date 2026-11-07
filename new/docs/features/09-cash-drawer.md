# 09 — Cash Drawer Closing (تقفيل الدرج)

**Phase:** 1 · **Tier:** Free · **Depends on:** 03

## User story
As a shop owner, at the end of the day I want to know how much money should be
in the drawer and whether anything is missing.

## Data model
`cash_days`
| Field | Type | Notes |
|---|---|---|
| id, timestamps | — | standard |
| date | date | unique per day |
| openingCashPiasters | int | defaults to previous day's actual closing |
| cashSalesPiasters | int | manual entry of cash sales (non-credit) |
| actualCountPiasters | int? | counted at close |
| closedAt | datetime? | null = day still open |
| notes | text? | |

`expenses`
| Field | Type | Notes |
|---|---|---|
| id, timestamps | — | |
| date | date | |
| category | enum | rent, electricity, salary, supplies, supplier_payment, other |
| amountPiasters | int | |
| method | enum | cash / instapay / wallet |
| note | text? | |

## Calculation for a day
- **Cash in** = cash sales + customer payments with `method = cash`.
- **Digital in** = customer payments with `method ∈ {instapay, wallet}` (shown separately, not in drawer).
- **Cash out** = expenses (cash) + supplier payments (cash).
- **Expected drawer** = opening + cash in − cash out.
- **Difference** = actual count − expected (green 0, red negative "عجز", amber positive "زيادة").

## Screens
- Cash tab: today card with live numbers; "+ مصروف" and "+ مبيعات كاش" buttons.
- "قفّل اليوم" → enter actual count (big keypad) → summary → confirm.
- History list by day; tap for detail. Monthly totals at top.

## Acceptance Criteria
- [ ] Calculations covered by unit tests.
- [ ] Opening cash auto-fills from previous closed day.
- [ ] Customer/supplier cash payments flow into the day automatically.
- [ ] Closed day becomes read-only (reopen with confirmation).
