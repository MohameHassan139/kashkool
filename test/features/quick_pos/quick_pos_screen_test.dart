import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/theme/app_theme.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/inventory/data/inventory_repository.dart';
import 'package:kashkool/features/quick_pos/presentation/quick_pos_screen.dart';
import 'package:kashkool/l10n/app_localizations.dart';

void main() {
  testWidgets('QuickPosScreen renders product list and adds items to cart', (tester) async {
    tester.view.physicalSize = const Size(412 * 2.5, 915 * 2.5);
    tester.view.devicePixelRatio = 2.5;

    final db = AppDatabase(NativeDatabase.memory());
    final inventoryRepo = InventoryRepository(db);

    await inventoryRepo.addProduct(
      name: 'جبنة فيتا',
      unitLabel: 'علبة',
      purchasePricePiasters: 2000,
      salePricePiasters: 2500, // 25 EGP
      minimumStockMilliUnits: 1000,
      startingStockMilliUnits: 10000, // 10 units
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          inventoryRepositoryProvider.overrideWithValue(inventoryRepo),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: QuickPosScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify Title & Product name
    expect(find.text('بيع سريع'), findsOneWidget);
    expect(find.text('جبنة فيتا'), findsOneWidget);

    // Tap product to add to cart
    await tester.tap(find.text('جبنة فيتا'));
    await tester.pumpAndSettle();

    // Cart should now contain 1 item with stepper
    expect(find.text('أصناف البيع'), findsOneWidget);
    expect(find.byIcon(Icons.remove_rounded), findsOneWidget);
    expect(find.byIcon(Icons.add_rounded), findsOneWidget);

    // Tap '+' to increment to 2
    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();

    expect(find.text('2'), findsWidgets);

    // Tap '-' to decrement to 1
    await tester.tap(find.byIcon(Icons.remove_rounded));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsWidgets);

    await db.close();
  });

  testWidgets('QuickPosScreen supports cash checkout flow', (tester) async {
    tester.view.physicalSize = const Size(412 * 2.5, 915 * 2.5);
    tester.view.devicePixelRatio = 2.5;

    final db = AppDatabase(NativeDatabase.memory());
    final inventoryRepo = InventoryRepository(db);

    await inventoryRepo.addProduct(
      name: 'شيبسي عائلي',
      unitLabel: 'كيس',
      purchasePricePiasters: 1000,
      salePricePiasters: 1500, // 15 EGP
      minimumStockMilliUnits: 1000,
      startingStockMilliUnits: 5000,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          inventoryRepositoryProvider.overrideWithValue(inventoryRepo),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: QuickPosScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Add product to cart
    await tester.tap(find.text('شيبسي عائلي'));
    await tester.pumpAndSettle();

    // Tap checkout cash button
    expect(find.text('استلام كاش'), findsOneWidget);
    await tester.tap(find.text('استلام كاش'));
    await tester.pumpAndSettle();

    // Sale should complete and clear cart
    expect(find.text('ضيف أصناف عشان تبدأ البيع'), findsOneWidget);

    await db.close();
  });

  testWidgets('QuickPosScreen supports pre-selected initialCustomerId for credit sale', (tester) async {
    tester.view.physicalSize = const Size(412 * 2.5, 915 * 2.5);
    tester.view.devicePixelRatio = 2.5;

    final db = AppDatabase(NativeDatabase.memory());
    final customerRepo = CustomerRepository(db);
    final customerId = await customerRepo.addCustomer(name: 'علي حسن', phone: '01099887766');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          customerRepositoryProvider.overrideWithValue(customerRepo),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: QuickPosScreen(initialCustomerId: customerId),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Payment type should be credit and selected customer shown
    expect(find.text('على حساب عميل'), findsOneWidget);
    expect(find.text('علي حسن'), findsOneWidget);

    await db.close();
  });
}
