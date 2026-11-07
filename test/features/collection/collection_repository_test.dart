import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/utils/customer_rating.dart';
import 'package:kashkool/features/collection/data/collection_repository.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';
import 'package:kashkool/features/transactions/data/transaction_repository.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository settingsRepo;
  late CollectionRepository collectionRepo;
  late CustomerRepository customerRepo;
  late TransactionRepository txRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    settingsRepo = SettingsRepository(db);
    collectionRepo = CollectionRepository(db, settingsRepo);
    customerRepo = CustomerRepository(db);
    txRepo = TransactionRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Collection eligibility (due-list logic)', () {
    test('customer with zero or settled balance is NOT due', () async {
      final cId = await customerRepo.addCustomer(name: 'عميل خالص', phone: '01012345678');

      // Debt = 500, Payment = 500
      final now = DateTime(2026, 11, 10);
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: cId,
        type: TransactionType.debt,
        amountPiasters: 50000,
        occurredAt: now.subtract(const Duration(days: 10)),
      );
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: cId,
        type: TransactionType.payment,
        amountPiasters: 50000,
        occurredAt: now.subtract(const Duration(days: 5)),
      );

      final due = await collectionRepo.watchDueCustomers(customNow: now).first;
      expect(due.isEmpty, isTrue);
    });

    test('customer without a phone number is NOT due', () async {
      final cId = await customerRepo.addCustomer(name: 'عميل بدون تليفون');
      final now = DateTime(2026, 11, 10);

      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: cId,
        type: TransactionType.debt,
        amountPiasters: 20000,
        occurredAt: now.subtract(const Duration(days: 10)),
      );

      final due = await collectionRepo.watchDueCustomers(customNow: now).first;
      expect(due.isEmpty, isTrue);
    });

    test('customer whose oldest debt is younger than minDebtAgeDays is NOT due', () async {
      final cId = await customerRepo.addCustomer(name: 'دين جديد', phone: '01011112222');
      final now = DateTime(2026, 11, 10);

      // Debt recorded only 1 day ago (settings minDebtAgeDays = 3)
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: cId,
        type: TransactionType.debt,
        amountPiasters: 30000,
        occurredAt: now.subtract(const Duration(days: 1)),
      );

      final due = await collectionRepo.watchDueCustomers(customNow: now).first;
      expect(due.isEmpty, isTrue);
    });

    test('customer reminded recently (< reminderIntervalDays) is NOT due', () async {
      final cId = await customerRepo.addCustomer(name: 'تم تذكيره قريباً', phone: '01022223333');
      final now = DateTime(2026, 11, 10);

      // Debt recorded 15 days ago
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: cId,
        type: TransactionType.debt,
        amountPiasters: 40000,
        occurredAt: now.subtract(const Duration(days: 15)),
      );

      // Reminded 2 days ago (default interval is 7 days)
      await collectionRepo.markReminderSent(cId, sentAt: now.subtract(const Duration(days: 2)));

      final due = await collectionRepo.watchDueCustomers(customNow: now).first;
      expect(due.isEmpty, isTrue);
    });

    test('customer with active snooze is NOT due', () async {
      final cId = await customerRepo.addCustomer(name: 'عميل مؤجل', phone: '01033334444');
      final now = DateTime(2026, 11, 10);

      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: cId,
        type: TransactionType.debt,
        amountPiasters: 80000,
        occurredAt: now.subtract(const Duration(days: 20)),
      );

      // Snooze for 3 days from `now`
      await collectionRepo.snoozeCustomer(cId, const Duration(days: 3), from: now);

      final due = await collectionRepo.watchDueCustomers(customNow: now).first;
      expect(due.isEmpty, isTrue);
    });

    test('customer meeting ALL conditions IS due and summary calculates totals', () async {
      final now = DateTime(2026, 11, 10);

      // Customer 1: due (debt 500 EGP, 10 days old)
      final c1 = await customerRepo.addCustomer(name: 'عميل 1', phone: '01012345678');
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: c1,
        type: TransactionType.debt,
        amountPiasters: 50000,
        occurredAt: now.subtract(const Duration(days: 10)),
      );

      // Customer 2: due (3 debts, oldest is 50 days old -> Late badge, total 1,000 EGP)
      final c2 = await customerRepo.addCustomer(name: 'عميل 2', phone: '01123456789');
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: c2,
        type: TransactionType.debt,
        amountPiasters: 50000,
        occurredAt: now.subtract(const Duration(days: 50)),
      );
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: c2,
        type: TransactionType.debt,
        amountPiasters: 30000,
        occurredAt: now.subtract(const Duration(days: 20)),
      );
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: c2,
        type: TransactionType.debt,
        amountPiasters: 20000,
        occurredAt: now.subtract(const Duration(days: 10)),
      );

      final dueList = await collectionRepo.watchDueCustomers(customNow: now).first;
      expect(dueList.length, equals(2));

      // Priority sort check: Customer 2 has Late rating, so comes first
      expect(dueList[0].customer.id, equals(c2));
      expect(dueList[0].rating.badge, equals(RatingBadge.late));
      expect(dueList[1].customer.id, equals(c1));

      // Summary totals check
      final summary = await collectionRepo.watchDueSummary(customNow: now).first;
      expect(summary.count, equals(2));
      expect(summary.totalPiasters, equals(150000)); // 1,500 EGP
    });

    test('marking reminder sent updates lastReminderAt and removes customer from due list', () async {
      final now = DateTime(2026, 11, 10);
      final cId = await customerRepo.addCustomer(name: 'عميل للاختبار', phone: '01211112222');

      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: cId,
        type: TransactionType.debt,
        amountPiasters: 75000,
        occurredAt: now.subtract(const Duration(days: 12)),
      );

      var due = await collectionRepo.watchDueCustomers(customNow: now).first;
      expect(due.length, equals(1));

      // Mark reminder sent at `now`
      await collectionRepo.markReminderSent(cId, sentAt: now);

      due = await collectionRepo.watchDueCustomers(customNow: now).first;
      expect(due.isEmpty, isTrue);

      // Verify DB record
      final customer = await customerRepo.getCustomerWithBalance(cId);
      expect(customer!.customer.lastReminderAt, equals(now));
    });
  });
}
