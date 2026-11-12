import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';
import '../domain/product_with_stock.dart';

class InventoryRepository {
  final AppDatabase _db;
  final Uuid _uuid;

  InventoryRepository(this._db, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  Stream<List<ProductWithStock>> watchProducts({String query = ''}) {
    final trimmed = query.trim();
    final pattern = '%$trimmed%';
    final totalQuantity = _db.inventoryMovements.quantityDeltaMilliUnits.sum();
    final statement =
        (_db.select(_db.products)..where(
              (product) =>
                  product.deletedAt.isNull() &
                  (product.name.like(pattern) |
                      product.barcode.like(pattern) |
                      product.category.like(pattern)),
            ))
            .join([
              leftOuterJoin(
                _db.inventoryMovements,
                _db.inventoryMovements.productId.equalsExp(_db.products.id) &
                    _db.inventoryMovements.deletedAt.isNull(),
              ),
            ]);
    statement.addColumns([totalQuantity]);
    statement.groupBy([_db.products.id]);
    statement.orderBy([
      OrderingTerm(expression: _db.products.name, mode: OrderingMode.asc),
    ]);

    return statement.watch().map(
      (rows) => rows
          .map(
            (row) => ProductWithStock(
              product: row.readTable(_db.products),
              quantityMilliUnits: row.read(totalQuantity) ?? 0,
            ),
          )
          .toList(growable: false),
    );
  }

  Stream<List<InventoryMovement>> watchMovements(String productId) {
    return (_db.select(_db.inventoryMovements)
          ..where((movement) => movement.productId.equals(productId))
          ..orderBy([(movement) => OrderingTerm.desc(movement.occurredAt)]))
        .watch();
  }

  Future<String> addProduct({
    required String name,
    required String unitLabel,
    required int purchasePricePiasters,
    required int salePricePiasters,
    required int minimumStockMilliUnits,
    String? barcode,
    String? category,
    int startingStockMilliUnits = 0,
  }) async {
    _validateProduct(
      name: name,
      unitLabel: unitLabel,
      purchasePricePiasters: purchasePricePiasters,
      salePricePiasters: salePricePiasters,
      minimumStockMilliUnits: minimumStockMilliUnits,
      startingStockMilliUnits: startingStockMilliUnits,
    );
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    final cleanBarcode = _cleanOptional(barcode);

    await _db.transaction(() async {
      await _ensureBarcodeAvailable(cleanBarcode);
      await _db
          .into(_db.products)
          .insert(
            ProductsCompanion.insert(
              id: id,
              name: name.trim(),
              barcode: Value(cleanBarcode),
              category: Value(_cleanOptional(category)),
              unitLabel: unitLabel.trim(),
              purchasePricePiasters: purchasePricePiasters,
              salePricePiasters: salePricePiasters,
              minimumStockMilliUnits: minimumStockMilliUnits,
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      if (startingStockMilliUnits > 0) {
        await _insertMovement(
          productId: id,
          quantityDeltaMilliUnits: startingStockMilliUnits,
          type: InventoryMovementType.opening,
          unitCostPiasters: purchasePricePiasters,
          note: null,
          occurredAt: now,
        );
      }
    });
    return id;
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required String unitLabel,
    required int purchasePricePiasters,
    required int salePricePiasters,
    required int minimumStockMilliUnits,
    String? barcode,
    String? category,
  }) async {
    _validateProduct(
      name: name,
      unitLabel: unitLabel,
      purchasePricePiasters: purchasePricePiasters,
      salePricePiasters: salePricePiasters,
      minimumStockMilliUnits: minimumStockMilliUnits,
      startingStockMilliUnits: 0,
    );
    final cleanBarcode = _cleanOptional(barcode);
    await _db.transaction(() async {
      final existing =
          await (_db.select(_db.products)..where(
                (product) => product.id.equals(id) & product.deletedAt.isNull(),
              ))
              .getSingleOrNull();
      if (existing == null) throw StateError('Product not found');
      if (existing.unitLabel != unitLabel.trim() &&
          await (_db.select(_db.inventoryMovements)
                    ..where((movement) => movement.productId.equals(id))
                    ..limit(1))
                  .getSingleOrNull() !=
              null) {
        throw ArgumentError(
          'Cannot change a product unit after stock movements',
        );
      }
      await _ensureBarcodeAvailable(cleanBarcode, excludingId: id);
      await (_db.update(
        _db.products,
      )..where((product) => product.id.equals(id))).write(
        ProductsCompanion(
          name: Value(name.trim()),
          barcode: Value(cleanBarcode),
          category: Value(_cleanOptional(category)),
          unitLabel: Value(unitLabel.trim()),
          purchasePricePiasters: Value(purchasePricePiasters),
          salePricePiasters: Value(salePricePiasters),
          minimumStockMilliUnits: Value(minimumStockMilliUnits),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
    });
  }

  Future<void> adjustStock({
    required String productId,
    required int quantityDeltaMilliUnits,
    required String note,
    int? unitCostPiasters,
  }) async {
    if (quantityDeltaMilliUnits == 0) {
      throw ArgumentError('Stock adjustment cannot be zero');
    }
    if (unitCostPiasters != null && unitCostPiasters < 0) {
      throw ArgumentError('Unit cost cannot be negative');
    }
    await _db.transaction(() async {
      final product =
          await (_db.select(_db.products)..where(
                (item) => item.id.equals(productId) & item.deletedAt.isNull(),
              ))
              .getSingleOrNull();
      if (product == null) throw StateError('Product not found');
      final current = await _quantityOnHand(productId);
      if (current + quantityDeltaMilliUnits < 0) {
        throw ArgumentError('Stock cannot be reduced below zero');
      }
      final now = DateTime.now().toUtc();
      await _insertMovement(
        productId: productId,
        quantityDeltaMilliUnits: quantityDeltaMilliUnits,
        type: InventoryMovementType.adjustment,
        unitCostPiasters: unitCostPiasters,
        note: note.trim().isEmpty ? null : note.trim(),
        occurredAt: now,
      );
      await (_db.update(_db.products)
            ..where((item) => item.id.equals(productId)))
          .write(ProductsCompanion(updatedAt: Value(now)));
    });
  }

  Future<void> softDeleteProduct(String id) async {
    final now = DateTime.now().toUtc();
    final updated =
        await (_db.update(_db.products)..where(
              (product) => product.id.equals(id) & product.deletedAt.isNull(),
            ))
            .write(
              ProductsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
            );
    if (updated == 0) throw StateError('Product not found');
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

  Future<void> _ensureBarcodeAvailable(
    String? barcode, {
    String? excludingId,
  }) async {
    if (barcode == null) return;
    final query = _db.select(_db.products)
      ..where(
        (product) =>
            product.barcode.equals(barcode) & product.deletedAt.isNull(),
      );
    if (excludingId != null) {
      query.where((product) => product.id.equals(excludingId).not());
    }
    if (await query.getSingleOrNull() != null) {
      throw ArgumentError('Barcode already exists');
    }
  }

  Future<void> _insertMovement({
    required String productId,
    required int quantityDeltaMilliUnits,
    required InventoryMovementType type,
    required int? unitCostPiasters,
    required String? note,
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

  static void _validateProduct({
    required String name,
    required String unitLabel,
    required int purchasePricePiasters,
    required int salePricePiasters,
    required int minimumStockMilliUnits,
    required int startingStockMilliUnits,
  }) {
    final cleanName = name.trim();
    final cleanUnit = unitLabel.trim();
    if (cleanName.isEmpty || cleanName.length > 100) {
      throw ArgumentError('Product name must be between 1 and 100 characters');
    }
    if (cleanUnit.isEmpty || cleanUnit.length > 24) {
      throw ArgumentError('Unit must be between 1 and 24 characters');
    }
    if (purchasePricePiasters < 0 ||
        salePricePiasters < 0 ||
        minimumStockMilliUnits < 0 ||
        startingStockMilliUnits < 0) {
      throw ArgumentError('Prices and quantities cannot be negative');
    }
  }

  static String? _cleanOptional(String? value) {
    final clean = value?.trim();
    return clean == null || clean.isEmpty ? null : clean;
  }
}

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepository(ref.watch(databaseProvider));
});
