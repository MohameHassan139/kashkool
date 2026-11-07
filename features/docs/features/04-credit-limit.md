# 04 — Credit Limit (حد الدين)

**Phase:** 1 · **Tier:** Free · **Depends on:** 02, 03

## User story
As a shop owner, I want to be warned before a customer's debt goes above a
limit I set, so I don't lose money to customers who don't pay.

## Data
- `customers.creditLimitPiasters` (nullable).
- `settings.defaultCreditLimitPiasters` (nullable) — applied to new customers.

## Behavior
- When saving a **debt** where `currentBalance + amount > limit`:
  - Show dialog: "أحمد كده هيبقى عليه 1,150 ج.م — الحد بتاعه 800 ج.م"
  - Buttons: **سجّل برضه** · **إلغاء** · **غيّر الحد**.
- Customer list/details: progress bar of balance vs limit.
  - < 80% → neutral · 80–100% → amber · > 100% → red.
- Never block — the owner always decides.

## Acceptance Criteria
- [ ] Warning appears exactly when limit is exceeded, not before.
- [ ] No warning when limit is null.
- [ ] Default limit applied to newly created customers only.
- [ ] Unit tests for the threshold logic.
