import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/widgets/home_widget_service.dart';
import 'package:kashkool/core/widgets/home_widget_sync_coordinator.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';
import 'package:kashkool/features/transactions/data/transaction_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late ProviderContainer container;
  final Map<String, dynamic> savedData = {};

  setUp(() {
    savedData.clear();
    db = AppDatabase(NativeDatabase.memory());

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('home_widget'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'saveWidgetData') {
          final id = methodCall.arguments['id'] as String;
          final data = methodCall.arguments['data'];
          savedData[id] = data;
          return true;
        } else if (methodCall.method == 'updateWidget') {
          return true;
        }
        return null;
      },
    );

    container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await Future.delayed(const Duration(milliseconds: 50));
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('home_widget'), null);
    await db.close();
  });

  group('HomeWidgetSyncCoordinator & Privacy Mode', () {
    test('SettingsRepository privacy mode toggles and streams reactively', () async {
      final settingsRepo = container.read(settingsRepositoryProvider);

      expect(await settingsRepo.getPrivacyMode(), isFalse);

      await settingsRepo.setPrivacyMode(true);
      expect(await settingsRepo.getPrivacyMode(), isTrue);

      await settingsRepo.setPrivacyMode(false);
      expect(await settingsRepo.getPrivacyMode(), isFalse);
    });

    test('manual sync updates widget with current receivables and transactions', () async {
      final customerRepo = container.read(customerRepositoryProvider);
      final txRepo = TransactionRepository(db);
      final coordinator = container.read(homeWidgetSyncCoordinatorProvider);

      // Add a customer with debt
      final customerId = await customerRepo.addCustomer(name: 'محمود الصعيدي');
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 80000, // 800 EGP
      );

      // Trigger sync
      await coordinator.syncNow();

      expect(savedData[HomeWidgetService.keyTotalReceivables], equals('800 جنيه'));
    });

    test('sync hides amounts when privacy mode is enabled', () async {
      final customerRepo = container.read(customerRepositoryProvider);
      final txRepo = TransactionRepository(db);
      final settingsRepo = container.read(settingsRepositoryProvider);
      final coordinator = container.read(homeWidgetSyncCoordinatorProvider);

      await settingsRepo.setPrivacyMode(true);

      final customerId = await customerRepo.addCustomer(name: 'سيد');
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 25000,
      );

      await coordinator.syncNow();

      expect(savedData[HomeWidgetService.keyTotalReceivables], equals('••••••'));
      expect(savedData[HomeWidgetService.keyCollectedToday], equals('••••••'));
    });
  });
}
