import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';
import '../../../l10n/l10n.dart';
import '../domain/purchase_details.dart';

class PurchaseRepository {
  final AppDatabase _db;
  final Uuid _uuid;

  PurchaseRepository(this._db, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  Stream<List<PurchaseInvoice>> watchPurchases(String supplierId) {
    return (_db.select(_db.purchaseInvoices)
          ..where((invoice) => invoice.supplierId.equals(supplierId))
          ..orderBy([(invoice) => OrderingTerm.desc(invoice.occurredAt)]))
        .watch();
  }

  Future<PurchaseDetails?> getPurchaseDetails(String purchaseId) async {
    final invoice = await (_db.select(
      _db.purchaseInvoices,
    )..where((item) => item.id.equals(purchaseId))).getSingleOrNull();
    if (invoice == null) return null;

    final items =
        await (_db.select(_db.purchaseItems)
              ..where((item) => item.purchaseId.equals(purchaseId))
              ..orderBy([(item) => OrderingTerm.asc(item.createdAt)]))
            .get();
    final result = <PurchaseItemWithReturns>[];
    for (final item in items) {
      result.add(
        PurchaseItemWithReturns(
          item: item,
          returnedQuantityMilliUnits: await _returnedQuantity(item.id),
        ),
      );
    }
    return PurchaseDetails(invoice: invoice, items: result);
  }

  Future<String> createPurchase({
    required String supplierId,
    required PurchasePaymentType paymentType,
    required List<PurchaseLineInput> lines,
    String? invoiceNumber,
  }) async {
    if (lines.isEmpty) {
      throw ArgumentError('A purchase needs at least one line');
    }
    for (final line in lines) {
      if (line.quantityMilliUnits <= 0 || line.unitCostPiasters < 0) {
        throw ArgumentError('Purchase quantities and costs are invalid');
      }
    }

    final lineTotals = lines
        .map(
          (line) => calculateLineTotalPiasters(
            quantityMilliUnits: line.quantityMilliUnits,
            unitCostPiasters: line.unitCostPiasters,
          ),
        )
        .toList(growable: false);
    final total = lineTotals.fold<int>(0, (sum, line) => sum + line);
    final purchaseId = _uuid.v4();
    final now = DateTime.now().toUtc();
    final cleanInvoiceNumber = _cleanOptional(invoiceNumber);

    await _db.transaction(() async {
      final supplier =
          await (_db.select(_db.suppliers)..where(
                (item) => item.id.equals(supplierId) & item.deletedAt.isNull(),
              ))
              .getSingleOrNull();
      if (supplier == null) throw StateError('Supplier not found');

      await _db
          .into(_db.purchaseInvoices)
          .insert(
            PurchaseInvoicesCompanion.insert(
              id: purchaseId,
              supplierId: supplierId,
              invoiceNumber: Value(cleanInvoiceNumber),
              paymentType: paymentType,
              totalPiasters: total,
              occurredAt: Value(now),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );

      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        final product =
            await (_db.select(_db.products)..where(
                  (item) =>
                      item.id.equals(line.productId) & item.deletedAt.isNull(),
                ))
                .getSingleOrNull();
        if (product == null) throw StateError('Product not found');

        final itemId = _uuid.v4();
        await _db
            .into(_db.purchaseItems)
            .insert(
              PurchaseItemsCompanion.insert(
                id: itemId,
                purchaseId: purchaseId,
                productId: product.id,
                productName: product.name,
                unitLabel: product.unitLabel,
                quantityMilliUnits: line.quantityMilliUnits,
                unitCostPiasters: line.unitCostPiasters,
                lineTotalPiasters: lineTotals[i],
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
        await _insertMovement(
          productId: product.id,
          quantityDeltaMilliUnits: line.quantityMilliUnits,
          unitCostPiasters: line.unitCostPiasters,
          type: InventoryMovementType.purchase,
          note: _purchaseNote(cleanInvoiceNumber),
          occurredAt: now,
        );
      }

      if (total > 0) {
        await _insertSupplierTransaction(
          supplierId: supplierId,
          type: TransactionType.debt,
          amountPiasters: total,
          note: _purchaseNote(cleanInvoiceNumber),
          occurredAt: now,
        );
        if (paymentType == PurchasePaymentType.cash) {
          await _insertSupplierTransaction(
            supplierId: supplierId,
            type: TransactionType.payment,
            amountPiasters: total,
            method: PaymentMethod.cash,
            note: _purchaseNote(cleanInvoiceNumber),
            occurredAt: now,
          );
        }
      }
    });

    return purchaseId;
  }

  Future<String> returnPurchaseItem({
    required String purchaseItemId,
    required int quantityMilliUnits,
    String? note,
  }) async {
    if (quantityMilliUnits <= 0) {
      throw ArgumentError('Return quantity must be greater than zero');
    }

    final returnId = _uuid.v4();
    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      final item = await (_db.select(
        _db.purchaseItems,
      )..where((row) => row.id.equals(purchaseItemId))).getSingleOrNull();
      if (item == null) throw StateError('Purchase item not found');

      final invoice = await (_db.select(
        _db.purchaseInvoices,
      )..where((row) => row.id.equals(item.purchaseId))).getSingleOrNull();
      if (invoice == null) throw StateError('Purchase invoice not found');

      final alreadyReturned = await _returnedQuantity(purchaseItemId);
      if (alreadyReturned + quantityMilliUnits > item.quantityMilliUnits) {
        throw ArgumentError('Return quantity exceeds the purchased quantity');
      }
      if (await _quantityOnHand(item.productId) < quantityMilliUnits) {
        throw ArgumentError('Return quantity exceeds available stock');
      }

      final amount = calculateLineTotalPiasters(
        quantityMilliUnits: quantityMilliUnits,
        unitCostPiasters: item.unitCostPiasters,
      );
      final cleanNote = _cleanOptional(note);
      await _db
          .into(_db.supplierReturns)
          .insert(
            SupplierReturnsCompanion.insert(
              id: returnId,
              supplierId: invoice.supplierId,
              purchaseId: invoice.id,
              totalPiasters: amount,
              note: Value(cleanNote),
              occurredAt: Value(now),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      await _db
          .into(_db.supplierReturnItems)
          .insert(
            SupplierReturnItemsCompanion.insert(
              id: _uuid.v4(),
              supplierReturnId: returnId,
              purchaseItemId: item.id,
              productId: item.productId,
              productName: item.productName,
              unitLabel: item.unitLabel,
              quantityMilliUnits: quantityMilliUnits,
              unitCostPiasters: item.unitCostPiasters,
              lineTotalPiasters: amount,
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      await _insertMovement(
        productId: item.productId,
        quantityDeltaMilliUnits: -quantityMilliUnits,
        unitCostPiasters: item.unitCostPiasters,
        type: InventoryMovementType.supplierReturn,
        note: cleanNote ?? L10n.t.supplierCreditNote,
        occurredAt: now,
      );
      if (amount > 0) {
        await _insertSupplierTransaction(
          supplierId: invoice.supplierId,
          type: TransactionType.supplierCredit,
          amountPiasters: amount,
          note: cleanNote ?? L10n.t.supplierCreditNote,
          occurredAt: now,
        );
      }
    });
    return returnId;
  }

  static int calculateLineTotalPiasters({
    required int quantityMilliUnits,
    required int unitCostPiasters,
  }) {
    if (quantityMilliUnits < 0 || unitCostPiasters < 0) {
      throw ArgumentError('Quantity and unit cost cannot be negative');
    }
    return (quantityMilliUnits * unitCostPiasters + 500) ~/ 1000;
  }

  Future<int> _returnedQuantity(String purchaseItemId) async {
    final rows = await _db
        .customSelect(
          '''
      SELECT COALESCE(SUM(return_items.quantity_milli_units), 0) AS quantity
      FROM supplier_return_items AS return_items
      INNER JOIN supplier_returns AS returns
        ON returns.id = return_items.supplier_return_id
      WHERE return_items.purchase_item_id = ?
        AND return_items.deleted_at IS NULL
        AND returns.deleted_at IS NULL
      ''',
          variables: [Variable.withString(purchaseItemId)],
          readsFrom: {_db.supplierReturnItems, _db.supplierReturns},
        )
        .get();
    return rows.single.read<int>('quantity');
  }

  Future<int> _quantityOnHand(String productId) async {
    final rows = await _db
        .customSelect(
          '''
      SELECT COALESCE(SUM(quantity_delta_milli_units), 0) AS quantity
      FROM inventory_movements
      WHERE product_id = ? AND deleted_at IS NULL
      ''',
          variables: [Variable.withString(productId)],
          readsFrom: {_db.inventoryMovements},
        )
        .get();
    return rows.single.read<int>('quantity');
  }

  Future<void> _insertMovement({
    required String productId,
    required int quantityDeltaMilliUnits,
    required int unitCostPiasters,
    required InventoryMovementType type,
    required String note,
    required DateTime occurredAt,
  }) async {
    await _db
        .into(_db.inventoryMovements)
        .insert(
          InventoryMovementsCompanion.insert(
            id: _uuid.v4(),
            productId: productId,
            quantityDeltaMilliUnits: quantityDeltaMilliUnits,
            unitCostPiasters: Value(unitCostPiasters),
            type: type,
            note: Value(note),
            occurredAt: Value(occurredAt),
            createdAt: Value(occurredAt),
            updatedAt: Value(occurredAt),
          ),
        );
  }

  Future<void> _insertSupplierTransaction({
    required String supplierId,
    required TransactionType type,
    required int amountPiasters,
    required String note,
    required DateTime occurredAt,
    PaymentMethod? method,
  }) async {
    await _db
        .into(_db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: _uuid.v4(),
            partyType: PartyType.supplier,
            partyId: supplierId,
            type: type,
            amountPiasters: amountPiasters,
            method: Value(method),
            note: Value(note),
            occurredAt: Value(occurredAt),
            createdAt: Value(occurredAt),
            updatedAt: Value(occurredAt),
          ),
        );
  }

  String _purchaseNote(String? invoiceNumber) => invoiceNumber == null
      ? L10n.t.supplierPurchasesTitle
      : '${L10n.t.supplierPurchasesTitle} · $invoiceNumber';

  static String? _cleanOptional(String? value) {
    final clean = value?.trim();
    return clean == null || clean.isEmpty ? null : clean;
  }
}

final purchaseRepositoryProvider = Provider<PurchaseRepository>((ref) {
  return PurchaseRepository(ref.watch(databaseProvider));
});
