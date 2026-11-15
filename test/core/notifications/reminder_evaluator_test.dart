import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/notifications/reminder_evaluator.dart';
import 'package:kashkool/core/notifications/reminder_notifier.dart';
import 'package:kashkool/features/collection/data/collection_repository.dart';
import 'package:kashkool/features/installments/data/installment_repository.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';

/// Records what the reminder logic asked the OS to do, without touching
/// platform channels.
class _RecordingNotifier implements ReminderNotifier {
  bool permissionGranted = true;

  int collectionNotifications = 0;
  int installmentNotifications = 0;
  int backupNotifications = 0;
  int lowStockNotifications = 0;
  int multipleLowStockNotifications = 0;

  int? scheduledHour;
  int? scheduledMinute;
  int scheduleCalls = 0;
  int cancelCalls = 0;

  @override
  Future<bool> hasPermission() async => permissionGranted;

  @override
  Future<void> showCollectionNotification({
    required int dueCount,
    required int totalPiasters,
  }) async {
    collectionNotifications++;
  }

  @override
  Future<void> showDueInstallmentsNotification({
    required int count,
    required int totalPiasters,
  }) async {
    installmentNotifications++;
  }

  @override
  Future<void> showBackupReminderNotification({required int daysSinceBackup}) async {
    backupNotifications++;
  }

  @override
  Future<void> showLowStockNotification({
    required String productName,
    required String remainingStock,
    String? supplierName,
    String? supplierPhone,
  }) async {
    lowStockNotifications++;
  }

  @override
  Future<void> showMultipleLowStockNotification({required int count}) async {
    multipleLowStockNotifications++;
  }

  @override
  Future<void> scheduleDailyReminder({required int hour, required int minute}) async {
    scheduleCalls++;
    scheduledHour = hour;
    scheduledMinute = minute;
  }

  @override
  Future<void> cancelDailyReminder() async {
    cancelCalls++;
    scheduledHour = null;
    scheduledMinute = null;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late SettingsRepository settings;
  late CollectionRepository collection;
  late InstallmentRepository installments;
  late _RecordingNotifier notifier;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    settings = SettingsRepository(db);
    collection = CollectionRepository(db, settings);
    installments = InstallmentRepository(db);
    notifier = _RecordingNotifier();
  });

  tearDown(() async {
    await db.close();
  });

  ReminderEvaluator evaluatorAt(DateTime now) => ReminderEvaluator(
        db: db,
        settings: settings,
        collection: collection,
        installments: installments,
        notifier: notifier,
        clock: () => now,
      );

  /// Inserts a customer with an unpaid debt old enough to be collected, so the
  /// collection reminder has something to report.
  Future<void> seedCustomerWithDebt({DateTime? relativeTo}) async {
    final now = relativeTo ?? DateTime.now();
    final debtAt = DateTime(now.year, now.month, now.day, 9)
        .subtract(const Duration(days: 5));
    await db.into(db.customers).insert(
          CustomersCompanion(
            id: const Value('customer-1'),
            shopId: const Value('shop-1'),
            name: const Value('أحمد'),
            phone: const Value('01000000000'),
            createdBy: const Value('owner'),
            deviceId: const Value('device-1'),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
    await db.into(db.transactions).insert(
          TransactionsCompanion(
            id: const Value('tx-1'),
            shopId: const Value('shop-1'),
            partyType: const Value(PartyType.customer),
            partyId: const Value('customer-1'),
            type: const Value(TransactionType.debt),
            amountPiasters: const Value(5000),
            occurredAt: Value(debtAt),
            createdBy: const Value('owner'),
            deviceId: const Value('device-1'),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
  }

  group('ReminderEvaluator', () {
    test('does nothing and cancels the alarm when notifications are off', () async {
      await seedCustomerWithDebt();
      await settings.setNotificationsEnabled(false);

      final result = await evaluatorAt(DateTime.now()).run();

      expect(result.notificationsEnabled, isFalse);
      expect(result.showedAny, isFalse);
      expect(notifier.collectionNotifications, 0);
      expect(notifier.scheduleCalls, 0);
      expect(notifier.cancelCalls, 1);
      expect(await settings.getLastCollectionReminderDate(), isNull);
    });

    test('does nothing when the OS permission is missing', () async {
      await seedCustomerWithDebt();
      notifier.permissionGranted = false;

      final result = await evaluatorAt(DateTime.now()).run();

      expect(result.notificationsEnabled, isFalse);
      expect(notifier.collectionNotifications, 0);
      expect(notifier.cancelCalls, 1);
    });

    test('waits for the reminder time before showing anything', () async {
      await seedCustomerWithDebt(relativeTo: DateTime(2026, 11, 15, 9));
      await settings.setReminderTimeHour(20);
      await settings.setReminderTimeMinute(0);

      final result = await evaluatorAt(DateTime(2026, 11, 15, 9, 0)).run();

      expect(result.dueCustomerCount, 1);
      expect(notifier.collectionNotifications, 0);
      // The alarm is still scheduled so the reminder can fire later today.
      expect(notifier.scheduledHour, 20);
      expect(notifier.scheduledMinute, 0);
    });

    test('shows the collection reminder once per day after the reminder time', () async {
      await seedCustomerWithDebt(relativeTo: DateTime(2026, 11, 15, 10));
      await settings.setReminderTimeHour(10);
      await settings.setReminderTimeMinute(0);

      final first = await evaluatorAt(DateTime(2026, 11, 15, 10, 5)).run();
      expect(first.dueCustomerCount, 1);
      expect(first.showedAny, isTrue);
      expect(notifier.collectionNotifications, 1);
      expect(await settings.getLastCollectionReminderDate(), '2026-11-15');
      expect(notifier.scheduledHour, 10);

      // Same day, later check: no second notification.
      final second = await evaluatorAt(DateTime(2026, 11, 15, 18, 0)).run();
      expect(notifier.collectionNotifications, 1);
      expect(second.notificationsEnabled, isTrue);

      // Next day: allowed again.
      final third = await evaluatorAt(DateTime(2026, 11, 16, 10, 1)).run();
      expect(third.showedAny, isTrue);
      expect(notifier.collectionNotifications, 2);
    });

    test('cancels the OS alarm when nothing is due', () async {
      await settings.setReminderTimeHour(10);

      final result = await evaluatorAt(DateTime(2026, 11, 15, 11, 0)).run();

      expect(result.dueCustomerCount, 0);
      expect(notifier.collectionNotifications, 0);
      expect(notifier.scheduleCalls, 0);
      expect(notifier.cancelCalls, 1);
    });

    test('keeps evaluating when the database throws', () async {
      await db.close();

      final result = await evaluatorAt(DateTime.now()).run();

      // Never throws: the daily alarm refresh must still be attempted.
      expect(result.showedAny, isFalse);
    });
  });
}
