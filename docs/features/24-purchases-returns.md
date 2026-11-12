# 24 — Supplier Purchases & Returns (المشتريات ومرتجعات الموردين)

**Phase:** 1 · **Tier:** Free, local-first · **Depends on:** 06, 23

## User story
As a shop owner, I want to record goods bought from a supplier, update stock and
the supplier ledger together, and return goods against a purchase when needed.

## Data model

### `purchase_invoices`
- Standard `BaseTable` metadata.
- `supplierId`: required supplier UUID.
- `invoiceNumber`: optional supplier invoice reference.
- `paymentType`: cash or credit.
- `totalPiasters`: sum of the invoice lines in integer piasters.
- `occurredAt`: UTC purchase time.

### `purchase_items`
- Standard `BaseTable` metadata.
- `purchaseId`, `productId`, product name and unit snapshots.
- `quantityMilliUnits`: positive fixed-point quantity.
- `unitCostPiasters`: non-negative cost per unit.
- `lineTotalPiasters`: rounded to the nearest piaster from quantity × unit cost.

### `supplier_returns` and `supplier_return_items`
- Standard `BaseTable` metadata and append-only records.
- A return is linked to its original purchase and purchase item, and snapshots
  the returned product, quantity, unit, and original unit cost.
- A return creates a negative `supplierReturn` inventory movement and a
  `supplierCredit` ledger entry. It reduces the supplier balance but is **not**
  treated as cash received or a cash-drawer inflow.

## Behavior
- Saving a cash purchase records the invoice, lines, stock movements, and both
  supplier debt and cash payment entries in one local database transaction.
- Saving a credit purchase records the invoice, lines, stock movements, and
  supplier debt in one local database transaction.
- Returns can only reference an item from the selected supplier's purchase.
  Returned quantity cannot exceed the remaining quantity on that item or
  reduce current stock below zero.
- Financial and inventory history is append-only; corrections use a return or
  a compensating movement instead of editing historical rows.

## Screens
- Supplier purchases list with invoice number, date, total, and cash/credit status.
- Purchase form with multiple products, quantity, unit cost, optional invoice
  number, and cash or credit payment choice.
- Purchase details with per-line remaining quantities and a partial-return action.
- Changes are saved to Drift first and all screens remain usable offline.

## Acceptance criteria
- [ ] Cash and credit purchase invoices can be recorded with one or more products.
- [ ] A purchase updates its supplier ledger and inventory in the same transaction.
- [ ] Cash purchases are represented as supplier cash payments for drawer reporting.
- [ ] A supplier return creates an append-only return, removes stock, and reduces
  the supplier balance without counting as cash received.
- [ ] Returns cannot exceed the original line quantity or current available stock.
- [ ] Partial returns preserve the remaining returnable quantity.
- [ ] Money is stored in integer piasters and quantities in thousandths.
- [ ] Arabic-first local UI supports reviewing supplier purchases.
- [ ] Repository tests cover purchase accounting, stock movements, and return limits.

## Out of scope
- Partial payment against a single invoice, purchase orders, supplier refunds in
  cash, barcode scanning, taxes, and cloud replication.
