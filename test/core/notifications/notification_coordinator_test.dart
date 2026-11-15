import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/notifications/notification_coordinator.dart';
import 'package:kashkool/features/collection/data/collection_repository.dart';
import 'package:kashkool/features/installments/data/installment_repository.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late SettingsRepository settingsRepo;
  late ProviderContainer container;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    settingsRepo = SettingsRepository(db);

    container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        settingsRepositoryProvider.overrideWithValue(settingsRepo),
        collectionRepositoryProvider.overrideWithValue(CollectionRepository(db, settingsRepo)),
        installmentRepositoryProvider.overrideWithValue(InstallmentRepository(db)),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  group('Notifications & Reminders System', () {
    test('SettingsRepository defaults for notifications are correct', () async {
      final hour = await settingsRepo.getReminderTimeHour();
      final minute = await settingsRepo.getReminderTimeMinute();
      final enabled = await settingsRepo.getNotificationsEnabled();
      final lastCollection = await settingsRepo.getLastCollectionReminderDate();
      final lastInstallment = await settingsRepo.getLastInstallmentReminderDate();
      final lastBackup = await settingsRepo.getLastBackupReminderDate();
      final lastLowStock = await settingsRepo.getLastLowStockReminderDate();

      expect(hour, equals(10));
      expect(minute, equals(0));
      expect(enabled, isTrue);
      expect(lastCollection, isNull);
      expect(lastInstallment, isNull);
      expect(lastBackup, isNull);
      expect(lastLowStock, isNull);
    });

    test('SettingsRepository saves and watches notification settings', () async {
      await settingsRepo.setReminderTimeHour(20);
      await settingsRepo.setReminderTimeMinute(30);
      await settingsRepo.setNotificationsEnabled(false);
      await settingsRepo.setLastCollectionReminderDate('2026-11-14');
      await settingsRepo.setLastInstallmentReminderDate('2026-11-14');
      await settingsRepo.setLastBackupReminderDate('2026-11-14');
      await settingsRepo.setLastLowStockReminderDate('2026-11-14');

      expect(await settingsRepo.getReminderTimeHour(), equals(20));
      expect(await settingsRepo.getReminderTimeMinute(), equals(30));
      expect(await settingsRepo.getNotificationsEnabled(), isFalse);
      expect(await settingsRepo.getLastCollectionReminderDate(), equals('2026-11-14'));
      expect(await settingsRepo.getLastInstallmentReminderDate(), equals('2026-11-14'));
      expect(await settingsRepo.getLastBackupReminderDate(), equals('2026-11-14'));
      expect(await settingsRepo.getLastLowStockReminderDate(), equals('2026-11-14'));
    });

    test('NotificationCoordinator instantiates and starts cleanly via ProviderContainer', () {
      final coordinator = container.read(notificationCoordinatorProvider);
      expect(coordinator, isNotNull);
    });

    test('NotificationCoordinator skips triggering when notifications are disabled', () async {
      await settingsRepo.setNotificationsEnabled(false);
      final coordinator = container.read(notificationCoordinatorProvider);

      await coordinator.checkAndTriggerReminders();

      // Ensure no reminder date was set since it was disabled
      expect(await settingsRepo.getLastCollectionReminderDate(), isNull);
      expect(await settingsRepo.getLastInstallmentReminderDate(), isNull);
      expect(await settingsRepo.getLastBackupReminderDate(), isNull);
    });
  });
}
