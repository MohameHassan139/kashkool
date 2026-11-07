import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = SettingsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SettingsRepository default credit limit', () {
    test('persists and retrieves default credit limit in piasters', () async {
      expect(await repo.getDefaultCreditLimitPiasters(), isNull);

      await repo.setDefaultCreditLimitPiasters(50000); // 500 EGP
      expect(await repo.getDefaultCreditLimitPiasters(), equals(50000));

      // Updates default credit limit
      await repo.setDefaultCreditLimitPiasters(100000); // 1,000 EGP
      expect(await repo.getDefaultCreditLimitPiasters(), equals(100000));

      // Clears default credit limit
      await repo.setDefaultCreditLimitPiasters(null);
      expect(await repo.getDefaultCreditLimitPiasters(), isNull);
    });

    test('watches default credit limit changes reactively', () async {
      final stream = repo.watchDefaultCreditLimitPiasters();

      expect(await stream.first, isNull);

      await repo.setDefaultCreditLimitPiasters(75000);
      expect(await stream.first, equals(75000));
    });
  });

  group('SettingsRepository Shop Profile Details', () {
    test('persists and updates shop name, phone, address, and payment info', () async {
      expect(await repo.getShopName(), equals('كشكول'));
      expect(await repo.getShopPhone(), isEmpty);
      expect(await repo.getShopAddress(), isEmpty);
      expect(await repo.getShopInstaPay(), isEmpty);
      expect(await repo.getShopWallet(), isEmpty);
      expect(await repo.getShopLogoPath(), isNull);

      await repo.setShopName('بقالة الأمانة');
      await repo.setShopPhone('01012345678');
      await repo.setShopAddress('شارع السوق');
      await repo.setShopInstaPay('amna@instapay');
      await repo.setShopWallet('01012345678');
      await repo.setShopLogoPath('/data/user/0/logo.png');

      expect(await repo.getShopName(), equals('بقالة الأمانة'));
      expect(await repo.getShopPhone(), equals('01012345678'));
      expect(await repo.getShopAddress(), equals('شارع السوق'));
      expect(await repo.getShopInstaPay(), equals('amna@instapay'));
      expect(await repo.getShopWallet(), equals('01012345678'));
      expect(await repo.getShopLogoPath(), equals('/data/user/0/logo.png'));
    });
  });

  group('SettingsRepository Security & PIN Settings', () {
    test('manages PIN hash, salt, and removal', () async {
      expect(await repo.hasPin(), isFalse);
      expect(await repo.getPinHash(), isNull);
      expect(await repo.getPinSalt(), isNull);

      await repo.setPin(hash: 'dummyhash123', salt: 'dummysalt456');
      expect(await repo.hasPin(), isTrue);
      expect(await repo.getPinHash(), equals('dummyhash123'));
      expect(await repo.getPinSalt(), equals('dummysalt456'));

      await repo.setBiometricEnabled(true);
      expect(await repo.isBiometricEnabled(), isTrue);

      // Remove PIN should clear hash, salt, and disable biometric
      await repo.removePin();
      expect(await repo.hasPin(), isFalse);
      expect(await repo.getPinHash(), isNull);
      expect(await repo.getPinSalt(), isNull);
      expect(await repo.isBiometricEnabled(), isFalse);
    });

    test('manages lock timeout', () async {
      expect(await repo.getLockTimeoutMinutes(), equals(0));

      await repo.setLockTimeoutMinutes(5);
      expect(await repo.getLockTimeoutMinutes(), equals(5));
    });
  });

  group('SettingsRepository Backup Timestamps & Due Check', () {
    test('tracks last backup date and detects backup due when >= 7 days', () async {
      expect(await repo.getLastBackupAt(), isNull);
      expect(await repo.getDaysSinceLastBackup(), isNull);
      expect(await repo.isBackupDue(), isTrue);

      final now = DateTime.now();
      await repo.setLastBackupAt(now);
      expect(await repo.getLastBackupAt(), isNotNull);
      expect(await repo.getDaysSinceLastBackup(), equals(0));
      expect(await repo.isBackupDue(), isFalse);

      // 8 days ago
      final eightDaysAgo = now.subtract(const Duration(days: 8));
      await repo.setLastBackupAt(eightDaysAgo);
      expect(await repo.isBackupDue(), isTrue);
      expect(await repo.getDaysSinceLastBackup(), greaterThanOrEqualTo(8));
    });
  });

  group('SettingsRepository Theme Mode', () {
    test('persists and watches theme mode', () async {
      expect(await repo.getThemeMode(), equals(ThemeMode.system));

      await repo.setThemeMode(ThemeMode.dark);
      expect(await repo.getThemeMode(), equals(ThemeMode.dark));

      await repo.setThemeMode(ThemeMode.light);
      expect(await repo.getThemeMode(), equals(ThemeMode.light));
    });
  });
}
