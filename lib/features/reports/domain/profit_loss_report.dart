enum ReportPeriod { today, last7Days, thisMonth, allTime }

/// Summary model for shop Profit & Loss over a given time window.
class ProfitLossReport {
  final ReportPeriod period;
  final DateTime startDate;
  final DateTime endDate;
  final int totalRevenuePiasters;
  final int costOfGoodsSoldPiasters;
  final int grossProfitPiasters;
  final int operatingExpensesPiasters;
  final int netProfitPiasters;
  final double profitMarginPercentage;
  final int totalSalesCount;
  final int totalExpensesCount;

  const ProfitLossReport({
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.totalRevenuePiasters,
    required this.costOfGoodsSoldPiasters,
    required this.grossProfitPiasters,
    required this.operatingExpensesPiasters,
    required this.netProfitPiasters,
    required this.profitMarginPercentage,
    required this.totalSalesCount,
    required this.totalExpensesCount,
  });

  bool get isProfitable => netProfitPiasters >= 0;
}
