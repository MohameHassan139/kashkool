# 03 — Transactions: Debt & Payment (عليه / دفع)

**Phase:** 1 · **Tier:** Free · **Depends on:** 02

## User story
As a shop owner, I want to record "he took goods on credit" or "he paid" in
seconds, while customers are waiting.

## Data model — `transactions`
| Field | Type | Notes |
|---|---|---|
| id, createdAt, updatedAt, deletedAt | — | standard |
| partyType | enum | `customer` \| `supplier` (06 reuses this table) |
| partyId | text | FK |
| type | enum | `debt` (عليه) \| `payment` (دفع) |
| amountPiasters | int | > 0 |
| method | enum? | `cash` \| `instapay` \| `wallet` \| `other` (payments only) |
| note | text? | e.g. "سكر وزيت" |
| photoPath | text? | local file path (app documents dir) |
| occurredAt | datetime | defaults to now, editable |

**Balance** = Σ debt − Σ payment (excluding soft-deleted).
Positive = customer owes shop.

## Screen — Add transaction (bottom sheet)
- Title colored by type: "عليه" red / "دفع" green.
- Huge numeric keypad (custom, not system keyboard) for speed.
- Quick amount chips: 50 · 100 · 200 · 500.
- Note field (optional) + 🎤 voice dictation button (system speech-to-text, `ar-EG`).
- 📷 photo button (camera/gallery, compress to ≤ 300KB with `image` / `flutter_image_compress`).
- Date: "النهارده" by default, tap to change.
- For payment: method selector (كاش / إنستاباي / محفظة).
- Payment amount > balance → ask "المبلغ أكبر من اللي عليه، تسجّله رصيد له؟".
- Save → haptic feedback + snackbar with **Undo** (5 s).

## Edit / delete
- Tap a transaction in history → view (with photo full-screen) → edit or delete.
- Every edit updates `updatedAt`; keep it simple (no audit log in Phase 1).

## Acceptance Criteria
- [ ] Add debt in ≤ 3 taps from customer details (amount → save).
- [ ] Balance correct after add / edit / delete / undo.
- [ ] Photo saved locally and visible after restart; deleted with transaction.
- [ ] Voice dictation fills note field (graceful message if unavailable).
- [ ] Unit tests for balance calculation incl. overpayment (negative balance).
