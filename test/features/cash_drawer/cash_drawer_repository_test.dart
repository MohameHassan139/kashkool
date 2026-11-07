import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/features/cash_drawer/data/expenses_repository.dart';
import 'package:kashkool/features/cash_drawer/domain/drawer_day_summary.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/suppliers/data/supplier_repository.dart';
import 'package:kashkool/features/transactions/data/transaction_repository.dart';

void main() {
  late AppDatabase db;
  late CashDrawerRepository drawerRepo;
  late ExpensesRepository expensesRepo;
  late CustomerRepository customerRepo;
  late SupplierRepository supplierRepo;
  late TransactionRepository txRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    drawerRepo = CashDrawerRepository(db);
    expensesRepo = ExpensesRepository(db);
    customerRepo = CustomerRepository(db);
    supplierRepo = SupplierRepository(db, customerRepo);
    txRepo = TransactionRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('CashDrawerRepository Calculations and Rules', () {
    test('Expected drawer and difference calculations match formulas', () async {
      final today = DateTime(2026, 11, 6);

      // Initialize day with 200 EGP opening cash (20,000 piasters)
      await drawerRepo.updateOpeningCash(today, 20000);

      // Add cash sales of 1,000 EGP (100,000 piasters)
      await drawerRepo.updateCashSales(today, 100000);

      // Register customer who pays 150 EGP cash and 50 EGP InstaPay
      final customerId = await customerRepo.addCustomer(name: 'أحمد محمود');
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.payment,
        amountPiasters: 15000,
        method: PaymentMethod.cash,
        occurredAt: DateTime(2026, 11, 6, 11, 0),
      );
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.payment,
        amountPiasters: 5000,
        method: PaymentMethod.instapay,
        occurredAt: DateTime(2026, 11, 6, 12, 0),
      );

      // Register supplier payment: 300 EGP cash (30,000 piasters)
      final supplierId = await supplierRepo.addSupplier(name: 'مندوب الشيبسي');
      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: supplierId,
        type: TransactionType.payment,
        amountPiasters: 30000,
        method: PaymentMethod.cash,
        occurredAt: DateTime(2026, 11, 6, 13, 0),
      );

      // Add general shop expense: 50 EGP cash (5,000 piasters)
      await expensesRepo.addExpense(
        date: DateTime(2026, 11, 6, 14, 0),
        category: ExpenseCategory.supplies,
        amountPiasters: 5000,
        method: PaymentMethod.cash,
      );

      // Add digital expense (does not affect drawer): 20 EGP wallet
      await expensesRepo.addExpense(
        date: DateTime(2026, 11, 6, 15, 0),
        category: ExpenseCategory.other,
        amountPiasters: 2000,
        method: PaymentMethod.wallet,
      );

      final summary = await drawerRepo.getDaySummary(today);

      // Formula checks:
      // Cash In = Cash sales (100,000) + Customer cash (15,000) = 115,000 piasters (1,150 EGP)
      expect(summary.cashInPiasters, equals(115000));

      // Digital In = 5,000 piasters (50 EGP)
      expect(summary.digitalInPiasters, equals(5000));

      // Cash Out = Cash expenses (5,000) + Supplier cash (30,000) = 35,000 piasters (350 EGP)
      expect(summary.cashOutPiasters, equals(35000));

      // Expected Drawer = Opening (20,000) + Cash In (115,000) - Cash Out (35,000) = 100,000 piasters (1,000 EGP)
      expect(summary.expectedDrawerPiasters, equals(100000));

      // Open day difference status is uncounted
      expect(summary.differenceStatus, equals(DrawerDifferenceStatus.uncounted));
      expect(summary.isClosed, isFalse);
    });

    test('Difference calculation: Balanced (0), Shortage (عجز), Surplus (زيادة)', () async {
      final today = DateTime(2026, 11, 6);
      await drawerRepo.updateOpeningCash(today, 10000); // 100 EGP
      await drawerRepo.updateCashSales(today, 40000); // 400 EGP
      // Expected = 500 EGP (50,000 piasters)

      // 1. Balanced: count = 50,000
      await drawerRepo.closeDay(today, actualCountPiasters: 50000);
      var summary = await drawerRepo.getDaySummary(today);
      expect(summary.differencePiasters, equals(0));
      expect(summary.differenceStatus, equals(DrawerDifferenceStatus.balanced));
      expect(summary.isClosed, isTrue);

      // 2. Shortage: reopen and count = 48,000 (-20 EGP عجز)
      await drawerRepo.reopenDay(today);
      await drawerRepo.closeDay(today, actualCountPiasters: 48000, notes: 'عجز 20 جنيه فكة');
      summary = await drawerRepo.getDaySummary(today);
      expect(summary.differencePiasters, equals(-2000));
      expect(summary.differenceStatus, equals(DrawerDifferenceStatus.shortage));
      expect(summary.notes, equals('عجز 20 جنيه فكة'));

      // 3. Surplus: reopen and count = 52,000 (+20 EGP زيادة)
      await drawerRepo.reopenDay(today);
      await drawerRepo.closeDay(today, actualCountPiasters: 52000);
      summary = await drawerRepo.getDaySummary(today);
      expect(summary.differencePiasters, equals(2000));
      expect(summary.differenceStatus, equals(DrawerDifferenceStatus.surplus));
    });

    test('Opening cash auto-fills from previous closed day actual count', () async {
      final day1 = DateTime(2026, 11, 1);
      final day2 = DateTime(2026, 11, 2);

      // Day 1 has cash sales and is closed with counted actual 75,000 piasters (750 EGP)
      await drawerRepo.updateCashSales(day1, 50000);
      await drawerRepo.closeDay(day1, actualCountPiasters: 75000);

      // When day 2 is accessed for the first time, its opening cash should be 75,000
      final day2Summary = await drawerRepo.getDaySummary(day2);
      expect(day2Summary.openingCashPiasters, equals(75000));
    });

    test('addCashSales accumulates correctly on top of existing sales', () async {
      final today = DateTime(2026, 11, 6);
      await drawerRepo.updateCashSales(today, 10000); // 100 EGP
      await drawerRepo.addCashSales(today, 2500); // +25 EGP
      await drawerRepo.addCashSales(today, 5000); // +50 EGP

      final summary = await drawerRepo.getDaySummary(today);
      expect(summary.cashSalesPiasters, equals(17500)); // 175 EGP
    });

    test('Monthly totals compute aggregations across days in the month', () async {
      final day1 = DateTime(2026, 11, 5);
      final day2 = DateTime(2026, 11, 10);
      final otherMonth = DateTime(2026, 10, 20);

      await drawerRepo.updateCashSales(day1, 30000);
      await drawerRepo.updateCashSales(day2, 70000);
      await drawerRepo.updateCashSales(otherMonth, 50000);

      await expensesRepo.addExpense(
        date: DateTime(2026, 11, 7),
        category: ExpenseCategory.electricity,
        amountPiasters: 15000,
        method: PaymentMethod.cash,
      );

      final novTotals = await drawerRepo.getMonthlyTotals(DateTime(2026, 11, 1));
      expect(novTotals.totalCashSales, equals(100000));
      expect(novTotals.totalExpensesCash, equals(15000));
      expect(novTotals.netCash, equals(85000));
    });
  });
}
