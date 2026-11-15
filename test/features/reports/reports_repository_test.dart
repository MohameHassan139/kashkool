import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/features/cash_drawer/data/expenses_repository.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/inventory/data/inventory_repository.dart';
import 'package:kashkool/features/quick_pos/data/sale_repository.dart';
import 'package:kashkool/features/reports/data/reports_repository.dart';
import 'package:kashkool/features/reports/domain/profit_loss_report.dart';
import 'package:kashkool/features/suppliers/data/supplier_repository.dart';

void main() {
  late AppDatabase db;
  late ReportsRepository reportsRepository;
  late InventoryRepository inventoryRepository;
  late CustomerRepository customerRepository;
  late SupplierRepository supplierRepository;
  late CashDrawerRepository drawerRepository;
  late ExpensesRepository expensesRepository;
  late SaleRepository saleRepository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    customerRepository = CustomerRepository(db);
    supplierRepository = SupplierRepository(db, customerRepository);
    inventoryRepository = InventoryRepository(db);
    drawerRepository = CashDrawerRepository(db);
    expensesRepository = ExpensesRepository(db);
    saleRepository = SaleRepository(db);

    reportsRepository = ReportsRepository(
      db: db,
      customerRepo: customerRepository,
      supplierRepo: supplierRepository,
      inventoryRepo: inventoryRepository,
      drawerRepo: drawerRepository,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('calculates profit and loss with operating expenses subtracted', () async {
    // 1. Add product: cost 40 EGP (4000 piasters), sale 60 EGP (6000 piasters), 10 in stock
    final productId = await inventoryRepository.addProduct(
      name: 'Coffee',
      unitLabel: 'pack',
      purchasePricePiasters: 4000,
      salePricePiasters: 6000,
      minimumStockMilliUnits: 2000,
      startingStockMilliUnits: 10000,
    );

    // 2. Make cash sale of 2 packs:
    // Revenue = 2 * 6000 = 12,000 piasters
    // COGS = 2 * 4000 = 8,000 piasters
    // Gross profit = 4,000 piasters
    await saleRepository.createSale(
      paymentType: SalePaymentType.cash,
      lines: [
        SaleLineInput(productId: productId, quantityMilliUnits: 2000),
      ],
    );

    // 3. Add operating expense: Electricity 1,500 piasters
    await expensesRepository.addExpense(
      date: DateTime.now(),
      category: ExpenseCategory.electricity,
      amountPiasters: 1500,
      note: 'فاتورة الكهرباء',
    );

    // 4. Fetch Profit & Loss report
    final report =
        await reportsRepository.watchProfitLossReport(ReportPeriod.today).first;

    expect(report.totalRevenuePiasters, 12000);
    expect(report.costOfGoodsSoldPiasters, 8000);
    expect(report.grossProfitPiasters, 4000);
    expect(report.operatingExpensesPiasters, 1500);
    // Net profit = 4,000 - 1,500 = 2,500 piasters
    expect(report.netProfitPiasters, 2500);
    expect(report.isProfitable, isTrue);
    // Margin = (2500 / 12000) * 100 ~ 20.83%
    expect(report.profitMarginPercentage, closeTo(20.83, 0.1));
  });

  test('calculates comprehensive shop overview and net worth', () async {
    // 1. Add product: 10 units at 50 EGP cost, 70 EGP retail
    await inventoryRepository.addProduct(
      name: 'Olive Oil',
      unitLabel: 'bottle',
      purchasePricePiasters: 5000,
      salePricePiasters: 7000,
      minimumStockMilliUnits: 1000,
      startingStockMilliUnits: 10000,
    );

    // 2. Add customer with debt: owes 3,000 piasters
    final customerId = await customerRepository.addCustomer(
      name: 'أحمد محمود',
      phone: '01011112222',
    );
    await db.into(db.transactions).insert(
      TransactionsCompanion.insert(
        id: 'tx-cust-1',
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 3000,
      ),
    );

    // 3. Add supplier owed money: shop owes 15,000 piasters
    final supplierId = await supplierRepository.addSupplier(
      name: 'شركة الزيوت',
    );
    await db.into(db.transactions).insert(
      TransactionsCompanion.insert(
        id: 'tx-supp-1',
        partyType: PartyType.supplier,
        partyId: supplierId,
        type: TransactionType.debt,
        amountPiasters: 15000,
      ),
    );

    final overview = await reportsRepository.watchShopOverview().first;

    // Inventory cost: 10 * 5000 = 50,000 piasters
    expect(overview.inventoryCostPiasters, 50000);
    // Inventory retail: 10 * 7000 = 70,000 piasters
    expect(overview.inventoryRetailPiasters, 70000);
    // Expected profit: 20,000 piasters
    expect(overview.inventoryExpectedProfitPiasters, 20000);

    // Customer receivables: 3,000 piasters
    expect(overview.customerReceivablesPiasters, 3000);
    expect(overview.customerDebtCount, 1);

    // Supplier payables: 15,000 piasters
    expect(overview.supplierPayablesPiasters, 15000);
    expect(overview.supplierDebtCount, 1);

    // Net worth = (InventoryCost 50,000 + Cash 0 + Receivables 3,000) - Payables 15,000 = 38,000
    expect(overview.netWorthPiasters, 38000);
  });

  test('correctly splits profit into realized cash and unrealized credit at customers', () async {
    // 1. Add product: cost 20 EGP (2000 piasters), sale 35 EGP (3500 piasters)
    // Unit profit = 15 EGP (1500 piasters)
    final productId = await inventoryRepository.addProduct(
      name: 'Tea Pack',
      unitLabel: 'pack',
      purchasePricePiasters: 2000,
      salePricePiasters: 3500,
      minimumStockMilliUnits: 1000,
      startingStockMilliUnits: 10000,
    );

    // 2. Cash Sale: 2 packs = 7,000 revenue, 4,000 cost -> 3,000 cash gross profit
    await saleRepository.createSale(
      paymentType: SalePaymentType.cash,
      lines: [
        SaleLineInput(productId: productId, quantityMilliUnits: 2000),
      ],
    );

    // 3. Credit Sale: 3 packs = 10,500 revenue, 6,000 cost -> 4,500 credit gross profit
    final custId = await customerRepository.addCustomer(
      name: 'عميل آجل',
      phone: '01099998888',
    );
    await saleRepository.createSale(
      customerId: custId,
      paymentType: SalePaymentType.credit,
      lines: [
        SaleLineInput(productId: productId, quantityMilliUnits: 3000),
      ],
    );

    // 4. Operating expense of 1,000 piasters
    await expensesRepository.addExpense(
      date: DateTime.now(),
      category: ExpenseCategory.other,
      amountPiasters: 1000,
      note: 'مستلزمات نظافة',
    );

    // 5. Fetch report
    final report =
        await reportsRepository.watchProfitLossReport(ReportPeriod.today).first;

    // Cash breakdown verification
    expect(report.cashRevenuePiasters, 7000);
    expect(report.cashCogsPiasters, 4000);
    expect(report.cashGrossProfitPiasters, 3000);
    expect(report.cashNetProfitPiasters, 2000); // 3,000 - 1,000 expense
    expect(report.cashSalesCount, 1);

    // Credit breakdown verification
    expect(report.creditRevenuePiasters, 10500);
    expect(report.creditCogsPiasters, 6000);
    expect(report.creditGrossProfitPiasters, 4500); // Uncollected at customers
    expect(report.creditSalesCount, 1);

    // Total summary verification
    expect(report.totalRevenuePiasters, 17500);
    expect(report.costOfGoodsSoldPiasters, 10000);
    expect(report.grossProfitPiasters, 7500);
    expect(report.operatingExpensesPiasters, 1000);
    expect(report.netProfitPiasters, 6500);
    expect(report.netProfitPiasters, equals(report.cashNetProfitPiasters + report.creditGrossProfitPiasters));
    expect(report.totalSalesCount, 2);
    expect(report.isCashProfitable, isTrue);
    expect(report.isProfitable, isTrue);
  });
}
