/// Filter options for customers list
enum CustomerFilter {
  /// All active customers
  all,

  /// Only customers who currently owe money (balance > 0)
  hasDebt,

  /// Only customers whose accounts are settled (balance == 0)
  settled,

  /// Only customers with Late (متأخرين) rating
  late,
}

/// Sort options for customers list
enum CustomerSort {
  /// Highest debt first (default)
  highestBalance,

  /// Alphabetically by customer name
  name,

  /// Most recently active first
  lastActivity,
}
