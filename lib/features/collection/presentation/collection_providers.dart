import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/collection_repository.dart';
import '../domain/collection_summary.dart';
import '../domain/due_customer.dart';

/// Real-time stream of all customers currently due for collection.
final dueCustomersStreamProvider = StreamProvider<List<DueCustomer>>((ref) {
  final repo = ref.watch(collectionRepositoryProvider);
  return repo.watchDueCustomers();
});

/// Real-time collection metrics used by the dashboard.
final dueSummaryStreamProvider = StreamProvider<CollectionSummary>((ref) {
  final repo = ref.watch(collectionRepositoryProvider);
  return repo.watchDueCustomers().map(CollectionSummary.fromDueCustomers);
});

/// Holds the customer currently being reminded via WhatsApp,
/// so when the app resumes from the background, we can ask "هل اتبعتت الرسالة؟"
final pendingWhatsAppCustomerProvider = StateProvider<DueCustomer?>((ref) => null);
