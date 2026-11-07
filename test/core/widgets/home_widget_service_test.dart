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
    });
  });
}
