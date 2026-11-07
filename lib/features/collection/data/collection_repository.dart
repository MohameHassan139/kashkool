import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/customer_rating.dart';
import '../../settings/data/settings_repository.dart';
import '../domain/due_customer.dart';

/// Repository managing collection eligibility, due customer calculations, and reminders.
class CollectionRepository {
  final AppDatabase _db;
  final SettingsRepository _settingsRepo;

  CollectionRepository(this._db, this._settingsRepo);

  /// Watches the list of customers currently due for daily collection reminder.
  ///
  /// A customer is due when ALL of the following conditions are met:
  /// 1. balance > 0
  /// 2. has valid phone number
  /// 3. oldestUnpaidAgeDays >= settings.minDebtAgeDays (default: 3)
  /// 4. lastReminderAt is null or >= settings.reminderIntervalDays (default: 7) ago
  /// 5. snoozedUntil is null or in the past
  Stream<List<DueCustomer>> watchDueCustomers({DateTime? customNow}) {
    final joinedQuery = _db.select(_db.customers).join([
      leftOuterJoin(
        _db.transactions,
        _db.transactions.partyId.equalsExp(_db.customers.id) &
            _db.transactions.partyType.equalsValue(PartyType.customer) &
            _db.transactions.deletedAt.isNull(),
      ),
    ])..where(_db.customers.deletedAt.isNull());

    return joinedQuery.watch().asyncMap((rows) async {
      final now = customNow ?? DateTime.now();
      final minDebtAgeDays = await _settingsRepo.getMinDebtAgeDays();
      final reminderIntervalDays = await _settingsRepo.getReminderIntervalDays();

      final Map<String, Customer> customerMap = {};
      final Map<String, int> balanceMap = {};
      final Map<String, DateTime?> lastActivityMap = {};
      final Map<String, Transaction?> lastTxMap = {};
      final Map<String, List<Transaction>> txMap = {};

      for (final row in rows) {
        final customer = row.readTable(_db.customers);
        final transaction = row.readTableOrNull(_db.transactions);

        customerMap[customer.id] = customer;
        balanceMap.putIfAbsent(customer.id, () => 0);

        if (transaction != null) {
          txMap.putIfAbsent(customer.id, () => []).add(transaction);

          if (transaction.type == TransactionType.debt) {
            balanceMap[customer.id] = (balanceMap[customer.id] ?? 0) + transaction.amountPiasters;
          } else {
            balanceMap[customer.id] = (balanceMap[customer.id] ?? 0) - transaction.amountPiasters;
          }

          final currentLast = lastActivityMap[customer.id];
          if (currentLast == null || transaction.occurredAt.isAfter(currentLast)) {
            lastActivityMap[customer.id] = transaction.occurredAt;
            lastTxMap[customer.id] = transaction;
          }
        }
      }

      final List<DueCustomer> dueList = [];

      for (final customer in customerMap.values) {
        final balance = balanceMap[customer.id] ?? 0;
        final transactions = txMap[customer.id] ?? const [];

        // Condition 1: Must have an outstanding debt (balance > 0)
        if (balance <= 0) continue;

        // Condition 2: Must have a phone number
        if (customer.phone == null || customer.phone!.trim().isEmpty) continue;

        // Compute rating and oldest debt age
        final rating = CustomerRatingUtils.compute(
          transactions: transactions,
          balancePiasters: balance,
          creditLimitPiasters: customer.creditLimitPiasters,
          now: now,
        );

        final debtAge = rating.oldestUnpaidAgeDays ?? 0;

        // Condition 3: oldest debt age >= minDebtAgeDays
        if (debtAge < minDebtAgeDays) continue;

        // Condition 4: lastReminderAt is null or >= reminderIntervalDays ago
        if (customer.lastReminderAt != null) {
          final daysSinceReminder = now.difference(customer.lastReminderAt!).inDays;
          if (daysSinceReminder < reminderIntervalDays) continue;
        }

        // Condition 5: snoozedUntil is null or in the past
        if (customer.snoozedUntil != null && customer.snoozedUntil!.isAfter(now)) {
          continue;
        }

        dueList.add(
          DueCustomer(
            customer: customer,
            balancePiasters: balance,
            oldestUnpaidAgeDays: debtAge,
            lastTransactionAt: lastActivityMap[customer.id],
            lastTransaction: lastTxMap[customer.id],
            rating: rating,
          ),
        );
      }

      // Sort by rating (Late/Red first, then Watch/Yellow, then Good/New)
      // and then by highest balance descending.
      dueList.sort((a, b) {
        final aRank = _badgePriority(a.rating.badge);
        final bRank = _badgePriority(b.rating.badge);
        if (aRank != bRank) {
          return aRank.compareTo(bRank);
        }
        return b.balancePiasters.compareTo(a.balancePiasters);
      });

      return dueList;
    });
  }

  int _badgePriority(RatingBadge badge) {
    switch (badge) {
      case RatingBadge.late:
        return 0; // Highest priority
      case RatingBadge.watch:
        return 1;
      case RatingBadge.newCustomer:
        return 2;
      case RatingBadge.good:
        return 3;
    }
  }

  /// Watches summary totals of due customers (count and total piasters).
  Stream<({int count, int totalPiasters})> watchDueSummary({DateTime? customNow}) {
    return watchDueCustomers(customNow: customNow).map((list) {
      var sum = 0;
      for (final c in list) {
        sum += c.balancePiasters;
      }
      return (count: list.length, totalPiasters: sum);
    });
  }

  /// Snoozes reminder for a customer by a specified duration (e.g. 3 days, 7 days).
  Future<void> snoozeCustomer(
    String customerId,
    Duration duration, {
    DateTime? from,
  }) async {
    final now = from ?? DateTime.now();
    final until = now.add(duration);

    await (_db.update(_db.customers)..where((c) => c.id.equals(customerId))).write(
      CustomersCompanion(
        snoozedUntil: Value(until),
        updatedAt: Value(now),
      ),
    );
  }

  /// Clears snooze timestamp for a customer.
  Future<void> clearSnooze(String customerId) async {
    final now = DateTime.now();
    await (_db.update(_db.customers)..where((c) => c.id.equals(customerId))).write(
      CustomersCompanion(
        snoozedUntil: const Value(null),
        updatedAt: Value(now),
      ),
    );
  }

  /// Records that a collection reminder was sent to the customer right now.
  /// Updates `lastReminderAt = now` and clears any active snooze.
  Future<void> markReminderSent(String customerId, {DateTime? sentAt}) async {
    final now = sentAt ?? DateTime.now();
    await (_db.update(_db.customers)..where((c) => c.id.equals(customerId))).write(
      CustomersCompanion(
        lastReminderAt: Value(now),
        snoozedUntil: const Value(null),
        updatedAt: Value(now),
      ),
    );
  }
}

/// Global provider for CollectionRepository
final collectionRepositoryProvider = Provider<CollectionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  return CollectionRepository(db, settingsRepo);
});
