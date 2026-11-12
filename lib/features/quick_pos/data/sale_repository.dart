import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';
import '../../../features/cash_drawer/data/cash_drawer_repository.dart';
import '../../../l10n/l10n.dart';

class SaleLineInput {
  final String productId;
  final int quantityMilliUnits;

  const SaleLineInput({
    required this.productId,
    required this.quantityMilliUnits,
  });
}

class SaleRepository {
  final AppDatabase _db;
  final Uuid _uuid;

  SaleRepository(this._db, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  Future<String> createSale({
    required SalePaymentType paymentType,
    required List<SaleLineInput> lines,
    String? customerId,
    DateTime? occurredAt,
  }) async {
    if (lines.isEmpty) throw ArgumentError('A sale needs at least one line');
    if (lines.any(
      (line) => line.productId.isEmpty || line.quantityMilliUnits <= 0,
    )) {
      throw ArgumentError('Sale product and quantity are invalid');
    }
    if (paymentType == SalePaymentType.cash && customerId != null) {
      throw ArgumentError('Cash sales cannot be linked to a customer');
    }
    if (paymentType == SalePaymentType.credit &&
        (customerId == null || customerId.isEmpty)) {
      throw ArgumentError('Credit sales require a customer');
    }

    final saleId = _uuid.v4();
    final saleTime = occurredAt ?? DateTime.now();
    final occurredAtUtc = saleTime.toUtc();
    final drawerDate = saleTime.toLocal();
    final saleNote = L10n.t.quickPosSaleNote;
    var totalPiasters = 0;

    await _db.transaction(() async {
      if (paymentType == SalePaymentType.credit) {
        final customer =
            await (_db.select(_db.customers)..where(
                  (item) =>
                      item.id.equals(customerId!) & item.deletedAt.isNull(),
                ))
                .getSingleOrNull();
        if (customer == null) throw StateError('Customer not found');
      }

      final resolvedLines = <_ResolvedSaleLine>[];
      final reservedQuantities = <String, int>{};
      for (final line in lines) {
        final product =
            await (_db.select(_db.products)..where(
                  (item) =>
                      item.id.equals(line.productId) & item.deletedAt.isNull(),
                ))
                .getSingleOrNull();
        if (product == null) throw StateError('Product not found');

        final quantityOnHand = await _quantityOnHand(product.id);
        final totalRequested =
            (reservedQuantities[product.id] ?? 0) + line.quantityMilliUnits;
        if (quantityOnHand < totalRequested) {
          throw ArgumentError('Insufficient stock');
        }
        reservedQuantities[product.id] = totalRequested;

        final lineTotalPiasters = calculateLineTotalPiasters(
          quantityMilliUnits: line.quantityMilliUnits,
          unitPricePiasters: product.salePricePiasters,
        );
        totalPiasters += lineTotalPiasters;
        resolvedLines.add(
          _ResolvedSaleLine(
            productId: product.id,
            productName: product.name,
            unitLabel: product.unitLabel,
            quantityMilliUnits: line.quantityMilliUnits,
            unitPricePiasters: product.salePricePiasters,
            unitCostPiasters: product.purchasePricePiasters,
            lineTotalPiasters: lineTotalPiasters,
          ),
        );
      }

      final cashDayRepository = CashDrawerRepository(_db);
      if (paymentType == SalePaymentType.cash) {
        final cashDay = await cashDayRepository.getOrCreateDay(drawerDate);
        if (cashDay.closedAt != null) {
          throw StateError('Cash drawer day is closed');
        }
      }

      await _db
          .into(_db.sales)
          .insert(
            SalesCompanion.insert(
              id: saleId,
              customerId: Value(customerId),
              paymentType: paymentType,
              totalPiasters: totalPiasters,
              occurredAt: Value(occurredAtUtc),
              createdAt: Value(occurredAtUtc),
              updatedAt: Value(occurredAtUtc),
            ),
          );

      for (final line in resolvedLines) {
        await _db
            .into(_db.saleItems)
            .insert(
              SaleItemsCompanion.insert(
                id: _uuid.v4(),
                saleId: saleId,
                productId: line.productId,
                productName: line.productName,
                unitLabel: line.unitLabel,
                quantityMilliUnits: line.quantityMilliUnits,
                unitPricePiasters: line.unitPricePiasters,
                unitCostPiasters: line.unitCostPiasters,
                lineTotalPiasters: line.lineTotalPiasters,
                createdAt: Value(occurredAtUtc),
                updatedAt: Value(occurredAtUtc),
              ),
            );
        await _db
            .into(_db.inventoryMovements)
            .insert(
              InventoryMovementsCompanion.insert(
                id: _uuid.v4(),
                productId: line.productId,
                quantityDeltaMilliUnits: -line.quantityMilliUnits,
                unitCostPiasters: Value(line.unitCostPiasters),
                type: InventoryMovementType.sale,
                note: Value(saleNote),
                occurredAt: Value(occurredAtUtc),
                createdAt: Value(occurredAtUtc),
                updatedAt: Value(occurredAtUtc),
              ),
            );
      }

      if (paymentType == SalePaymentType.cash) {
        if (totalPiasters > 0) {
          await cashDayRepository.addCashSales(drawerDate, totalPiasters);
        }
      } else if (totalPiasters > 0) {
        await _db
            .into(_db.transactions)
            .insert(
              TransactionsCompanion.insert(
                id: _uuid.v4(),
                partyType: PartyType.customer,
                partyId: customerId!,
                type: TransactionType.debt,
                amountPiasters: totalPiasters,
                note: Value(saleNote),
                occurredAt: Value(occurredAtUtc),
                createdAt: Value(occurredAtUtc),
                updatedAt: Value(occurredAtUtc),
              ),
            );
      }
    });

    return saleId;
  }

  static int calculateLineTotalPiasters({
    required int quantityMilliUnits,
    required int unitPricePiasters,
  }) {
    if (quantityMilliUnits < 0 || unitPricePiasters < 0) {
      throw ArgumentError('Quantity and price cannot be negative');
    }
    return (quantityMilliUnits * unitPricePiasters + 500) ~/ 1000;
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
}

class _ResolvedSaleLine {
  final String productId;
  final String productName;
  final String unitLabel;
  final int quantityMilliUnits;
  final int unitPricePiasters;
  final int unitCostPiasters;
  final int lineTotalPiasters;

  const _ResolvedSaleLine({
    required this.productId,
    required this.productName,
    required this.unitLabel,
    required this.quantityMilliUnits,
    required this.unitPricePiasters,
    required this.unitCostPiasters,
    required this.lineTotalPiasters,
  });
}

final saleRepositoryProvider = Provider<SaleRepository>((ref) {
  return SaleRepository(ref.watch(databaseProvider));
});
