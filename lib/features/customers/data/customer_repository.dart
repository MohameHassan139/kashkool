import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/arabic_search.dart';
import '../../../core/utils/customer_rating.dart';
import '../../../core/utils/phone.dart';
import '../domain/customer_filter_sort.dart';
import '../domain/customer_with_balance.dart';

/// Repository handling all customer database operations, balance calculations, and search.
class CustomerRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  CustomerRepository(this._db);

  /// Watches all active customers with their dynamically computed balance.
  ///
  /// Joins Customers and Transactions, so this stream emits immediately whenever
  /// either table is modified (new customer, new debt, payment recorded, deletion, etc.).
  Stream<List<CustomerWithBalance>> watchCustomersWithBalance({
    String? query,
    CustomerFilter filter = CustomerFilter.all,
    CustomerSort sort = CustomerSort.highestBalance,
  }) {
    final joinedQuery = _db.select(_db.customers).join([
      leftOuterJoin(
        _db.transactions,
        _db.transactions.partyId.equalsExp(_db.customers.id) &
            _db.transactions.partyType.equalsValue(PartyType.customer) &
            _db.transactions.deletedAt.isNull(),
      ),
    ])..where(_db.customers.deletedAt.isNull());

    return joinedQuery.watch().map((rows) {
      final Map<String, Customer> customerMap = {};
      final Map<String, int> balanceMap = {};
      final Map<String, DateTime?> lastActivityMap = {};
      final Map<String, int> countMap = {};
      final Map<String, List<Transaction>> txMap = {};

      for (final row in rows) {
        final customer = row.readTable(_db.customers);
        final transaction = row.readTableOrNull(_db.transactions);

        customerMap[customer.id] = customer;
        balanceMap.putIfAbsent(customer.id, () => 0);
        countMap.putIfAbsent(customer.id, () => 0);

        if (transaction != null) {
          countMap[customer.id] = (countMap[customer.id] ?? 0) + 1;
          txMap.putIfAbsent(customer.id, () => []).add(transaction);

          // Debt adds to what customer owes (+), Payment reduces it (-)
          if (transaction.type == TransactionType.debt) {
            balanceMap[customer.id] = (balanceMap[customer.id] ?? 0) + transaction.amountPiasters;
          } else {
            balanceMap[customer.id] = (balanceMap[customer.id] ?? 0) - transaction.amountPiasters;
          }

          final currentLast = lastActivityMap[customer.id];
          if (currentLast == null || transaction.occurredAt.isAfter(currentLast)) {
            lastActivityMap[customer.id] = transaction.occurredAt;
          }
        }
      }

      var list = customerMap.values.map((customer) {
        final transactions = txMap[customer.id] ?? const [];
        final balance = balanceMap[customer.id] ?? 0;
        final rating = CustomerRatingUtils.compute(
          transactions: transactions,
          balancePiasters: balance,
          creditLimitPiasters: customer.creditLimitPiasters,
        );

        return CustomerWithBalance(
          customer: customer,
          balancePiasters: balance,
          lastTransactionAt: lastActivityMap[customer.id],
          transactionCount: countMap[customer.id] ?? 0,
          rating: rating,
        );
      }).toList();

      // 1. Search Query filtering (with Arabic letter tolerance)
      if (query != null && query.trim().isNotEmpty) {
        final q = query.trim();
        list = list.where((item) {
          final nameMatch = ArabicSearchUtils.matches(item.customer.name, q);
          final phoneMatch = item.customer.phone != null && item.customer.phone!.contains(q);
          return nameMatch || phoneMatch;
        }).toList();
      }

      // 2. Chip Filter (all, hasDebt, settled, late)
      switch (filter) {
        case CustomerFilter.all:
          break;
        case CustomerFilter.hasDebt:
          list = list.where((item) => item.balancePiasters > 0).toList();
          break;
        case CustomerFilter.settled:
          list = list.where((item) => item.balancePiasters == 0).toList();
          break;
        case CustomerFilter.late:
          list = list.where((item) => item.rating.badge == RatingBadge.late).toList();
          break;
      }

      // 3. Sorting
      switch (sort) {
        case CustomerSort.highestBalance:
          list.sort((a, b) => b.balancePiasters.compareTo(a.balancePiasters));
          break;
        case CustomerSort.name:
          list.sort((a, b) => ArabicSearchUtils.normalize(a.customer.name)
              .compareTo(ArabicSearchUtils.normalize(b.customer.name)));
          break;
        case CustomerSort.lastActivity:
          list.sort((a, b) {
            final aTime = a.lastTransactionAt ?? a.customer.createdAt;
            final bTime = b.lastTransactionAt ?? b.customer.createdAt;
            return bTime.compareTo(aTime);
          });
          break;
      }

      return list;
    });
  }

  /// Watches the total amount owed to the shop by all active customers ("ليك عند الناس").
  Stream<int> watchTotalReceivables() {
    return watchCustomersWithBalance().map((customers) {
      var total = 0;
      for (final c in customers) {
        if (c.balancePiasters > 0) {
          total += c.balancePiasters;
        }
      }
      return total;
    });
  }

  /// Watches a single customer with their computed balance.
  Stream<CustomerWithBalance?> watchCustomerWithBalance(String customerId) {
    return watchCustomersWithBalance().map((customers) {
      final matches = customers.where((c) => c.customer.id == customerId);
      return matches.isEmpty ? null : matches.first;
    });
  }

  /// Gets a single customer with their computed balance (single read).
  Future<CustomerWithBalance?> getCustomerWithBalance(String customerId) async {
    final stream = watchCustomerWithBalance(customerId);
    return await stream.first;
  }

  /// Watches full transaction history for a customer, newest first.
  Stream<List<Transaction>> watchCustomerTransactions(String customerId) {
    return (_db.select(_db.transactions)
          ..where((t) =>
              t.partyId.equals(customerId) &
              t.partyType.equalsValue(PartyType.customer) &
              t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
        .watch();
  }

  /// Adds a new customer.
  Future<String> addCustomer({
    required String name,
    String? phone,
    String? notes,
    int? creditLimitPiasters,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.length < 2 || trimmedName.length > 60) {
      throw ArgumentError('Customer name must be between 2 and 60 characters');
    }

    final normalizedPhone = PhoneUtils.normalize(phone);
    final id = _uuid.v4();
    final now = DateTime.now();

    await _db.into(_db.customers).insert(
          CustomersCompanion.insert(
            id: id,
            name: trimmedName,
            phone: Value(normalizedPhone),
            notes: Value(notes?.trim().isEmpty == true ? null : notes?.trim()),
            creditLimitPiasters: Value(creditLimitPiasters),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

    return id;
  }

  /// Updates an existing customer's details.
  Future<void> updateCustomer({
    required String id,
    required String name,
    String? phone,
    String? notes,
    int? creditLimitPiasters,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.length < 2 || trimmedName.length > 60) {
      throw ArgumentError('Customer name must be between 2 and 60 characters');
    }

    final normalizedPhone = PhoneUtils.normalize(phone);
    final now = DateTime.now();

    await (_db.update(_db.customers)..where((c) => c.id.equals(id))).write(
      CustomersCompanion(
        name: Value(trimmedName),
        phone: Value(normalizedPhone),
        notes: Value(notes?.trim().isEmpty == true ? null : notes?.trim()),
        creditLimitPiasters: Value(creditLimitPiasters),
        updatedAt: Value(now),
      ),
    );
  }

  /// Soft deletes a customer (sets deletedAt timestamp).
  Future<void> deleteCustomer(String id) async {
    final now = DateTime.now();
    await (_db.update(_db.customers)..where((c) => c.id.equals(id))).write(
      CustomersCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  /// Checks if another customer exists with identical phone or normalized name.
  Future<Customer?> checkForDuplicates({
    required String name,
    String? phone,
    String? excludeCustomerId,
  }) async {
    final activeCustomers = await (_db.select(_db.customers)
          ..where((c) => c.deletedAt.isNull()))
        .get();

    final normalizedTargetName = ArabicSearchUtils.normalize(name);
    final normalizedTargetPhone = PhoneUtils.normalize(phone);

    for (final c in activeCustomers) {
      if (excludeCustomerId != null && c.id == excludeCustomerId) continue;

      if (normalizedTargetPhone != null && c.phone != null && c.phone == normalizedTargetPhone) {
        return c;
      }

      if (ArabicSearchUtils.normalize(c.name) == normalizedTargetName) {
        return c;
      }
    }

    return null;
  }
}

/// Global provider for CustomerRepository
final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return CustomerRepository(db);
});
