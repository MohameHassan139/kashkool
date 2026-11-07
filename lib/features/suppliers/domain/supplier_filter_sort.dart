/// Filter options for suppliers list
enum SupplierFilter {
  /// All active suppliers
  all,

  /// Only suppliers we currently owe money to (balance > 0)
  hasDebt,

  /// Only suppliers whose accounts are settled (balance == 0)
  settled,
}

/// Sort options for suppliers list
enum SupplierSort {
  /// Highest amount we owe first
  highestBalance,

  /// Alphabetically by rep name
  name,

  /// Alphabetically by company name
  company,

  /// By scheduled weekly visit day
  visitDay,
}
