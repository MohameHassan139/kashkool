import 'due_customer.dart';

/// Aggregated metrics shown on the collection dashboard.
class CollectionSummary {
  final int count;
  final int totalPiasters;
  final int dueSoonCount;
  final int overdueCount;

  const CollectionSummary({
    required this.count,
    required this.totalPiasters,
    required this.dueSoonCount,
    required this.overdueCount,
  });

  /// Builds dashboard metrics from the current collection queue.
  ///
  /// A debt is considered overdue when its oldest unpaid amount is at least
  /// 30 days old. The remaining due customers are due soon.
  factory CollectionSummary.fromDueCustomers(Iterable<DueCustomer> customers) {
    var totalPiasters = 0;
    var dueSoonCount = 0;
    var overdueCount = 0;

    for (final customer in customers) {
      totalPiasters += customer.balancePiasters;
      if (customer.oldestUnpaidAgeDays >= 30) {
        overdueCount++;
      } else {
        dueSoonCount++;
      }
    }

    return CollectionSummary(
      count: dueSoonCount + overdueCount,
      totalPiasters: totalPiasters,
      dueSoonCount: dueSoonCount,
      overdueCount: overdueCount,
    );
  }
}
