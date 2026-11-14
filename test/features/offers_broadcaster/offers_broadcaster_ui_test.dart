import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/theme/app_theme.dart';
import 'package:kashkool/core/utils/customer_rating.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/offers_broadcaster/data/offers_broadcaster_repository.dart';
import 'package:kashkool/features/offers_broadcaster/domain/offer_campaign.dart';
import 'package:kashkool/features/offers_broadcaster/presentation/offers_broadcaster_screen.dart';
import 'package:kashkool/features/offers_broadcaster/presentation/offers_providers.dart';
import 'package:kashkool/features/offers_broadcaster/presentation/offers_queue_screen.dart';
import 'package:kashkool/features/onboarding/data/shop_repository.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';
import 'package:kashkool/l10n/app_localizations.dart';

void main() {
  testWidgets('OffersBroadcasterScreen renders templates, audience filters, and message editor', (tester) async {
    tester.view.physicalSize = const Size(412 * 2.5, 915 * 2.5);
    tester.view.devicePixelRatio = 2.5;

    final db = AppDatabase(NativeDatabase.memory());
    final customerRepo = CustomerRepository(db);
    final settingsRepo = SettingsRepository(db);
    final offersRepo = OffersBroadcasterRepository(
      customerRepo: customerRepo,
      settingsRepo: settingsRepo,
    );

    // Add a customer with a phone number
    await customerRepo.addCustomer(
      name: 'محمود سعد',
      phone: '01012345678',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          customerRepositoryProvider.overrideWithValue(customerRepo),
          settingsRepositoryProvider.overrideWithValue(settingsRepo),
          offersBroadcasterRepositoryProvider.overrideWithValue(offersRepo),
          previewRecipientsProvider.overrideWith(
            (ref) => Future.value(
              const [
                OfferRecipient(
                  id: 'c1',
                  name: 'محمود سعد',
                  phone: '01012345678',
                  ratingBadge: RatingBadge.good,
                  balancePiasters: 0,
                ),
              ],
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: OffersBroadcasterScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify Title & Sections
    expect(find.text('رسائل العروض والمعايدات'), findsOneWidget);
    expect(find.text('1. اختر القالب'), findsOneWidget);
    expect(find.text('2. اختر الجمهور المستهدف'), findsOneWidget);
    expect(find.text('3. نص الرسالة والمعاينة'), findsOneWidget);

    // Verify Templates exist
    expect(find.text('رمضان المبارك 🌙'), findsOneWidget);
    expect(find.text('العيد المبارك 🎉'), findsOneWidget);
    expect(find.text('عروض جديدة 🎁'), findsOneWidget);

    // Verify Audience count
    expect(find.text('المستهدفون حالياً: 1 عميل'), findsOneWidget);

    // Verify Start Campaign button exists with 1 customer
    expect(find.text('بدء طابور الإرسال (1 عميل)'), findsOneWidget);

    await db.close();
  });

  testWidgets('OffersQueueScreen renders recipient card, progress, and WhatsApp send button', (tester) async {
    tester.view.physicalSize = const Size(412 * 2.5, 915 * 2.5);
    tester.view.devicePixelRatio = 2.5;

    final db = AppDatabase(NativeDatabase.memory());
    final customerRepo = CustomerRepository(db);
    final settingsRepo = SettingsRepository(db);
    final offersRepo = OffersBroadcasterRepository(
      customerRepo: customerRepo,
      settingsRepo: settingsRepo,
    );

    final campaign = BroadcasterCampaign(
      id: 'test-camp',
      title: 'عروض خاصة',
      templateType: OfferTemplateType.newOffer,
      templateText: 'أهلاً يا {customer_name} في {shop_name}',
      audienceFilter: OfferAudienceFilter.allWithPhone,
      recipients: const [
        OfferRecipient(
          id: 'cust-1',
          name: 'كريم سعيد',
          phone: '01099998888',
          ratingBadge: RatingBadge.good,
          balancePiasters: 25000, // 250 EGP
        ),
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await offersRepo.saveCampaign(campaign);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          customerRepositoryProvider.overrideWithValue(customerRepo),
          settingsRepositoryProvider.overrideWithValue(settingsRepo),
          offersBroadcasterRepositoryProvider.overrideWithValue(offersRepo),
          activeShopStreamProvider.overrideWith((ref) => Stream.value(null)),
          shopCodeProvider.overrideWith((ref) => Future.value('KASH12')),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: OffersQueueScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify Queue Screen details
    expect(find.text('طابور الإرسال'), findsOneWidget);
    expect(find.text('كريم سعيد'), findsOneWidget);
    expect(find.text('010 9999 8888'), findsOneWidget);
    expect(find.text('ابعت عبر واتساب'), findsOneWidget);
    expect(find.text('تخطي العميل'), findsOneWidget);

    await db.close();
  });
}
