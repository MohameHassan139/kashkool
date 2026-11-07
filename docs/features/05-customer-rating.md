# 05 — Customer Rating (تقييم العميل)

**Phase:** 1 · **Tier:** Free · **Depends on:** 03, 04

## User story
As a shop owner, I want to see at a glance who pays on time and who doesn't,
so I know whom to give credit.

## Algorithm (computed, not stored; cache in memory)
Use **FIFO**: payments settle the oldest debts first. Compute:
- `oldestUnpaidAgeDays` — age of the oldest debt not yet fully covered.
- `limitRatio` — balance / creditLimit (if limit set).
- `txCount` — number of transactions.

| Badge | Rule (first match wins) |
|---|---|
| ⚪ جديد (New) | `txCount < 3` |
| 🟢 ممتاز (Good) | balance ≤ 0 **or** `oldestUnpaidAgeDays ≤ 14` |
| 🔴 متأخر (Late) | `oldestUnpaidAgeDays > 45` **or** `limitRatio > 1.0` |
| 🟡 متابعة (Watch) | everything else |

Thresholds (14, 45) are constants in `core/constants/rating.dart` — later configurable.

## UI
- Small colored dot + label on list rows and details header.
- Tap badge → bottom sheet explaining why: "أقدم مبلغ عليه من 52 يوم".
- Customer list filter chip: "متأخرين".

## Acceptance Criteria
- [ ] FIFO logic covered by unit tests (partial payments, overpayment, multiple debts).
- [ ] Badge updates immediately after a transaction.
- [ ] Explanation sheet shows the correct reason.
