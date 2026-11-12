import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/inventory/data/inventory_repository.dart';
import 'package:kashkool/features/purchases/data/purchase_repository.dart';
import 'package:kashkool/features/purchases/domain/purchase_details.dart';
import 'package:kashkool/features/suppliers/data/supplier_repository.dart';

void main() {
  late AppDatabase db;
  late InventoryRepository inventoryRepository;
  late PurchaseRepository purchaseRepository;
  late SupplierRepository supplierRepository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    inventoryRepository = InventoryRepository(db);
    purchaseRepository = PurchaseRepository(db);
    supplierRepository = SupplierRepository(db, CustomerRepository(db));
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'cash and credit purchases update stock, supplier balance, and drawer',
    () async {
      final supplierId = await supplierRepository.addSupplier(
        name: 'مورد النور',
      );
      final productId = await inventoryRepository.addProduct(
        name: 'Rice',
        unitLabel: 'kg',
        purchasePricePiasters: 5000,
        salePricePiasters: 6000,
        minimumStockMilliUnits: 0,
      );

      await purchaseRepository.createPurchase(
        supplierId: supplierId,
        paymentType: PurchasePaymentType.credit,
        invoiceNumber: 'C-1',
        lines: [
          PurchaseLineInput(
            productId: productId,
            quantityMilliUnits: 1000,
            unitCostPiasters: 5000,
          ),
        ],
      );
      expect(
        (await supplierRepository.getSupplierWithBalance(
          supplierId,
        ))!.balancePiasters,
        5000,
      );

      await purchaseRepository.createPurchase(
        supplierId: supplierId,
        paymentType: PurchasePaymentType.cash,
        invoiceNumber: 'P-2',
        lines: [
          PurchaseLineInput(
            productId: productId,
            quantityMilliUnits: 2000,
            unitCostPiasters: 6000,
          ),
        ],
      );

      expect(
        (await inventoryRepository.watchProducts().first)
            .single
            .quantityMilliUnits,
        3000,
      );
      expect(
        (await supplierRepository.getSupplierWithBalance(
          supplierId,
        ))!.balancePiasters,
        5000,
      );
      final drawer = await CashDrawerRepository(
        db,
      ).getDaySummary(DateTime.now());
      expect(drawer.supplierCashPaymentsPiasters, 12000);
    },
  );

  test(
    'partial supplier returns reduce stock and payable without over-returning',
    () async {
      final supplierId = await supplierRepository.addSupplier(
        name: 'مورد الأمانة',
      );
      final productId = await inventoryRepository.addProduct(
        name: 'Oil',
        unitLabel: 'liter',
        purchasePricePiasters: 5000,
        salePricePiasters: 7000,
        minimumStockMilliUnits: 0,
      );
      final purchaseId = await purchaseRepository.createPurchase(
        supplierId: supplierId,
        paymentType: PurchasePaymentType.credit,
        lines: [
          PurchaseLineInput(
            productId: productId,
            quantityMilliUnits: 3000,
            unitCostPiasters: 5000,
          ),
        ],
      );
      final item = (await purchaseRepository.getPurchaseDetails(
        purchaseId,
      ))!.items.single;

      await purchaseRepository.returnPurchaseItem(
        purchaseItemId: item.item.id,
        quantityMilliUnits: 1000,
        note: 'عبوة تالفة',
      );
      var details = (await purchaseRepository.getPurchaseDetails(purchaseId))!;
      expect(details.items.single.remainingQuantityMilliUnits, 2000);
      expect(
        (await supplierRepository.getSupplierWithBalance(
          supplierId,
        ))!.balancePiasters,
        10000,
      );
      expect(
        (await inventoryRepository.watchProducts().first)
            .single
            .quantityMilliUnits,
        2000,
      );

      await expectLater(
        purchaseRepository.returnPurchaseItem(
          purchaseItemId: item.item.id,
          quantityMilliUnits: 2001,
        ),
        throwsA(isA<ArgumentError>()),
      );

      await inventoryRepository.adjustStock(
        productId: productId,
        quantityDeltaMilliUnits: -1500,
        note: 'Sold stock',
      );
      await expectLater(
        purchaseRepository.returnPurchaseItem(
          purchaseItemId: item.item.id,
          quantityMilliUnits: 1000,
        ),
        throwsA(isA<ArgumentError>()),
      );

      await purchaseRepository.returnPurchaseItem(
        purchaseItemId: item.item.id,
        quantityMilliUnits: 500,
      );
      details = (await purchaseRepository.getPurchaseDetails(purchaseId))!;
      expect(details.items.single.remainingQuantityMilliUnits, 1500);
      expect(
        (await supplierRepository.getSupplierWithBalance(
          supplierId,
        ))!.balancePiasters,
        7500,
      );
      expect(
        (await inventoryRepository.watchProducts().first)
            .single
            .quantityMilliUnits,
        0,
      );
    },
  );

  test('rounds fractional-unit line totals to the nearest piaster', () {
    expect(
      PurchaseRepository.calculateLineTotalPiasters(
        quantityMilliUnits: 1500,
        unitCostPiasters: 1001,
      ),
      1502,
    );
  });

  test(
    'rolls back the invoice when a purchase line references a missing product',
    () async {
      final supplierId = await supplierRepository.addSupplier(
        name: 'مورد المدينة',
      );

      await expectLater(
        purchaseRepository.createPurchase(
          supplierId: supplierId,
          paymentType: PurchasePaymentType.credit,
          lines: const [
            PurchaseLineInput(
              productId: 'missing-product',
              quantityMilliUnits: 1000,
              unitCostPiasters: 2500,
            ),
          ],
        ),
        throwsA(isA<StateError>()),
      );

      expect(await db.select(db.purchaseInvoices).get(), isEmpty);
      expect(await db.select(db.purchaseItems).get(), isEmpty);
      expect(await db.select(db.transactions).get(), isEmpty);
    },
  );
}
