# 23 — Product Catalog & Inventory (الأصناف والمخزون)

**Phase:** 1 · **Tier:** Free, local-first · **Depends on:** 01, 09

## User story
As a shop owner, I want to keep a simple list of products, know how much is on
hand, and spot items that need restocking without relying on an internet connection.

## Data model

### `products`
- Standard `BaseTable` metadata and soft deletion.
- `name`: required product name.
- `barcode`: optional barcode, unique within a shop when present.
- `category`: optional free-text category.
- `unitLabel`: required unit chosen for the product (for example قطعة، كجم، لتر).
- `purchasePricePiasters`, `salePricePiasters`: non-negative integer piasters per unit.
- `minimumStockMilliUnits`: non-negative threshold in thousandths of the chosen unit.
- Current quantity is derived from the stock movement ledger, not duplicated on the
  product row.

### `inventory_movements`
- Standard `BaseTable` metadata.
- `productId`: product UUID.
- `quantityDeltaMilliUnits`: signed integer; positive adds stock and negative removes it.
- `unitCostPiasters`: optional acquisition cost captured for the movement.
- `type`: opening, adjustment, purchase, sale, customer return, or supplier return.
- `note`: optional reason or reference.
- `occurredAt`: UTC event time.
- Movements are append-only. Corrections add a compensating movement; they do not
  rewrite history.

Quantities use thousandths of the selected unit to avoid floating-point arithmetic.
Money remains integer piasters.

## Screens
- Inventory tab with search, current quantity, unit, price, and low-stock status.
- Add/edit product form with optional barcode/category, unit, buy/sell prices, and
  minimum-stock threshold.
- Product details with stock-movement history and a manual stock adjustment action.
- Changes are saved to Drift first; all screens remain usable offline.

## Acceptance criteria
- [ ] Products can be added, edited, searched, and soft-deleted locally.
- [ ] Product name and unit are required; prices and stock thresholds cannot be negative.
- [ ] Current quantity is derived from active movement entries using fixed-point units.
- [ ] Stock adjustments are append-only and their history is visible.
- [ ] Low-stock status is true when current quantity is at or below the product threshold.
- [ ] Schema migration preserves existing customer, supplier, transaction, and cash data.
- [ ] Repository and quantity calculations have focused tests.
- [ ] Arabic-first UI supports a user-defined unit and displays money in integer piasters.

## Out of scope
- Purchase invoices, checkout, barcode camera scanning, multi-warehouse inventory,
  tax/e-invoice integration, and cloud replication are separate follow-up features.
