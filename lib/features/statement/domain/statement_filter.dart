/// Period filter options for customer statement
enum StatementPeriod {
  /// All recorded transactions since inception
  allTime,

  /// Transactions in the current calendar month
  thisMonth,

  /// Custom date range specified by user
  custom,
}

/// Paper format options for the generated PDF
enum StatementPageFormat {
  /// Standard A4 document page
  a4,

  /// 80mm continuous thermal receipt roll
  thermalRoll80,
}
