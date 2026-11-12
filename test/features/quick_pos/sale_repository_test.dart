import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/inventory/data/inventory_repository.dart';
import 'package:kashkool/features/quick_pos/data/sale_repository.dart';

void main() {
  late AppDatabase db;
  late InventoryRepository inventoryRepository;
  late CustomerRepository customerRepository;
  late SaleRepository saleRepository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    inventoryRepository = InventoryRepository(db);
    customerRepository = CustomerRepository(db);
    saleRepository = SaleRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'cash sale reduces stock and increments the cash drawer atomically',
    () async {
      final productId = await inventoryRepository.addProduct(
        name: 'Rice',
        unitLabel: 'kg',
        purchasePricePiasters: 4000,
        salePricePiasters: 6000,
        minimumStockMilliUnits: 0,
        startingStockMilliUnits: 3000,
      );

      final saleId = await saleRepository.createSale(
        paymentType: SalePaymentType.cash,
        occurredAt: DateTime(2026, 5, 12, 12),
        lines: [SaleLineInput(productId: productId, quantityMilliUnits: 1500)],
      );

      final sale = await (db.select(
        db.sales,
      )..where((row) => row.id.equals(saleId))).getSingle();
      final item = (await db.select(db.saleItems).get()).single;
      expect(sale.paymentType, SalePaymentType.cash);
      expect(sale.totalPiasters, 9000);
      expect(item.quantityMilliUnits, 1500);
      expect(item.unitPricePiasters, 6000);
      expect(item.unitCostPiasters, 4000);
      expect(
        (await inventoryRepository.watchProducts().first)
            .single
            .quantityMilliUnits,
        1500,
      );
      final drawer = await CashDrawerRepository(
        db,
      ).getDaySummary(DateTime(2026, 5, 12));
      expect(drawer.cashSalesPiasters, 9000);
      expect(await db.select(db.transactions).get(), isEmpty);
    },
  );

  test(
    'credit sale records one customer debt and does not change cash sales',
    () async {
      final customerId = await customerRepository.addCustomer(name: 'أحمد');
      final productId = await inventoryRepository.addProduct(
        name: 'Oil',
        unitLabel: 'liter',
        purchasePricePiasters: 5000,
        salePricePiasters: 7000,
        minimumStockMilliUnits: 0,
        startingStockMilliUnits: 2000,
      );

      final saleId = await saleRepository.createSale(
        paymentType: SalePaymentType.credit,
        customerId: customerId,
        occurredAt: DateTime(2026, 5, 12, 12),
        lines: [SaleLineInput(productId: productId, quantityMilliUnits: 1000)],
      );

      final balance = await customerRepository.getCustomerWithBalance(
        customerId,
      );
      expect(balance!.balancePiasters, 7000);
      expect(
        (await db.select(db.transactions).get()).single.type,
        TransactionType.debt,
      );
      expect(
        (await (db.select(
          db.sales,
        )..where((row) => row.id.equals(saleId))).getSingle()).customerId,
        customerId,
      );
      final drawer = await CashDrawerRepository(
        db,
      ).getDaySummary(DateTime(2026, 5, 12));
      expect(drawer.cashSalesPiasters, 0);
    },
  );

  test('rejects overselling and rolls back every sale side effect', () async {
    final productId = await inventoryRepository.addProduct(
      name: 'Tea',
      unitLabel: 'box',
      purchasePricePiasters: 2000,
      salePricePiasters: 3000,
      minimumStockMilliUnits: 0,
      startingStockMilliUnits: 1000,
    );

    await expectLater(
      saleRepository.createSale(
        paymentType: SalePaymentType.cash,
        occurredAt: DateTime(2026, 5, 12, 12),
        lines: [SaleLineInput(productId: productId, quantityMilliUnits: 1001)],
      ),
      throwsA(isA<ArgumentError>()),
    );

    expect(await db.select(db.sales).get(), isEmpty);
    expect(await db.select(db.saleItems).get(), isEmpty);
    expect(
      (await inventoryRepository.watchProducts().first)
          .single
          .quantityMilliUnits,
      1000,
    );
    expect(await db.select(db.cashDays).get(), isEmpty);
  });

  test('duplicate lines cannot collectively oversell a product', () async {
    final productId = await inventoryRepository.addProduct(
      name: 'Sugar',
      unitLabel: 'kg',
      purchasePricePiasters: 1000,
      salePricePiasters: 1500,
      minimumStockMilliUnits: 0,
      startingStockMilliUnits: 1500,
    );

    await expectLater(
      saleRepository.createSale(
        paymentType: SalePaymentType.cash,
        lines: [
          SaleLineInput(productId: productId, quantityMilliUnits: 1000),
          SaleLineInput(productId: productId, quantityMilliUnits: 501),
        ],
      ),
      throwsA(isA<ArgumentError>()),
    );
    expect(await db.select(db.sales).get(), isEmpty);
    expect(
      (await inventoryRepository.watchProducts().first)
          .single
          .quantityMilliUnits,
      1500,
    );
  });

  test('serializes competing sales so stock cannot become negative', () async {
    final productId = await inventoryRepository.addProduct(
      name: 'Flour',
      unitLabel: 'kg',
      purchasePricePiasters: 1000,
      salePricePiasters: 1500,
      minimumStockMilliUnits: 0,
      startingStockMilliUnits: 1500,
    );

    Future<bool> trySale() async {
      try {
        await saleRepository.createSale(
          paymentType: SalePaymentType.cash,
          lines: [
            SaleLineInput(productId: productId, quantityMilliUnits: 1000),
          ],
        );
        return true;
      } on ArgumentError {
        return false;
      }
    }

    final results = await Future.wait([trySale(), trySale()]);
    expect(results.where((saved) => saved).length, 1);
    expect(
      (await inventoryRepository.watchProducts().first)
          .single
          .quantityMilliUnits,
      500,
    );
    expect(await db.select(db.sales).get(), hasLength(1));
  });

  test('cash sale cannot be recorded after the drawer day is closed', () async {
    final productId = await inventoryRepository.addProduct(
      name: 'Coffee',
      unitLabel: 'bag',
      purchasePricePiasters: 1000,
      salePricePiasters: 1500,
      minimumStockMilliUnits: 1000,
      startingStockMilliUnits: 2000,
    );
    final cashDrawer = CashDrawerRepository(db);
    await cashDrawer.getOrCreateDay(DateTime(2026, 5, 12));
    await cashDrawer.closeDay(DateTime(2026, 5, 12), actualCountPiasters: 1000);

    await expectLater(
      saleRepository.createSale(
        paymentType: SalePaymentType.cash,
        occurredAt: DateTime(2026, 5, 12, 12),
        lines: [SaleLineInput(productId: productId, quantityMilliUnits: 1000)],
      ),
      throwsA(isA<StateError>()),
    );
    expect(await db.select(db.sales).get(), isEmpty);
    expect(
      (await inventoryRepository.watchProducts().first)
          .single
          .quantityMilliUnits,
      2000,
    );
  });

  test('rounds fractional-unit totals to the nearest piaster', () {
    expect(
      SaleRepository.calculateLineTotalPiasters(
        quantityMilliUnits: 1500,
        unitPricePiasters: 1001,
      ),
      1502,
    );
  });
}
