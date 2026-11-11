import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/main.dart';

void main() {
  testWidgets('Fresh app launches directly into onboarding wizard', (WidgetTester tester) async {
    final testDb = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(testDb),
        ],
        child: const KashkoolApp(initialLanguageCode: 'ar_EG'),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Onboarding Wizard is displayed
    expect(find.text('تهيئة كشكول لأول مرة'), findsOneWidget);
    expect(find.text('أهلاً بك في كشكول! 👋'), findsOneWidget);
    await tester.tap(find.text('المتابعة كضيف (بدون حساب)'));
    await tester.pumpAndSettle();
    expect(find.text('متابعة نوع النشاط'), findsOneWidget);

    await testDb.close();
  });

  testWidgets('App renders Arabic navigation bar when onboarding is completed', (WidgetTester tester) async {
    final testDb = AppDatabase(NativeDatabase.memory());
    final now = DateTime.now();

    await testDb.into(testDb.appSettings).insert(
      AppSettingsCompanion(
        id: const Value('setting-onboarding_completed'),
        key: const Value('onboarding_completed'),
        value: const Value('true'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(testDb),
        ],
        child: const KashkoolApp(initialLanguageCode: 'ar_EG'),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Arabic navigation items are present
    expect(find.text('العملاء'), findsWidgets);
    expect(find.text('التحصيل'), findsOneWidget);
    expect(find.text('الموردين'), findsOneWidget);
    expect(find.text('الدرج'), findsOneWidget);
    expect(find.text('الإعدادات'), findsOneWidget);

    // Tap on Collection tab
    await tester.tap(find.text('التحصيل'));
    await tester.pumpAndSettle();

    // Verify Collection empty state is rendered
    expect(find.text('مفيش تحصيلات مستحقة النهاردة 🎉'), findsOneWidget);

    await testDb.close();
  });
}
