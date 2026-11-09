import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/security/pin_lock_screen.dart';
import 'package:kashkool/core/theme/app_theme.dart';
import 'package:kashkool/core/utils/customer_rating.dart';
import 'package:kashkool/features/cash_drawer/domain/drawer_day_summary.dart';
import 'package:kashkool/features/cash_drawer/presentation/widgets/add_cash_sales_bottom_sheet.dart';
import 'package:kashkool/features/cash_drawer/presentation/widgets/drawer_flow_card.dart';
import 'package:kashkool/features/cash_drawer/presentation/widgets/drawer_live_card.dart';
import 'package:kashkool/features/cash_drawer/presentation/widgets/edit_opening_cash_dialog.dart';
import 'package:kashkool/features/collection/domain/due_customer.dart';
import 'package:kashkool/features/collection/presentation/widgets/collection_list_item.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/installments/data/installment_repository.dart';
import 'package:kashkool/features/installments/presentation/installment_plan_details_screen.dart';
import 'package:kashkool/features/transactions/presentation/add_transaction_bottom_sheet.dart';
import 'package:kashkool/l10n/app_localizations.dart';

Widget _buildTestWrapper({
  required Widget child,
  List<Override> overrides = const [],
  double textScale = 1.3,
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      locale: const Locale('ar'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: MediaQuery(
          data: MediaQueryData(
            size: const Size(320, 568),
            textScaler: TextScaler.linear(textScale),
          ),
          child: Material(child: child),
        ),
      ),
    ),
  );
}

void main() {
  setUp(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      throw details.exception;
    };
  });

  testWidgets('CollectionListItem does not overflow on 320dp with large text scale', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final mockCustomer = Customer(
      id: 'cust-1',
      shopId: 'shop-1',
      deviceId: 'dev-1',
      createdBy: 'dev-1',
      name: 'الحاج عبد المنعم الشربيني أحمد',
      phone: '01012345678',
      lastReminderAt: DateTime.now().subtract(const Duration(days: 45)),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final dueCustomer = DueCustomer(
      customer: mockCustomer,
      balancePiasters: 1545000,
      oldestUnpaidAgeDays: 120,
      rating: const CustomerRatingResult(
        badge: RatingBadge.watch,
        oldestUnpaidAgeDays: 120,
        explanation: 'متابعة',
      ),
    );

    await tester.pumpWidget(
      _buildTestWrapper(
        textScale: 1.35,
        child: SingleChildScrollView(
          child: CollectionListItem(
            item: dueCustomer,
            onTap: () {},
            onWhatsApp: () {},
            onSms: () {},
            onCall: () {},
            onActionSelected: (_) {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('الحاج عبد المنعم الشربيني أحمد'), findsOneWidget);
  });

  testWidgets('DrawerLiveCard and DrawerFlowCard do not overflow on 320dp with large text scale', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final summary = DrawerDaySummary(
      date: DateTime(2026, 11, 9),
      openingCashPiasters: 250000,
      cashSalesPiasters: 345000,
      customerCashPaymentsPiasters: 120000,
      customerDigitalPaymentsPiasters: 50000,
      supplierCashPaymentsPiasters: 40000,
      expensesCashPiasters: 80000,
      expensesDigitalPiasters: 20000,
      actualCountPiasters: 635000,
      closedAt: DateTime(2026, 11, 9, 23, 0),
    );

    await tester.pumpWidget(
      _buildTestWrapper(
        textScale: 1.3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerLiveCard(summary: summary),
              DrawerFlowCard(summary: summary),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(DrawerLiveCard), findsOneWidget);
    expect(find.byType(DrawerFlowCard), findsOneWidget);
  });

  testWidgets('AddCashSalesBottomSheet does not overflow on 320dp with large text scale', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _buildTestWrapper(
        textScale: 1.3,
        child: AddCashSalesBottomSheet(
          date: DateTime.now(),
          currentSalesPiasters: 150000,
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(AddCashSalesBottomSheet), findsOneWidget);
  });

  testWidgets('EditOpeningCashDialog does not overflow on 320dp', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _buildTestWrapper(
        textScale: 1.3,
        child: EditOpeningCashDialog(
          date: DateTime.now(),
          currentOpeningPiasters: 50000,
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(EditOpeningCashDialog), findsOneWidget);
  });

  testWidgets('PinLockScreen does not overflow on 320x568 small screen', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _buildTestWrapper(
        textScale: 1.25,
        child: const PinLockScreen(mode: PinLockMode.unlock),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(PinLockScreen), findsOneWidget);
  });

  testWidgets('InstallmentPlanDetailsScreen does not overflow early settlement button on 320dp', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = AppDatabase(NativeDatabase.memory());
    final custRepo = CustomerRepository(db);
    final instRepo = InstallmentRepository(db);

    final custId = await custRepo.addCustomer(name: 'محمود عبد الفتاح', phone: '01011122233');
    final planId = await instRepo.createPlan(
      customerId: custId,
      itemDescription: 'غسالة توشيبا فوق أوتوماتيك 10 كيلو',
      totalPricePiasters: 1500000,
      downPaymentPiasters: 300000,
      installmentCount: 12,
      startDate: DateTime(2026, 6, 1),
    );

    await tester.pumpWidget(
      _buildTestWrapper(
        textScale: 1.3,
        overrides: [
          databaseProvider.overrideWithValue(db),
          installmentRepositoryProvider.overrideWithValue(instRepo),
        ],
        child: InstallmentPlanDetailsScreen(planId: planId),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(InstallmentPlanDetailsScreen), findsOneWidget);
    expect(find.text('سداد مبكر وتصفية بالكامل'), findsOneWidget);

    await db.close();
  });

  testWidgets('AddTransactionBottomSheet renders cleanly on 320dp with large text scale', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _buildTestWrapper(
        textScale: 1.25,
        child: const AddTransactionBottomSheet(
          partyType: PartyType.customer,
          partyId: 'cust-123',
          partyName: 'أحمد محمود عبد الرحمن',
          currentBalancePiasters: 250000,
          creditLimitPiasters: 500000,
          initialType: TransactionType.debt,
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(AddTransactionBottomSheet), findsOneWidget);
  });
}
