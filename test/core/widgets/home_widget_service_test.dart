import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/widgets/home_widget_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HomeWidgetService service;
  final List<MethodCall> channelCalls = [];
  final Map<String, dynamic> savedData = {};

  setUp(() {
    service = HomeWidgetService();
    channelCalls.clear();
    savedData.clear();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('home_widget'),
      (MethodCall methodCall) async {
        channelCalls.add(methodCall);
        if (methodCall.method == 'saveWidgetData') {
          final id = methodCall.arguments['id'] as String;
          final data = methodCall.arguments['data'];
          savedData[id] = data;
          return true;
        } else if (methodCall.method == 'getWidgetData') {
          final id = methodCall.arguments['id'] as String;
          return savedData[id] ?? methodCall.arguments['defaultValue'];
        } else if (methodCall.method == 'updateWidget') {
          return true;
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('home_widget'), null);
  });

  group('HomeWidgetService', () {
    test('updates widget with formatted financial values in normal mode', () async {
      await service.updateWidgetData(
        totalReceivablesPiasters: 150000, // 1,500 EGP
        collectedTodayPiasters: 35000, // 350 EGP
        dueCount: 4,
        privacyMode: false,
      );

      expect(savedData[HomeWidgetService.keyTotalReceivables], equals('1,500 جنيه'));
      expect(savedData[HomeWidgetService.keyCollectedToday], equals('350 جنيه'));
      expect(savedData[HomeWidgetService.keyDueCount], equals('4 عملاء'));

      final updateCalls = channelCalls.where((c) => c.method == 'updateWidget').toList();
      expect(updateCalls.length, equals(2)); // small and medium widgets
    });

    test('respects privacy mode by masking amounts with bullet dots', () async {
      await service.updateWidgetData(
        totalReceivablesPiasters: 500000, // 5,000 EGP
        collectedTodayPiasters: 120000, // 1,200 EGP
        dueCount: 7,
        privacyMode: true,
      );

      expect(savedData[HomeWidgetService.keyTotalReceivables], equals('••••••'));
      expect(savedData[HomeWidgetService.keyCollectedToday], equals('••••••'));
      expect(savedData[HomeWidgetService.keyDueCount], equals('7 عملاء'));
      expect(savedData[HomeWidgetService.keyPrivacyMode], equals('true'));
    });

    test('saves last-update date and time for the native widget', () async {
      await service.updateWidgetData(
        totalReceivablesPiasters: 0,
        collectedTodayPiasters: 0,
        dueCount: 0,
        now: DateTime(2026, 3, 5, 9, 7),
      );

      expect(savedData[HomeWidgetService.keyUpdatedDate], equals('2026-03-05'));
      expect(savedData[HomeWidgetService.keyUpdatedTime], equals('09:07'));
      expect(savedData[HomeWidgetService.keyPrivacyMode], equals('false'));
      expect(savedData[HomeWidgetService.keyDueCount], equals('مفيش'));
    });

    test('saves the on/off flag so the native widget can show "متوقفة"', () async {
      await service.updateWidgetData(
        totalReceivablesPiasters: 1000,
        collectedTodayPiasters: 0,
        dueCount: 1,
        enabled: false,
      );
      expect(savedData[HomeWidgetService.keyWidgetEnabled], equals('false'));

      await service.updateWidgetData(
        totalReceivablesPiasters: 1000,
        collectedTodayPiasters: 0,
        dueCount: 1,
      );
      expect(savedData[HomeWidgetService.keyWidgetEnabled], equals('true'));
    });
  });

  group('formatCustomerCount', () {
    test('uses correct Egyptian Arabic grammar', () {
      expect(HomeWidgetService.formatCustomerCount(0), 'مفيش');
      expect(HomeWidgetService.formatCustomerCount(1), 'عميل واحد');
      expect(HomeWidgetService.formatCustomerCount(2), 'عميلين');
      expect(HomeWidgetService.formatCustomerCount(3), '3 عملاء');
      expect(HomeWidgetService.formatCustomerCount(10), '10 عملاء');
      expect(HomeWidgetService.formatCustomerCount(11), '11 عميل');
      expect(HomeWidgetService.formatCustomerCount(150), '150 عميل');
    });
  });
}
