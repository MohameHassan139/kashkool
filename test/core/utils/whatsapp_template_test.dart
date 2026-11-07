import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/utils/whatsapp_template.dart';

void main() {
  group('WhatsAppTemplateUtils render', () {
    test('renders friendly template with placeholders and growth footer', () {
      final tx = Transaction(
        id: 'tx-1',
        shopId: 'shop-1',
        deviceId: 'dev-1',
        createdBy: 'user-1',
        partyType: PartyType.customer,
        partyId: 'c-1',
        type: TransactionType.debt,
        amountPiasters: 15000, // 150 EGP
        occurredAt: DateTime(2026, 11, 1),
        createdAt: DateTime(2026, 11, 1),
        updatedAt: DateTime(2026, 11, 1),
      );

      final rendered = WhatsAppTemplateUtils.render(
        customerName: 'محمود عبد العزيز',
        shopName: 'سوبر ماركت النور',
        balancePiasters: 75000, // 750 EGP
        lastTransaction: tx,
        paymentInfo: 'إنستاباي على 01012345678',
        shopCode: 'K7X9W2',
      );

      expect(rendered, contains('محمود عبد العزيز'));
      expect(rendered, contains('سوبر ماركت النور'));
      expect(rendered, contains('750 جنيه'));
      expect(rendered, contains('2026/11/01'));
      expect(rendered, contains('150 جنيه'));
      expect(rendered, contains('إنستاباي على 01012345678'));
      expect(rendered, contains('اتعمل بكشكول 📒 جرّبه ببلاش:'));
      expect(rendered, contains('referrer=ref%3DK7X9W2'));
    });

    test('renders formal template correctly', () {
      final rendered = WhatsAppTemplateUtils.render(
        template: WhatsAppTemplateUtils.defaultFormalTemplate,
        customerName: 'أحمد سعيد',
        shopName: 'البركة',
        balancePiasters: 250000, // 2,500 EGP
        paymentInfo: 'فودافون كاش',
        includeGrowthFooter: false,
      );

      expect(rendered, contains('تحية طيبة أ/ أحمد سعيد'));
      expect(rendered, contains('2,500 جنيه'));
      expect(rendered, contains('البركة'));
      expect(rendered, contains('فودافون كاش'));
      expect(rendered.contains('كشكول 📒'), isFalse);
    });

    test('builds valid wa.me URL with phone normalized and Arabic encoded', () {
      final url = WhatsAppTemplateUtils.buildWhatsAppUrl(
        phone: '010 1234 5678',
        message: 'السلام عليكم يا حاج أحمد 👋',
      );

      expect(url, isNotNull);
      expect(url, startsWith('https://wa.me/201012345678?text='));
      // Verifies Arabic and emoji are percent-encoded
      expect(url, contains('%D8%A7%D9%84%D8%B3%D9%84%D8%A7%D9%85'));
    });

    test('returns null for invalid phone numbers', () {
      final url = WhatsAppTemplateUtils.buildWhatsAppUrl(
        phone: 'invalid-number',
        message: 'hello',
      );
      expect(url, isNull);
    });

    test('builds SMS URI with proper query parameters', () {
      final uri = WhatsAppTemplateUtils.buildSmsUri(
        phone: '01012345678',
        message: 'تذكير حسابك',
      );

      expect(uri.scheme, equals('sms'));
      expect(uri.path, equals('01012345678'));
      expect(uri.queryParameters['body'], equals('تذكير حسابك'));
    });
  });
}
