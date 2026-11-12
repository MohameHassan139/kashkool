import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/collection_repository.dart';
import '../domain/due_customer.dart';

/// Real-time stream of all customers currently due for collection.
final dueCustomersStreamProvider = StreamProvider<List<DueCustomer>>((ref) {
  final repo = ref.watch(collectionRepositoryProvider);
  return repo.watchDueCustomers();
});

/// Real-time collection metrics used by the dashboard.
///
/// `dueSoonCount` contains customers with an unpaid debt younger than 30 days.
/// `overdueCount` contains customers whose oldest unpaid debt is at least 30 days old.
final dueSummaryStreamProvider = StreamProvider<({
  int count,
  int totalPiasters,
  int dueSoonCount,
  int overdueCount,
})>((ref) {
  final repo = ref.watch(collectionRepositoryProvider);
  return repo.watchDueCustomers().map((list) {
    var totalPiasters = 0;
    var dueSoonCount = 0;
    var overdueCount = 0;

    for (final customer in list) {
      totalPiasters += customer.balancePiasters;
      if (customer.oldestUnpaidAgeDays >= 30) {
        overdueCount++;
      } else {
        dueSoonCount++;
      }
    }

    return (
      count: list.length,
      totalPiasters: totalPiasters,
      dueSoonCount: dueSoonCount,
      overdueCount: overdueCount,
    );
  });
});

/// Holds the customer currently being reminded via WhatsApp,
/// so when the app resumes from the background, we can ask "هل اتبعتت الرسالة؟"
final pendingWhatsAppCustomerProvider = StateProvider<DueCustomer?>((ref) => null);
