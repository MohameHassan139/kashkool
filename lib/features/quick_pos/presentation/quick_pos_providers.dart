import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/customers/data/customer_repository.dart';
import '../../../features/customers/domain/customer_filter_sort.dart';
import '../../../features/customers/domain/customer_with_balance.dart';

final quickPosCustomerListProvider = StreamProvider<List<CustomerWithBalance>>((
  ref,
) {
  return ref
      .watch(customerRepositoryProvider)
      .watchCustomersWithBalance(sort: CustomerSort.name);
});
