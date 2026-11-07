import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';
import '../domain/drawer_day_summary.dart';

/// Aggregated monthly totals for sales, collections, and expenses.
class MonthlyDrawerTotals {
  final int totalCashSales;
  final int totalCustomerCash;
  final int totalCustomerDigital;
  final int totalSupplierCash;
  final int totalExpensesCash;
  final int totalExpensesDigital;

  const MonthlyDrawerTotals({
    required this.totalCashSales,
    required this.totalCustomerCash,
    required this.totalCustomerDigital,
    required this.totalSupplierCash,
    required this.totalExpensesCash,
    required this.totalExpensesDigital,
  });

  int get totalCashIn => totalCashSales + totalCustomerCash;
  int get totalCashOut => totalExpensesCash + totalSupplierCash;
  int get netCash => totalCashIn - totalCashOut;
}

/// Repository responsible for cash drawer calculations, day closing, history, and sales.
class CashDrawerRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  CashDrawerRepository(this._db);

  /// Normalizes any timestamp to midnight of that calendar day.
  static DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Gets existing CashDay record or creates a new one for [date].
  /// Auto-fills opening cash from the previous closed day if available.
  Future<CashDay> getOrCreateDay(DateTime date) async {
    final normDate = normalizeDate(date);

    final existing = await (_db.select(_db.cashDays)
          ..where((tbl) => tbl.date.equals(normDate) & tbl.deletedAt.isNull()))
        .getSingleOrNull();

    if (existing != null) {
      return existing;
    }

    // Auto-fill opening cash from the most recent closed day before this date
    final prevClosedDay = await (_db.select(_db.cashDays)
          ..where((tbl) =>
              tbl.date.isSmallerThanValue(normDate) &
              tbl.closedAt.isNotNull() &
              tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
          ..limit(1))
        .getSingleOrNull();

    final openingCash = prevClosedDay?.actualCountPiasters ?? 0;

    final now = DateTime.now();
    final companion = CashDaysCompanion(
      id: Value(_uuid.v4()),
      date: Value(normDate),
      openingCashPiasters: Value(openingCash),
      cashSalesPiasters: const Value(0),
      actualCountPiasters: const Value(null),
      closedAt: const Value(null),
      notes: const Value(null),
      createdAt: Value(now),
      updatedAt: Value(now),
    );

    await _db.into(_db.cashDays).insert(
      companion,
      mode: InsertMode.insertOrIgnore,
    );
    return await (_db.select(_db.cashDays)..where((tbl) => tbl.date.equals(normDate))).getSingle();
  }

  /// Updates the opening cash for a specific day.
  Future<void> updateOpeningCash(DateTime date, int openingPiasters) async {
    if (openingPiasters < 0) {
      throw ArgumentError('Opening cash cannot be negative');
    }
    final day = await getOrCreateDay(date);
    await (_db.update(_db.cashDays)..where((tbl) => tbl.id.equals(day.id))).write(
      CashDaysCompanion(
        openingCashPiasters: Value(openingPiasters),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Sets the daily cash sales amount.
  Future<void> updateCashSales(DateTime date, int cashSalesPiasters) async {
    if (cashSalesPiasters < 0) {
      throw ArgumentError('Cash sales cannot be negative');
    }
    final day = await getOrCreateDay(date);
    await (_db.update(_db.cashDays)..where((tbl) => tbl.id.equals(day.id))).write(
      CashDaysCompanion(
        cashSalesPiasters: Value(cashSalesPiasters),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Increments the daily cash sales by [additionalPiasters].
  Future<void> addCashSales(DateTime date, int additionalPiasters) async {
    if (additionalPiasters <= 0) {
      throw ArgumentError('Additional sales must be positive');
    }
    final day = await getOrCreateDay(date);
    final newSales = day.cashSalesPiasters + additionalPiasters;
    await updateCashSales(date, newSales);
  }

  /// Closes the drawer for [date] with the counted physical money.
  Future<void> closeDay(
    DateTime date, {
    required int actualCountPiasters,
    String? notes,
  }) async {
    if (actualCountPiasters < 0) {
      throw ArgumentError('Actual count cannot be negative');
    }
    final day = await getOrCreateDay(date);
    final now = DateTime.now();
    await (_db.update(_db.cashDays)..where((tbl) => tbl.id.equals(day.id))).write(
      CashDaysCompanion(
        actualCountPiasters: Value(actualCountPiasters),
        closedAt: Value(now),
        notes: Value(notes?.trim()),
        updatedAt: Value(now),
      ),
    );
  }

  /// Reopens a closed day to allow corrections.
  Future<void> reopenDay(DateTime date) async {
    final day = await getOrCreateDay(date);
    final now = DateTime.now();
    await (_db.update(_db.cashDays)..where((tbl) => tbl.id.equals(day.id))).write(
      CashDaysCompanion(
        closedAt: const Value(null),
        updatedAt: Value(now),
      ),
    );
  }

  /// Calculates the complete daily summary for [date].
  Future<DrawerDaySummary> getDaySummary(DateTime date) async {
    final normDate = normalizeDate(date);
    final dayStart = DateTime(normDate.year, normDate.month, normDate.day, 0, 0, 0);
    final dayEnd = DateTime(normDate.year, normDate.month, normDate.day, 23, 59, 59, 999);

    final cashDay = await getOrCreateDay(normDate);

    // Customer payments
    final customerTransactions = await (_db.select(_db.transactions)
          ..where((tbl) =>
              tbl.partyType.equalsValue(PartyType.customer) &
              tbl.type.equalsValue(TransactionType.payment) &
              tbl.occurredAt.isBiggerOrEqualValue(dayStart) &
              tbl.occurredAt.isSmallerOrEqualValue(dayEnd) &
              tbl.deletedAt.isNull()))
        .get();

    final customerCash = customerTransactions
        .where((t) => t.method == PaymentMethod.cash || t.method == null)
        .fold<int>(0, (sum, t) => sum + t.amountPiasters);

    final customerDigital = customerTransactions
        .where((t) => t.method == PaymentMethod.instapay || t.method == PaymentMethod.wallet)
        .fold<int>(0, (sum, t) => sum + t.amountPiasters);

    // Supplier payments
    final supplierTransactions = await (_db.select(_db.transactions)
          ..where((tbl) =>
              tbl.partyType.equalsValue(PartyType.supplier) &
              tbl.type.equalsValue(TransactionType.payment) &
              tbl.occurredAt.isBiggerOrEqualValue(dayStart) &
              tbl.occurredAt.isSmallerOrEqualValue(dayEnd) &
              tbl.deletedAt.isNull()))
        .get();

    final supplierCash = supplierTransactions
        .where((t) => t.method == PaymentMethod.cash || t.method == null)
        .fold<int>(0, (sum, t) => sum + t.amountPiasters);

    // Expenses
    final dayExpenses = await (_db.select(_db.expenses)
          ..where((tbl) =>
              tbl.date.isBiggerOrEqualValue(dayStart) &
              tbl.date.isSmallerOrEqualValue(dayEnd) &
              tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
        .get();

    final expensesCash = dayExpenses
        .where((e) => e.method == PaymentMethod.cash)
        .fold<int>(0, (sum, e) => sum + e.amountPiasters);

    final expensesDigital = dayExpenses
        .where((e) => e.method != PaymentMethod.cash)
        .fold<int>(0, (sum, e) => sum + e.amountPiasters);

    return DrawerDaySummary(
      date: normDate,
      cashDayId: cashDay.id,
      openingCashPiasters: cashDay.openingCashPiasters,
      cashSalesPiasters: cashDay.cashSalesPiasters,
      customerCashPaymentsPiasters: customerCash,
      customerDigitalPaymentsPiasters: customerDigital,
      supplierCashPaymentsPiasters: supplierCash,
      expensesCashPiasters: expensesCash,
      expensesDigitalPiasters: expensesDigital,
      actualCountPiasters: cashDay.actualCountPiasters,
      closedAt: cashDay.closedAt,
      notes: cashDay.notes,
      expenses: dayExpenses,
    );
  }

  /// Watches the reactive daily summary for [date].
  Stream<DrawerDaySummary> watchDaySummary(DateTime date) async* {
    final normDate = normalizeDate(date);
    yield await getDaySummary(normDate);

    yield* _db
        .tableUpdates(TableUpdateQuery.onAllTables([
          _db.cashDays,
          _db.transactions,
          _db.expenses,
        ]))
        .asyncMap((_) => getDaySummary(normDate));
  }

  /// Watches historical cash days.
  Stream<List<CashDay>> watchHistory({DateTime? from, DateTime? to}) {
    final query = _db.select(_db.cashDays)
      ..where((tbl) => tbl.deletedAt.isNull());

    if (from != null) {
      query.where((tbl) => tbl.date.isBiggerOrEqualValue(from));
    }
    if (to != null) {
      query.where((tbl) => tbl.date.isSmallerOrEqualValue(to));
    }

    query.orderBy([(tbl) => OrderingTerm.desc(tbl.date)]);
    return query.watch();
  }

  /// Computes monthly totals for the calendar month containing [monthDate].
  Future<MonthlyDrawerTotals> getMonthlyTotals(DateTime monthDate) async {
    final monthStart = DateTime(monthDate.year, monthDate.month, 1, 0, 0, 0);
    final monthEnd = DateTime(monthDate.year, monthDate.month + 1, 0, 23, 59, 59, 999);

    // Cash days in month
    final days = await (_db.select(_db.cashDays)
          ..where((tbl) =>
              tbl.date.isBiggerOrEqualValue(monthStart) &
              tbl.date.isSmallerOrEqualValue(monthEnd) &
              tbl.deletedAt.isNull()))
        .get();

    final totalSales = days.fold<int>(0, (sum, d) => sum + d.cashSalesPiasters);

    // Customer payments in month
    final customerPayments = await (_db.select(_db.transactions)
          ..where((tbl) =>
              tbl.partyType.equalsValue(PartyType.customer) &
              tbl.type.equalsValue(TransactionType.payment) &
              tbl.occurredAt.isBiggerOrEqualValue(monthStart) &
              tbl.occurredAt.isSmallerOrEqualValue(monthEnd) &
              tbl.deletedAt.isNull()))
        .get();

    final totalCustomerCash = customerPayments
        .where((t) => t.method == PaymentMethod.cash || t.method == null)
        .fold<int>(0, (sum, t) => sum + t.amountPiasters);

    final totalCustomerDigital = customerPayments
        .where((t) => t.method == PaymentMethod.instapay || t.method == PaymentMethod.wallet)
        .fold<int>(0, (sum, t) => sum + t.amountPiasters);

    // Supplier payments in month
    final supplierPayments = await (_db.select(_db.transactions)
          ..where((tbl) =>
              tbl.partyType.equalsValue(PartyType.supplier) &
              tbl.type.equalsValue(TransactionType.payment) &
              tbl.occurredAt.isBiggerOrEqualValue(monthStart) &
              tbl.occurredAt.isSmallerOrEqualValue(monthEnd) &
              tbl.deletedAt.isNull()))
        .get();

    final totalSupplierCash = supplierPayments
        .where((t) => t.method == PaymentMethod.cash || t.method == null)
        .fold<int>(0, (sum, t) => sum + t.amountPiasters);

    // Expenses in month
    final expenses = await (_db.select(_db.expenses)
          ..where((tbl) =>
              tbl.date.isBiggerOrEqualValue(monthStart) &
              tbl.date.isSmallerOrEqualValue(monthEnd) &
              tbl.deletedAt.isNull()))
        .get();

    final totalExpensesCash = expenses
        .where((e) => e.method == PaymentMethod.cash)
        .fold<int>(0, (sum, e) => sum + e.amountPiasters);

    final totalExpensesDigital = expenses
        .where((e) => e.method != PaymentMethod.cash)
        .fold<int>(0, (sum, e) => sum + e.amountPiasters);

    return MonthlyDrawerTotals(
      totalCashSales: totalSales,
      totalCustomerCash: totalCustomerCash,
      totalCustomerDigital: totalCustomerDigital,
      totalSupplierCash: totalSupplierCash,
      totalExpensesCash: totalExpensesCash,
      totalExpensesDigital: totalExpensesDigital,
    );
  }

  /// Watches monthly totals reactively.
  Stream<MonthlyDrawerTotals> watchMonthlyTotals(DateTime monthDate) async* {
    yield await getMonthlyTotals(monthDate);

    yield* _db
        .tableUpdates(TableUpdateQuery.onAllTables([
          _db.cashDays,
          _db.transactions,
          _db.expenses,
        ]))
        .asyncMap((_) => getMonthlyTotals(monthDate));
  }
}

/// Provider for CashDrawerRepository singleton.
final cashDrawerRepositoryProvider = Provider<CashDrawerRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return CashDrawerRepository(db);
});

/// Reactive stream of today's drawer summary.
final todayDrawerSummaryProvider = StreamProvider<DrawerDaySummary>((ref) {
  final repo = ref.watch(cashDrawerRepositoryProvider);
  return repo.watchDaySummary(DateTime.now());
});

/// Reactive stream of historical drawer days.
final drawerHistoryProvider = StreamProvider<List<CashDay>>((ref) {
  final repo = ref.watch(cashDrawerRepositoryProvider);
  return repo.watchHistory();
});

/// Reactive stream of this month's drawer totals.
final currentMonthTotalsProvider = StreamProvider<MonthlyDrawerTotals>((ref) {
  final repo = ref.watch(cashDrawerRepositoryProvider);
  return repo.watchMonthlyTotals(DateTime.now());
});
