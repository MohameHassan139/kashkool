import 'package:drift/native.dart';
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
}
