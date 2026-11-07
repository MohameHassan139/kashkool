import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/onboarding/data/shop_repository.dart';
import 'package:kashkool/main.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('Onboarding wizard completes 4 steps, saves shop and marks completion', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
        ],
        child: const KashkoolApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Step 1: Shop Identity
    expect(find.text('تهيئة كشكول لأول مرة'), findsOneWidget);
    expect(find.text('أهلاً بك في كشكول! 👋'), findsOneWidget);

    // Try submitting with empty name
    await tester.tap(find.text('متابعة نوع النشاط'));
    await tester.pumpAndSettle();
    expect(find.text('يرجى كتابة اسم المحل (حرفين على الأقل)'), findsOneWidget);

    // Enter valid shop name
    final nameField = find.byType(TextFormField).first;
    await tester.enterText(nameField, 'محل الهدى للموبايل');
    await tester.pumpAndSettle();

    // Advance to Step 2
    await tester.tap(find.text('متابعة نوع النشاط'));
    await tester.pumpAndSettle();

    // 2. Step 2: Trade Type
    expect(find.text('ما هو نوع نشاطك التجاري؟'), findsOneWidget);
    expect(find.text('موبايلات وإكسسوارات'), findsOneWidget);

    // Select mobile
    await tester.tap(find.text('موبايلات وإكسسوارات'));
    await tester.pumpAndSettle();

    // Advance to Step 3
    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();

    // 3. Step 3: Notifications & Battery Guide
    expect(find.text('ضمان وصول الإشعارات والتذكيرات 🔔'), findsOneWidget);
    expect(find.textContaining('حماية التطبيق'), findsWidgets);

    // Advance to Step 4
    await tester.tap(find.text('متابعة'));
    await tester.pumpAndSettle();

    // 4. Step 4: First Action
    expect(find.text('جاهز للانطلاق! 🚀'), findsOneWidget);
    expect(find.text('تخطي والذهاب إلى الشاشة الرئيسية'), findsOneWidget);

    // Tap skip to finish onboarding
    await tester.tap(find.text('تخطي والذهاب إلى الشاشة الرئيسية'));
    await tester.pumpAndSettle();

    // Verify database has shop with mobile trade and installments enabled
    final shopRepo = ShopRepository(db);
    final isComplete = await shopRepo.isOnboardingCompleted();
    expect(isComplete, isTrue);

    final shop = await shopRepo.getActiveShop();
    expect(shop, isNotNull);
    expect(shop!.name, equals('محل الهدى للموبايل'));
    expect(shop.shopType, equals('mobile'));
    expect(shop.enableInstallments, isTrue);

    // Verify we landed on main navigation
    expect(find.text('العملاء'), findsWidgets);

    // Clean up widget tree and pending stream cancel timers
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 100));
  });
}
