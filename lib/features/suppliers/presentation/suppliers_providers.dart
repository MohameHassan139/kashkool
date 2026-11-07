import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../data/supplier_repository.dart';
import '../domain/supplier_filter_sort.dart';
import '../domain/supplier_with_balance.dart';

/// Active search query in suppliers screen
final supplierSearchQueryProvider = StateProvider<String>((ref) => '');

/// Active filter chip (all, hasDebt, settled)
final supplierFilterProvider = StateProvider<SupplierFilter>((ref) => SupplierFilter.all);

/// Active sorting option
final supplierSortProvider = StateProvider<SupplierSort>((ref) => SupplierSort.highestBalance);

/// Real-time stream of filtered and sorted suppliers with their balance
final suppliersListStreamProvider = StreamProvider<List<SupplierWithBalance>>((ref) {
  final repo = ref.watch(supplierRepositoryProvider);
  final query = ref.watch(supplierSearchQueryProvider);
  final filter = ref.watch(supplierFilterProvider);
  final sort = ref.watch(supplierSortProvider);

  return repo.watchSuppliersWithBalance(
    query: query,
    filter: filter,
    sort: sort,
  );
});

/// Real-time stream of total payables owed to suppliers ("عليك للموردين")
final totalPayablesStreamProvider = StreamProvider<int>((ref) {
  final repo = ref.watch(supplierRepositoryProvider);
  return repo.watchTotalPayables();
});

/// Real-time stream of Net Market Position (Receivables − Payables)
final netMarketPositionStreamProvider = StreamProvider<int>((ref) {
  final repo = ref.watch(supplierRepositoryProvider);
  return repo.watchNetMarketPosition();
});

/// Real-time stream of a single supplier with their balance
final supplierDetailsStreamProvider =
    StreamProvider.family<SupplierWithBalance?, String>((ref, supplierId) {
  final repo = ref.watch(supplierRepositoryProvider);
  return repo.watchSupplierWithBalance(supplierId);
});

/// Real-time stream of transactions for a specific supplier
final supplierTransactionsStreamProvider =
    StreamProvider.family<List<Transaction>, String>((ref, supplierId) {
  final repo = ref.watch(supplierRepositoryProvider);
  return repo.watchSupplierTransactions(supplierId);
});
