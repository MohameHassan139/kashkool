enum ReportPeriod { today, last7Days, thisMonth, allTime }

/// Summary model for shop Profit & Loss over a given time window,
/// separating realized cash profit from unrealized credit profit at customers.
class ProfitLossReport {
  final ReportPeriod period;
  final DateTime startDate;
  final DateTime endDate;

  // --- Realized Cash Breakdown (أرباح نقدية محصلة بالدرج) ---
  final int cashRevenuePiasters;
  final int cashCogsPiasters;
  final int cashGrossProfitPiasters;
  final int cashNetProfitPiasters;

  // --- Unrealized Receivables Breakdown (أرباح آجلة عند العملاء لم تُحصل) ---
  final int creditRevenuePiasters;
  final int creditCogsPiasters;
  final int creditGrossProfitPiasters;

  // --- Total Summary (الإجمالي الكلي) ---
  final int totalRevenuePiasters;
  final int costOfGoodsSoldPiasters;
  final int grossProfitPiasters;
  final int operatingExpensesPiasters;
  final int netProfitPiasters;
  final double profitMarginPercentage;

  // Counts
  final int totalSalesCount;
  final int cashSalesCount;
  final int creditSalesCount;
  final int totalExpensesCount;

  const ProfitLossReport({
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.cashRevenuePiasters,
    required this.cashCogsPiasters,
    required this.cashGrossProfitPiasters,
    required this.cashNetProfitPiasters,
    required this.creditRevenuePiasters,
    required this.creditCogsPiasters,
    required this.creditGrossProfitPiasters,
    required this.totalRevenuePiasters,
    required this.costOfGoodsSoldPiasters,
    required this.grossProfitPiasters,
    required this.operatingExpensesPiasters,
    required this.netProfitPiasters,
    required this.profitMarginPercentage,
    required this.totalSalesCount,
    this.cashSalesCount = 0,
    this.creditSalesCount = 0,
    required this.totalExpensesCount,
  });

  bool get isProfitable => netProfitPiasters >= 0;
  bool get isCashProfitable => cashNetProfitPiasters >= 0;
}
