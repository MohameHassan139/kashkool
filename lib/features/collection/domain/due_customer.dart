import '../../../core/db/app_database.dart';
import '../../../core/utils/customer_rating.dart';

/// Presentation/Domain model representing a customer who is due for collection reminder.
class DueCustomer {
  final Customer customer;
  final int balancePiasters;
  final int oldestUnpaidAgeDays;
  final DateTime? lastTransactionAt;
  final Transaction? lastTransaction;
  final CustomerRatingResult rating;

  const DueCustomer({
    required this.customer,
    required this.balancePiasters,
    required this.oldestUnpaidAgeDays,
    this.lastTransactionAt,
    this.lastTransaction,
    required this.rating,
  });

  /// Days elapsed since the last reminder was sent (null if never reminded)
  int? get daysSinceLastReminder {
    if (customer.lastReminderAt == null) return null;
    return DateTime.now().difference(customer.lastReminderAt!).inDays;
  }

  /// Whether reminder is currently snoozed
  bool get isSnoozed {
    if (customer.snoozedUntil == null) return false;
    return customer.snoozedUntil!.isAfter(DateTime.now());
  }
}
