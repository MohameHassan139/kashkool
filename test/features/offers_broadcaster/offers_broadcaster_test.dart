import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/utils/customer_rating.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/offers_broadcaster/data/offers_broadcaster_repository.dart';
import 'package:kashkool/features/offers_broadcaster/domain/offer_campaign.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';
import 'package:kashkool/features/transactions/data/transaction_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late CustomerRepository customerRepo;
  late SettingsRepository settingsRepo;
  late TransactionRepository txRepo;
  late OffersBroadcasterRepository offersRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    customerRepo = CustomerRepository(db);
    settingsRepo = SettingsRepository(db);
    txRepo = TransactionRepository(db);
    offersRepo = OffersBroadcasterRepository(
      customerRepo: customerRepo,
      settingsRepo: settingsRepo,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('Feature 18: Offers & Greetings Broadcaster', () {
    test('Personalizes message placeholders and appends growth footer', () {
      final renderedWithFooter = offersRepo.renderPersonalizedMessage(
        template: 'كل عام وحضرتك بخير يا {customer_name} من {shop_name}!',
        customerName: 'أحمد محمود',
        shopName: 'بقالة الأمانة',
        includeGrowthFooter: true,
        shopCode: 'ABC123',
      );

      expect(renderedWithFooter, contains('أحمد محمود'));
      expect(renderedWithFooter, contains('بقالة الأمانة'));
      expect(renderedWithFooter, contains('اتعمل بكشكول'));
      expect(renderedWithFooter, contains('ABC123'));

      final renderedWithoutFooter = offersRepo.renderPersonalizedMessage(
        template: 'أهلاً يا {customer_name} في {shop_name}',
        customerName: 'علي حسن',
        shopName: 'سوبرماركت التوفيق',
        includeGrowthFooter: false,
      );

      expect(renderedWithoutFooter, equals('أهلاً يا علي حسن في سوبرماركت التوفيق'));
      expect(renderedWithoutFooter.contains('اتعمل بكشكول'), isFalse);
    });

    test('Audience filters return correct customers and exclude customers without phone', () async {
      // 1. Customer with phone + good rating (settled balance)
      final c1Id = await customerRepo.addCustomer(
        name: 'محمد أحمد',
        phone: '01011111111',
      );

      // 2. Customer with phone + active recent transaction (3 days ago)
      final c2Id = await customerRepo.addCustomer(
        name: 'إبراهيم علي',
        phone: '01022222222',
      );
      await txRepo.addTransaction(
        partyId: c2Id,
        partyType: PartyType.customer,
        type: TransactionType.debt,
        amountPiasters: 15000,
        occurredAt: DateTime.now().subtract(const Duration(days: 3)),
      );

      // 3. Customer WITHOUT phone
      await customerRepo.addCustomer(
        name: 'محمود بدون هاتف',
        phone: null,
      );

      // 4. Customer with phone + late rating (debt from 60 days ago)
      final c4Id = await customerRepo.addCustomer(
        name: 'سامي متأخر',
        phone: '01044444444',
      );
      await txRepo.addTransaction(
        partyId: c4Id,
        partyType: PartyType.customer,
        type: TransactionType.debt,
        amountPiasters: 50000,
        occurredAt: DateTime.now().subtract(const Duration(days: 60)),
      );

      // Test allWithPhone filter: returns c1, c2, c4 (excludes c3)
      final allWithPhone = await offersRepo.loadRecipients(
        filter: OfferAudienceFilter.allWithPhone,
      );
      final allIds = allWithPhone.map((r) => r.id).toSet();
      expect(allIds.contains(c1Id), isTrue);
      expect(allIds.contains(c2Id), isTrue);
      expect(allIds.contains(c4Id), isTrue);
      expect(allWithPhone.length, equals(3));

      // Test active30Days filter: returns c2 (active 3 days ago), excludes c1 (no txs) and c4 (60 days ago)
      final active30 = await offersRepo.loadRecipients(
        filter: OfferAudienceFilter.active30Days,
      );
      expect(active30.length, equals(1));
      expect(active30.first.id, equals(c2Id));

      // Test manual filter: returns only specified customer ids
      final manual = await offersRepo.loadRecipients(
        filter: OfferAudienceFilter.manual,
        manualSelectedIds: {c1Id, c4Id},
      );
      expect(manual.length, equals(2));
      expect(manual.map((r) => r.id).toSet(), equals({c1Id, c4Id}));
    });

    test('Queue resumes where it stopped after app restart', () async {
      final recipients = [
        const OfferRecipient(
          id: 'rec-1',
          name: 'عميل 1',
          phone: '01011111111',
          ratingBadge: RatingBadge.good,
          balancePiasters: 0,
        ),
        const OfferRecipient(
          id: 'rec-2',
          name: 'عميل 2',
          phone: '01022222222',
          ratingBadge: RatingBadge.good,
          balancePiasters: 1000,
        ),
        const OfferRecipient(
          id: 'rec-3',
          name: 'عميل 3',
          phone: '01033333333',
          ratingBadge: RatingBadge.good,
          balancePiasters: 2000,
        ),
      ];

      final campaign = BroadcasterCampaign(
        id: 'campaign-123',
        title: 'عروض العيد',
        templateType: OfferTemplateType.eid,
        templateText: 'عيد سعيد يا {customer_name}',
        audienceFilter: OfferAudienceFilter.allWithPhone,
        recipients: recipients,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save initial campaign
      await offersRepo.saveCampaign(campaign);

      var active = await offersRepo.getActiveCampaign();
      expect(active, isNotNull);
      expect(active!.totalCount, equals(3));
      expect(active.sentCount, equals(0));
      expect(active.nextPendingRecipient?.id, equals('rec-1'));

      // Mark recipient 1 as sent
      await offersRepo.markCustomerSent('rec-1');

      active = await offersRepo.getActiveCampaign();
      expect(active!.sentCount, equals(1));
      expect(active.nextPendingRecipient?.id, equals('rec-2'));

      // Mark recipient 2 as skipped
      await offersRepo.markCustomerSkipped('rec-2');

      active = await offersRepo.getActiveCampaign();
      expect(active!.sentCount, equals(1));
      expect(active.skippedCount, equals(1));
      expect(active.nextPendingRecipient?.id, equals('rec-3'));

      // Simulate App Restart by creating a new repository instance pointing to the same DB
      final restartedRepo = OffersBroadcasterRepository(
        customerRepo: customerRepo,
        settingsRepo: settingsRepo,
      );

      final resumedCampaign = await restartedRepo.getActiveCampaign();
      expect(resumedCampaign, isNotNull);
      expect(resumedCampaign!.id, equals('campaign-123'));
      expect(resumedCampaign.sentCustomerIds, equals(['rec-1']));
      expect(resumedCampaign.skippedCustomerIds, equals(['rec-2']));
      expect(resumedCampaign.nextPendingRecipient?.id, equals('rec-3'));
      expect(resumedCampaign.isCompleted, isFalse);

      // Finish the queue by sending the last recipient
      await restartedRepo.markCustomerSent('rec-3');
      final completed = await restartedRepo.getActiveCampaign();
      expect(completed!.isCompleted, isTrue);
      expect(completed.nextPendingRecipient, isNull);
    });
  });
}
