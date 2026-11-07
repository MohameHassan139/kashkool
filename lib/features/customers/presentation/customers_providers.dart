import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../data/customer_repository.dart';
import '../domain/customer_filter_sort.dart';
import '../domain/customer_with_balance.dart';

/// Current search query in customers list
final customerSearchQueryProvider = StateProvider<String>((ref) => '');

/// Active filter chip (all, hasDebt, settled)
final customerFilterProvider = StateProvider<CustomerFilter>((ref) => CustomerFilter.all);

/// Active sorting strategy
final customerSortProvider = StateProvider<CustomerSort>((ref) => CustomerSort.highestBalance);

/// Real-time stream of customers filtered and sorted
final customersListStreamProvider = StreamProvider<List<CustomerWithBalance>>((ref) {
  final repo = ref.watch(customerRepositoryProvider);
  final query = ref.watch(customerSearchQueryProvider);
  final filter = ref.watch(customerFilterProvider);
  final sort = ref.watch(customerSortProvider);

  return repo.watchCustomersWithBalance(
    query: query,
    filter: filter,
    sort: sort,
  );
});

/// Real-time stream of total receivables ("ليك عند الناس")
final totalReceivablesStreamProvider = StreamProvider<int>((ref) {
  final repo = ref.watch(customerRepositoryProvider);
  return repo.watchTotalReceivables();
});

/// Stream of a specific customer with balance
final customerDetailsStreamProvider =
    StreamProvider.family<CustomerWithBalance?, String>((ref, customerId) {
  final repo = ref.watch(customerRepositoryProvider);
  return repo.watchCustomerWithBalance(customerId);
});

/// Stream of transaction history for a specific customer
final customerTransactionsStreamProvider =
    StreamProvider.family<List<Transaction>, String>((ref, customerId) {
  final repo = ref.watch(customerRepositoryProvider);
  return repo.watchCustomerTransactions(customerId);
});
