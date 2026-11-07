# 06 — Suppliers Ledger (دفتر الموردين)

**Phase:** 1 · **Tier:** Free · **Depends on:** 02, 03

## User story
As a shop owner, I want to track what I owe distributors and suppliers, so I
know my real position — not only what customers owe me.

## Data model — `suppliers`
Same shape as `customers` minus `creditLimitPiasters`/reminder fields, plus:
| Field | Type | Notes |
|---|---|---|
| company | text? | e.g. "جهينة", "شركة النصر" |
| visitDay | int? | weekday the rep usually visits (0–6) |

Transactions reuse `transactions` table with `partyType = supplier`:
- `debt` = **I bought on credit** (عليّا) · `payment` = **I paid him** (دفعت).
- Labels in UI must be reversed accordingly: "عليّا" / "دفعتله".

## Screens
- Suppliers list: total payables card ("عليك للموردين: 8,300 ج.م").
- Supplier details: same layout as customer details with reversed wording/colors.
- Optional: on `visitDay`, morning local notification "النهارده ميعاد مندوب جهينة — عليك 2,100".

## Dashboard tie-in
Add a small summary on the Customers tab header or Cash tab:
**صافي** = receivables − payables.

## Acceptance Criteria
- [ ] Supplier CRUD + transactions work with reversed wording.
- [ ] Customer and supplier totals never mix.
- [ ] Net position shown correctly.
- [ ] Shared code reused (no copy-paste of whole screens) — use parameterized widgets.
