import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../cash_drawer/data/cash_drawer_repository.dart';
import '../../customers/data/customer_repository.dart';
import '../../inventory/data/inventory_repository.dart';
import '../../suppliers/data/supplier_repository.dart';
import '../domain/profit_loss_report.dart';
import '../domain/shop_financial_overview.dart';

class ReportsRepository {
  final AppDatabase _db;
  final CustomerRepository _customerRepo;
  final SupplierRepository _supplierRepo;
  final InventoryRepository _inventoryRepo;
  final CashDrawerRepository _drawerRepo;

  ReportsRepository({
    required AppDatabase db,
    required CustomerRepository customerRepo,
    required SupplierRepository supplierRepo,
    required InventoryRepository inventoryRepo,
    required CashDrawerRepository drawerRepo,
  })  : _db = db,
        _customerRepo = customerRepo,
        _supplierRepo = supplierRepo,
        _inventoryRepo = inventoryRepo,
        _drawerRepo = drawerRepo;

  /// Calculates the start and end DateTime for a given [period].
  (DateTime, DateTime) _getDateRange(ReportPeriod period,
      {DateTime? customStart, DateTime? customEnd}) {
    final now = DateTime.now();
    switch (period) {
      case ReportPeriod.today:
        final start = DateTime(now.year, now.month, now.day);
        final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        return (start, end);
      case ReportPeriod.last7Days:
        final sevenDaysAgo = now.subtract(const Duration(days: 6));
        final start = DateTime(
            sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day);
        final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        return (start, end);
      case ReportPeriod.thisMonth:
        final start = DateTime(now.year, now.month, 1);
        final end = DateTime(now.year, now.month + 1, 0, 23, 59, 59, 999);
        return (start, end);
      case ReportPeriod.allTime:
        final start = DateTime(2020, 1, 1);
        final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        return (start, end);
    }
  }

  /// Watches or computes the Profit & Loss report for a specified [period].
  Stream<ProfitLossReport> watchProfitLossReport(ReportPeriod period,
      {DateTime? customStart, DateTime? customEnd}) async* {
    final (start, end) = _getDateRange(period,
        customStart: customStart, customEnd: customEnd);

    // Watch sales table for changes
    final salesStream = (_db.select(_db.sales)
          ..where((s) =>
              s.occurredAt.isBiggerOrEqualValue(start.toUtc()) &
              s.occurredAt.isSmallerOrEqualValue(end.toUtc()) &
              s.deletedAt.isNull()))
        .watch();

    await for (final _ in salesStream) {
      final sales = await (_db.select(_db.sales)
            ..where((s) =>
                s.occurredAt.isBiggerOrEqualValue(start.toUtc()) &
                s.occurredAt.isSmallerOrEqualValue(end.toUtc()) &
                s.deletedAt.isNull()))
          .get();

      final saleIds = sales.map((s) => s.id).toSet();
      final saleItems = saleIds.isEmpty
          ? <SaleItem>[]
          : await (_db.select(_db.saleItems)
                ..where((item) =>
                    item.saleId.isIn(saleIds) & item.deletedAt.isNull()))
              .get();

      final expenses = await (_db.select(_db.expenses)
            ..where((e) =>
                e.date.isBiggerOrEqualValue(start) &
                e.date.isSmallerOrEqualValue(end) &
                e.category.isNotValue(ExpenseCategory.supplierPayment.name) &
                e.deletedAt.isNull()))
          .get();

      final cashDays = await (_db.select(_db.cashDays)
            ..where((c) =>
                c.date.isBiggerOrEqualValue(start) &
                c.date.isSmallerOrEqualValue(end) &
                c.deletedAt.isNull()))
          .get();

      var revenuePiasters = 0;
      var cogsPiasters = 0;
      var posCashSales = 0;

      for (final item in saleItems) {
        revenuePiasters += item.lineTotalPiasters;
        final cost = (item.quantityMilliUnits * item.unitCostPiasters + 500) ~/ 1000;
        cogsPiasters += cost;
      }

      for (final s in sales) {
        if (s.paymentType == SalePaymentType.cash) {
          posCashSales += s.totalPiasters;
        }
      }

      // Add manual drawer cash sales that exceed POS cash sales
      var totalDrawerCashSales = 0;
      for (final day in cashDays) {
        totalDrawerCashSales += day.cashSalesPiasters;
      }
      if (totalDrawerCashSales > posCashSales) {
        revenuePiasters += (totalDrawerCashSales - posCashSales);
      }

      var operatingExpenses = 0;
      for (final e in expenses) {
        operatingExpenses += e.amountPiasters;
      }

      final grossProfit = revenuePiasters - cogsPiasters;
      final netProfit = grossProfit - operatingExpenses;
      final margin = revenuePiasters > 0
          ? (netProfit / revenuePiasters) * 100.0
          : 0.0;

      yield ProfitLossReport(
        period: period,
        startDate: start,
        endDate: end,
        totalRevenuePiasters: revenuePiasters,
        costOfGoodsSoldPiasters: cogsPiasters,
        grossProfitPiasters: grossProfit,
        operatingExpensesPiasters: operatingExpenses,
        netProfitPiasters: netProfit,
        profitMarginPercentage: margin,
        totalSalesCount: sales.length,
        totalExpensesCount: expenses.length,
      );
    }
  }

  /// Builds the real-time Shop Financial & Inventory Overview.
  Stream<ShopFinancialOverview> watchShopOverview() async* {
    final productsStream = _inventoryRepo.watchProducts();

    await for (final products in productsStream) {
      final customers = await _customerRepo.watchCustomersWithBalance().first;
      final suppliers = await _supplierRepo.watchSuppliersWithBalance().first;
      final drawerSummary =
          await _drawerRepo.watchDaySummary(DateTime.now()).first;

      // 1. Inventory Valuation
      var invCost = 0;
      var invRetail = 0;
      var lowStock = 0;

      for (final p in products) {
        if (p.quantityMilliUnits > 0) {
          final cost = (p.quantityMilliUnits * p.product.purchasePricePiasters + 500) ~/ 1000;
          final retail = (p.quantityMilliUnits * p.product.salePricePiasters + 500) ~/ 1000;
          invCost += cost;
          invRetail += retail;
        }
        if (p.isLowStock) {
          lowStock++;
        }
      }

      final invExpectedProfit = invRetail - invCost;

      // 2. Receivables from customers
      var receivables = 0;
      var custDebtCount = 0;
      for (final c in customers) {
        if (c.balancePiasters > 0) {
          receivables += c.balancePiasters;
          custDebtCount++;
        }
      }

      // 3. Payables to suppliers
      var payables = 0;
      var suppDebtCount = 0;
      for (final s in suppliers) {
        if (s.balancePiasters > 0) {
          payables += s.balancePiasters;
          suppDebtCount++;
        }
      }

      // 4. Cash and Drawer
      final cashInDrawer = drawerSummary.expectedDrawerPiasters;
      final digital = drawerSummary.customerDigitalPaymentsPiasters;
      final totalCashBank = cashInDrawer + digital;

      // 5. Net Shop Worth (Net Capital)
      final int netWorth = (invCost + totalCashBank + receivables) - payables;

      yield ShopFinancialOverview(
        generatedAt: DateTime.now(),
        inventoryCostPiasters: invCost,
        inventoryRetailPiasters: invRetail,
        inventoryExpectedProfitPiasters: invExpectedProfit,
        totalProductCount: products.length,
        lowStockCount: lowStock,
        customerReceivablesPiasters: receivables,
        customerDebtCount: custDebtCount,
        supplierPayablesPiasters: payables,
        supplierDebtCount: suppDebtCount,
        cashInDrawerPiasters: cashInDrawer,
        digitalBalancePiasters: digital,
        totalCashAndBankPiasters: totalCashBank,
        netWorthPiasters: netWorth,
      );
    }
  }
}

final reportsRepositoryProvider = Provider<ReportsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final customerRepo = ref.watch(customerRepositoryProvider);
  final supplierRepo = ref.watch(supplierRepositoryProvider);
  final inventoryRepo = ref.watch(inventoryRepositoryProvider);
  final drawerRepo = ref.watch(cashDrawerRepositoryProvider);

  return ReportsRepository(
    db: db,
    customerRepo: customerRepo,
    supplierRepo: supplierRepo,
    inventoryRepo: inventoryRepo,
    drawerRepo: drawerRepo,
  );
});

final selectedProfitLossPeriodProvider =
    StateProvider<ReportPeriod>((ref) => ReportPeriod.thisMonth);

final profitLossReportStreamProvider =
    StreamProvider<ProfitLossReport>((ref) {
  final repo = ref.watch(reportsRepositoryProvider);
  final period = ref.watch(selectedProfitLossPeriodProvider);
  return repo.watchProfitLossReport(period);
});

final shopOverviewStreamProvider =
    StreamProvider<ShopFinancialOverview>((ref) {
  final repo = ref.watch(reportsRepositoryProvider);
  return repo.watchShopOverview();
});
