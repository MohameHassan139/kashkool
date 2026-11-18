import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/theme/app_theme.dart';
import 'package:kashkool/core/utils/customer_rating.dart';
import 'package:kashkool/features/cash_drawer/domain/drawer_day_summary.dart';
import 'package:kashkool/features/cash_drawer/presentation/widgets/drawer_flow_card.dart';
import 'package:kashkool/features/cash_drawer/presentation/widgets/drawer_live_card.dart';
import 'package:kashkool/features/collection/domain/due_customer.dart';
import 'package:kashkool/features/collection/presentation/widgets/collection_list_item.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/l10n/app_localizations.dart';
import 'package:kashkool/l10n/l10n.dart';

Widget _wrapper({
  required Widget child,
  required Locale locale,
  List<Override> overrides = const [],
}) {
  final rtl = {'ar', 'fa', 'ur'}.contains(locale.languageCode);
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Directionality(
        textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(
            size: Size(320, 568),
            textScaler: TextScaler.linear(1.3),
          ),
          child: Scaffold(
            body: SingleChildScrollView(child: child),
          ),
        ),
      ),
    ),
  );
}

void main() {
  for (final language in L10n.languages) {
    testWidgets('money cards and long names fit ${language.code} at 320dp / 1.3x text', (tester) async {
      tester.view.physicalSize = const Size(640, 1136);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      L10n.setLocale(language.locale);

      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);

      final customer = Customer(
        id: 'cust-i18n',
        shopId: 'shop-i18n',
        deviceId: 'dev-i18n',
        createdBy: 'dev-i18n',
        name: 'الحاج عبد المنعم الشربيني أحمد عبد الرحمن',
        phone: '01012345678',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final due = DueCustomer(
        customer: customer,
        balancePiasters: 154500000,
        oldestUnpaidAgeDays: 120,
        rating: const CustomerRatingResult(
          badge: RatingBadge.watch,
          oldestUnpaidAgeDays: 120,
          explanation: 'متابعة',
        ),
      );
      final summary = DrawerDaySummary(
        date: DateTime(2026, 11, 18),
        openingCashPiasters: 25000000,
        cashSalesPiasters: 34500000,
        customerCashPaymentsPiasters: 12000000,
        customerDigitalPaymentsPiasters: 5000000,
        supplierCashPaymentsPiasters: 4000000,
        expensesCashPiasters: 8000000,
        expensesDigitalPiasters: 2000000,
        actualCountPiasters: 63500000,
        closedAt: DateTime(2026, 11, 18, 23, 0),
      );

      await tester.pumpWidget(
        _wrapper(
          locale: language.locale,
          overrides: [databaseProvider.overrideWithValue(db)],
          child: Column(
            children: [
              CollectionListItem(
                item: due,
                onTap: () {},
                onWhatsApp: () {},
                onSms: () {},
                onCall: () {},
                onActionSelected: (_) {},
              ),
              const SizedBox(height: 8),
              DrawerLiveCard(summary: summary),
              const SizedBox(height: 8),
              DrawerFlowCard(summary: summary),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byType(CollectionListItem), findsOneWidget);
      expect(find.byType(DrawerLiveCard), findsOneWidget);
      expect(find.byType(DrawerFlowCard), findsOneWidget);
    });
  }
}
