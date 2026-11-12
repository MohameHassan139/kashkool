# 03 — Transactions: Debt & Payment (عليه / دفع)

**Phase:** 1 · **Tier:** Free · **Depends on:** 02

## User story
As a shop owner, I want to record "he took goods on credit" or "he paid" in seconds, while customers are waiting, with complete confidence that past financial records cannot be tampered with or accidentally wiped out.

## Data model — `transactions`
| Field | Type | Notes |
|---|---|---|
| id | text | UUID v4 (Primary Key) |
| shopId | text | FK → shops.id |
| deviceId | text | Creating device UUID |
| createdBy | text | User or device identifier who recorded this transaction |
| createdAt | datetime | UTC |
| updatedAt | datetime | UTC |
| deletedAt | datetime? | Nullable UTC soft delete |
| supersededById | text? | UUID of the replacement transaction if this was edited |
| partyType | enum | `customer` \| `supplier` (06 reuses this table) |
| partyId | text | FK → customers.id or suppliers.id |
| type | enum | `debt` (عليه) \| `payment` (دفع) \| `supplierCredit` (supplier return credit only) |
| amountPiasters | int | Integer > 0 (1 EGP = 100 piasters) |
| method | enum? | `cash` \| `instapay` \| `wallet` \| `other` (payments only) |
| note | text? | Optional description, e.g. "علبة لبن وسكر" |
| photoPath | text? | Local file path (app documents dir) |
| occurredAt | datetime | Defaults to now, editable for back-dated sales (UTC) |

> [!IMPORTANT]
> **Append-Only Financial Guarantee**: Financial records are **immutable and append-only**. 
> - Transactions are **never hard-edited in place**.
- `supplierCredit` reduces supplier payables for a returned purchase and is not a cash payment.
> - When a user "edits" a transaction, the existing record is soft-deleted (`deletedAt = now()`, `supersededById = newRecordId`) and a new replacement record is inserted.
> - This guarantees an tamper-proof audit trail for employee tracking (15), simplifies multi-device sync conflict resolution (13), and ensures legal compliance.

## Derived Balances (Never Stored or Synced)
$$\text{Customer Balance} = \sum \text{amountPiasters}_{\text{active debts}} - \sum \text{amountPiasters}_{\text{active payments}}$$
*(Active = rows where `deletedAt IS NULL`). Positive = customer owes shop; Negative = customer has credit balance with the shop.*

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

## Edit / delete workflow
- Tap a transaction in history → view details (with photo full-screen).
- **Edit**:
  - The UI presents the existing values for adjustment.
  - On confirm, runs in a single DB transaction:
    1. Update old row: `deletedAt = now()`, `supersededById = newId`.
    2. Insert new row: all fields with new values, `createdBy = currentUser`, `createdAt = now()`.
- **Delete**:
  - Requires confirmation dialog: "هل تريد حذف المعاملة؟".
  - Soft-deletes: `deletedAt = now()`.
- **Undo**:
  - Tapping Undo within 5 seconds simply restores `deletedAt = null` on the previous record.

## Acceptance Criteria
- [ ] Add debt in ≤ 3 taps from customer details (amount → save).
- [ ] Balance correct after add / edit / delete / undo.
- [ ] Edits preserve the old row with `deletedAt` set and link to new row (append-only verified).
- [ ] Photo saved locally and visible after restart; deleted with transaction.
- [ ] Voice dictation fills note field (graceful message if unavailable).
- [ ] Unit tests verify dynamic balance calculation, overpayments (negative balance), and append-only edit behavior.
