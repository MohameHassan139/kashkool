# 25 — Quick Point of Sale (نقطة البيع السريعة)

**Phase:** 1 · **Tier:** Free, local-first · **Depends on:** 02, 03, 09, 23

## User story
As a shop owner, I want to record a simple sale quickly, reduce stock, and either
receive cash or add the total to a customer's balance without needing internet.

## Data model

### `sales`
- Standard `BaseTable` metadata.
- `customerId`: nullable; required for a credit sale and null for a cash sale.
- `paymentType`: cash or credit.
- `totalPiasters`: sum of sale lines in integer piasters.
- `occurredAt`: UTC sale time.

### `sale_items`
- Standard `BaseTable` metadata.
- `saleId`, `productId`, product name and unit snapshots.
- `quantityMilliUnits`: positive fixed-point quantity.
- `unitPricePiasters`, `unitCostPiasters`: non-negative snapshots at time of sale.
- `lineTotalPiasters`: rounded to the nearest piaster from quantity × unit price.

Money uses integer piasters and quantities use thousandths of the selected unit.
Sale records and their lines are append-only; posted sales cannot be edited or
deleted from the UI.

## Behavior
- Search active products by name or by manually entered barcode; camera scanning
  is not included.
- The shop owner can add multiple products, change quantities, and remove lines
  before posting. The product sale price is used without discounts or overrides.
- Cash sales may be anonymous. Credit sales must be linked to an active customer.
- Before a credit sale that exceeds the customer's configured credit limit, warn
  the owner and let them cancel, change the limit, or save anyway.
- Posting validates that every quantity is positive and available stock is
  sufficient. It then writes the sale, lines, negative `sale` inventory
  movements, and either the cash drawer increment or customer debt transaction
  in one Drift transaction.
- A cash sale cannot be posted to a closed cash-drawer day. Credit sales do not
  change the cash drawer.
- All screens read and write local Drift data and remain usable offline.

## Screens
- A quick-sale screen reachable from the inventory screen.
- Searchable product picker, editable cart lines, total, and cash/credit choice.
- Customer selection appears for credit sales; cash sales can be completed
  without choosing a customer.
- A local confirmation after a successful sale; no remote service is required.

## Acceptance criteria
- [ ] Cash and customer-credit sales can be posted with one or more products.
- [ ] Products can be found by name or manually entered barcode.
- [ ] Quantities, prices, line totals, and invoice totals use fixed-point integer
  quantities and integer piasters.
- [ ] A sale reduces stock and updates the cash drawer or customer balance in the
  same database transaction.
- [ ] Concurrent/invalid sales cannot reduce product stock below zero.
- [ ] Credit sales require an active customer; cash sales do not.
- [ ] Credit-limit warnings follow feature 04: only warn when the new balance
  exceeds a configured limit, and let the owner cancel, change the limit, or
  continue.
- [ ] Cash sales cannot be added to a closed drawer day.
- [ ] Sale history stores product, unit, sale-price, and cost snapshots and does
  not allow editing or deletion of posted records.
- [ ] Repository tests cover totals, cash/credit accounting, stock limits, and
  rollback when posting fails.
- [ ] Arabic-first UI supports a complete sale offline.

## Out of scope
- Camera barcode scanning, discounts, taxes, partial payments, digital payments,
  sale returns/voids, receipt printing, and cloud replication.
