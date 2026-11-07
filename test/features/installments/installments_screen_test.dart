import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/theme/app_theme.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/installments/data/installment_repository.dart';
import 'package:kashkool/features/installments/presentation/add_installment_plan_screen.dart';
import 'package:kashkool/features/installments/presentation/installments_screen.dart';
import 'package:kashkool/l10n/app_localizations.dart';

void main() {
  testWidgets('InstallmentsScreen renders empty state when no plans exist', (tester) async {
    tester.view.physicalSize = const Size(412 * 2.5, 915 * 2.5);
    tester.view.devicePixelRatio = 2.5;

    final db = AppDatabase(NativeDatabase.memory());
    final installmentRepo = InstallmentRepository(db);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          installmentRepositoryProvider.overrideWithValue(installmentRepo),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: InstallmentsScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('نظام الأقساط 📋'), findsOneWidget);
    expect(find.text('مفيش خطط أقساط حالياً'), findsOneWidget);
    expect(find.text('خطة قسط جديدة'), findsOneWidget);

    await db.close();
  });

  testWidgets('InstallmentsScreen renders active plans and opens details', (tester) async {
    tester.view.physicalSize = const Size(412 * 2.5, 915 * 2.5);
    tester.view.devicePixelRatio = 2.5;

    final db = AppDatabase(NativeDatabase.memory());
    final customerRepo = CustomerRepository(db);
    final installmentRepo = InstallmentRepository(db);

    final customerId = await customerRepo.addCustomer(name: 'محمود عبد الفتاح', phone: '01011122233');

    await installmentRepo.createPlan(
      customerId: customerId,
      itemDescription: 'شاشة سامسونج 55 بوصة',
      totalPricePiasters: 1200000,
      downPaymentPiasters: 200000,
      installmentCount: 10,
      startDate: DateTime(2026, 6, 1),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          installmentRepositoryProvider.overrideWithValue(installmentRepo),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: InstallmentsScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('شاشة سامسونج 55 بوصة'), findsOneWidget);
    expect(find.text('محمود عبد الفتاح'), findsOneWidget);

    // Tap on card to navigate to details
    await tester.tap(find.text('شاشة سامسونج 55 بوصة'));
    await tester.pumpAndSettle();

    // Verify details screen
    expect(find.text('جدول الأقساط (10)'), findsOneWidget);
    expect(find.text('القسط رقم 1 • 2026/06/01'), findsOneWidget);

    await db.close();
  });

  testWidgets('AddInstallmentPlanScreen renders and shows schedule live preview', (tester) async {
    tester.view.physicalSize = const Size(412 * 2.5, 915 * 2.5);
    tester.view.devicePixelRatio = 2.5;

    final db = AppDatabase(NativeDatabase.memory());
    final customerRepo = CustomerRepository(db);
    final installmentRepo = InstallmentRepository(db);

    final customerId = await customerRepo.addCustomer(name: 'إبراهيم حسن', phone: '01234567890');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          installmentRepositoryProvider.overrideWithValue(installmentRepo),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: AddInstallmentPlanScreen(initialCustomerId: customerId),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('خطة قسط جديدة'), findsOneWidget);
    expect(find.text('بيانات السلعة والمبالغ'), findsOneWidget);

    // Enter total price
    await tester.enterText(find.byType(TextFormField).at(1), '6000'); // total price
    await tester.pumpAndSettle();

    // Verify live preview of remaining and schedule
    expect(find.text('المبلغ المتبقي للتقسيط:'), findsOneWidget);

    await db.close();
  });
}
