import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';
import 'package:kashkool/features/settings/domain/app_features.dart';

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

  group('App Features Defaults & Toggles', () {
    test('returns default enabled values before any change', () async {
      expect(await repo.isFeatureEnabled(AppFeature.quickPos), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.suppliers), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.inventory), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.cashDrawer), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.profitLoss), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.offers), isFalse);
      expect(await repo.isFeatureEnabled(AppFeature.installments), isFalse);
    });

    test('can toggle individual features on and off', () async {
      // Toggle Quick POS off
      await repo.setFeatureEnabled(AppFeature.quickPos, false);
      expect(await repo.isFeatureEnabled(AppFeature.quickPos), isFalse);

      // Toggle Suppliers off
      await repo.setFeatureEnabled(AppFeature.suppliers, false);
      expect(await repo.isFeatureEnabled(AppFeature.suppliers), isFalse);

      // Toggle Installments on
      await repo.setFeatureEnabled(AppFeature.installments, true);
      expect(await repo.isFeatureEnabled(AppFeature.installments), isTrue);

      // Toggle Quick POS back on
      await repo.setFeatureEnabled(AppFeature.quickPos, true);
      expect(await repo.isFeatureEnabled(AppFeature.quickPos), isTrue);
    });

    test('watchFeatureEnabled streams reactive updates', () async {
      final stream = repo.watchFeatureEnabled(AppFeature.quickPos);
      expect(await stream.first, isTrue);

      await repo.setFeatureEnabled(AppFeature.quickPos, false);
      expect(await repo.watchFeatureEnabled(AppFeature.quickPos).first, isFalse);
    });

    test('watchEnabledFeatures streams full active set', () async {
      final initialSet = await repo.watchEnabledFeatures().first;
      expect(initialSet.contains(AppFeature.quickPos), isTrue);
      expect(initialSet.contains(AppFeature.suppliers), isTrue);
      expect(initialSet.contains(AppFeature.installments), isFalse);

      // Disable quickPos and enable installments
      await repo.setFeatureEnabled(AppFeature.quickPos, false);
      await repo.setFeatureEnabled(AppFeature.installments, true);

      final updatedSet = await repo.watchEnabledFeatures().first;
      expect(updatedSet.contains(AppFeature.quickPos), isFalse);
      expect(updatedSet.contains(AppFeature.installments), isTrue);
    });
  });

  group('App Feature Presets', () {
    test('applies Simple Ledger preset (دفتر ديون فقط)', () async {
      await repo.applyFeaturePreset(FeaturePreset.simpleLedger);

      for (final feature in AppFeature.values) {
        final isEnabled = await repo.isFeatureEnabled(feature);
        expect(isEnabled, isFalse, reason: '${feature.name} should be disabled in simpleLedger');
      }
    });

    test('applies Grocery preset (بقالة وسوبرماركت)', () async {
      await repo.applyFeaturePreset(FeaturePreset.grocery);

      expect(await repo.isFeatureEnabled(AppFeature.quickPos), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.suppliers), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.inventory), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.cashDrawer), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.profitLoss), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.installments), isFalse);
      expect(await repo.isFeatureEnabled(AppFeature.offers), isFalse);
    });

    test('applies Electronics / Mobile preset (موبايلات وأجهزة)', () async {
      await repo.applyFeaturePreset(FeaturePreset.electronics);

      expect(await repo.isFeatureEnabled(AppFeature.quickPos), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.suppliers), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.inventory), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.cashDrawer), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.profitLoss), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.installments), isTrue);
      expect(await repo.isFeatureEnabled(AppFeature.offers), isFalse);
    });

    test('applies All Features preset (جميع الميزات)', () async {
      // First turn everything off
      await repo.applyFeaturePreset(FeaturePreset.simpleLedger);

      // Then apply allFeatures
      await repo.applyFeaturePreset(FeaturePreset.allFeatures);

      for (final feature in AppFeature.values) {
        final isEnabled = await repo.isFeatureEnabled(feature);
        expect(isEnabled, isTrue, reason: '${feature.name} should be enabled in allFeatures');
      }
    });
  });
}
