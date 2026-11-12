import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/inventory/data/inventory_repository.dart';

void main() {
  late AppDatabase db;
  late InventoryRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = InventoryRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'derives stock from movements and treats threshold quantity as low',
    () async {
      final id = await repository.addProduct(
        name: 'Rice',
        unitLabel: 'kg',
        purchasePricePiasters: 5000,
        salePricePiasters: 6000,
        minimumStockMilliUnits: 1500,
        startingStockMilliUnits: 1500,
      );

      var product = (await repository.watchProducts().first).single;
      expect(product.quantityMilliUnits, 1500);
      expect(product.isLowStock, isTrue);

      await repository.adjustStock(
        productId: id,
        quantityDeltaMilliUnits: 1,
        note: 'Count correction',
      );
      product = (await repository.watchProducts().first).single;
      expect(product.quantityMilliUnits, 1501);
      expect(product.isLowStock, isFalse);
    },
  );

  test('searches by barcode and rejects duplicate active barcodes', () async {
    await repository.addProduct(
      name: 'Water',
      unitLabel: 'bottle',
      purchasePricePiasters: 1000,
      salePricePiasters: 1500,
      minimumStockMilliUnits: 0,
      barcode: '123456',
    );

    expect(
      (await repository.watchProducts(query: '12345').first)
          .single
          .product
          .name,
      'Water',
    );
    await expectLater(
      repository.addProduct(
        name: 'Another water',
        unitLabel: 'bottle',
        purchasePricePiasters: 1000,
        salePricePiasters: 1500,
        minimumStockMilliUnits: 0,
        barcode: '123456',
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  test(
    'prevents negative stock and unit changes after movements exist',
    () async {
      final id = await repository.addProduct(
        name: 'Sugar',
        unitLabel: 'kg',
        purchasePricePiasters: 4000,
        salePricePiasters: 5000,
        minimumStockMilliUnits: 0,
        startingStockMilliUnits: 1000,
      );

      await expectLater(
        repository.adjustStock(
          productId: id,
          quantityDeltaMilliUnits: -1001,
          note: 'Excess removal',
        ),
        throwsA(isA<ArgumentError>()),
      );
      await expectLater(
        repository.updateProduct(
          id: id,
          name: 'Sugar',
          unitLabel: 'bag',
          purchasePricePiasters: 4000,
          salePricePiasters: 5000,
          minimumStockMilliUnits: 0,
        ),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        (await repository.watchProducts().first).single.quantityMilliUnits,
        1000,
      );
    },
  );

  test(
    'serializes competing stock removals so stock cannot become negative',
    () async {
      final id = await repository.addProduct(
        name: 'Oil',
        unitLabel: 'liter',
        purchasePricePiasters: 5000,
        salePricePiasters: 6000,
        minimumStockMilliUnits: 0,
        startingStockMilliUnits: 1000,
      );

      final outcomes = await Future.wait(
        List.generate(2, (_) async {
          try {
            await repository.adjustStock(
              productId: id,
              quantityDeltaMilliUnits: -600,
              note: 'Concurrent removal',
            );
            return true;
          } on ArgumentError {
            return false;
          }
        }),
      );

      expect(outcomes.where((succeeded) => succeeded), hasLength(1));
      expect(
        (await repository.watchProducts().first).single.quantityMilliUnits,
        400,
      );
    },
  );

  test('soft deletion hides product but keeps its movement history', () async {
    final id = await repository.addProduct(
      name: 'Flour',
      unitLabel: 'kg',
      purchasePricePiasters: 3000,
      salePricePiasters: 4000,
      minimumStockMilliUnits: 0,
      startingStockMilliUnits: 2000,
    );

    await repository.softDeleteProduct(id);
    expect(await repository.watchProducts().first, isEmpty);
    expect(await repository.watchMovements(id).first, hasLength(1));
  });
}
