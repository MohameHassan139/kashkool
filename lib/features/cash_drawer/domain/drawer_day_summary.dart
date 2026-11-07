import '../../../core/db/app_database.dart';

enum DrawerDifferenceStatus {
  balanced, // difference == 0
  shortage, // difference < 0 (عجز)
  surplus, // difference > 0 (زيادة)
  uncounted, // day still open or no count entered
}

/// Comprehensive daily summary of cash drawer status, transactions, and expenses.
class DrawerDaySummary {
  final DateTime date;
  final String? cashDayId;
  final int openingCashPiasters;
  final int cashSalesPiasters;
  final int customerCashPaymentsPiasters;
  final int customerDigitalPaymentsPiasters;
  final int supplierCashPaymentsPiasters;
  final int expensesCashPiasters;
  final int expensesDigitalPiasters;
  final int? actualCountPiasters;
  final DateTime? closedAt;
  final String? notes;
  final List<Expense> expenses;

  const DrawerDaySummary({
    required this.date,
    this.cashDayId,
    required this.openingCashPiasters,
    required this.cashSalesPiasters,
    required this.customerCashPaymentsPiasters,
    required this.customerDigitalPaymentsPiasters,
    required this.supplierCashPaymentsPiasters,
    required this.expensesCashPiasters,
    required this.expensesDigitalPiasters,
    this.actualCountPiasters,
    this.closedAt,
    this.notes,
    this.expenses = const [],
  });

  /// Cash In = Cash Sales + Customer Payments with method = cash
  int get cashInPiasters => cashSalesPiasters + customerCashPaymentsPiasters;

  /// Digital In = Customer Payments with method ∈ {instapay, wallet}
  int get digitalInPiasters => customerDigitalPaymentsPiasters;

  /// Cash Out = Expenses (cash) + Supplier Payments (cash)
  int get cashOutPiasters => expensesCashPiasters + supplierCashPaymentsPiasters;

  /// Expected Drawer = Opening + Cash In - Cash Out
  int get expectedDrawerPiasters => openingCashPiasters + cashInPiasters - cashOutPiasters;

  /// Difference = Actual Count - Expected Drawer
  int? get differencePiasters =>
      actualCountPiasters != null ? (actualCountPiasters! - expectedDrawerPiasters) : null;

  /// Difference status (balanced, shortage, surplus, uncounted)
  DrawerDifferenceStatus get differenceStatus {
    final diff = differencePiasters;
    if (diff == null) return DrawerDifferenceStatus.uncounted;
    if (diff == 0) return DrawerDifferenceStatus.balanced;
    if (diff < 0) return DrawerDifferenceStatus.shortage;
    return DrawerDifferenceStatus.surplus;
  }

  /// Whether this business day has been finalized and closed
  bool get isClosed => closedAt != null;

  DrawerDaySummary copyWith({
    DateTime? date,
    String? cashDayId,
    int? openingCashPiasters,
    int? cashSalesPiasters,
    int? customerCashPaymentsPiasters,
    int? customerDigitalPaymentsPiasters,
    int? supplierCashPaymentsPiasters,
    int? expensesCashPiasters,
    int? expensesDigitalPiasters,
    int? actualCountPiasters,
    DateTime? closedAt,
    String? notes,
    List<Expense>? expenses,
  }) {
    return DrawerDaySummary(
      date: date ?? this.date,
      cashDayId: cashDayId ?? this.cashDayId,
      openingCashPiasters: openingCashPiasters ?? this.openingCashPiasters,
      cashSalesPiasters: cashSalesPiasters ?? this.cashSalesPiasters,
      customerCashPaymentsPiasters:
          customerCashPaymentsPiasters ?? this.customerCashPaymentsPiasters,
      customerDigitalPaymentsPiasters:
          customerDigitalPaymentsPiasters ?? this.customerDigitalPaymentsPiasters,
      supplierCashPaymentsPiasters:
          supplierCashPaymentsPiasters ?? this.supplierCashPaymentsPiasters,
      expensesCashPiasters: expensesCashPiasters ?? this.expensesCashPiasters,
      expensesDigitalPiasters: expensesDigitalPiasters ?? this.expensesDigitalPiasters,
      actualCountPiasters: actualCountPiasters ?? this.actualCountPiasters,
      closedAt: closedAt ?? this.closedAt,
      notes: notes ?? this.notes,
      expenses: expenses ?? this.expenses,
    );
  }
}
