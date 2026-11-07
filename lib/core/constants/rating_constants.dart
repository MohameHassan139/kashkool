/// Thresholds for calculating customer credit rating.
abstract final class RatingConstants {
  /// Maximum days of unpaid debt to still be considered "Good" (ممتاز)
  static const int goodThresholdDays = 14;

  /// Days of unpaid debt after which customer is marked "Late" (متأخر)
  static const int lateThresholdDays = 45;

  /// Minimum transactions required before assigning regular rating (otherwise "New")
  static const int minTransactionsForRegular = 3;
}
