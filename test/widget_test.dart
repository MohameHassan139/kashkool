import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/main.dart';

void main() {
  testWidgets('App renders Arabic navigation bar and launches without error', (WidgetTester tester) async {
    final testDb = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(testDb),
        ],
        child: const KashkoolApp(),
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
