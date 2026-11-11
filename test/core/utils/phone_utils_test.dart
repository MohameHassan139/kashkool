import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/utils/phone.dart';

void main() {
  group('PhoneUtils.isValidEgyptianMobile & normalizeEgyptianMobile', () {
    test('validates standard 11-digit local mobile numbers', () {
      expect(PhoneUtils.isValidEgyptianMobile('01012345678'), isTrue);
      expect(PhoneUtils.isValidEgyptianMobile('01198765432'), isTrue);
      expect(PhoneUtils.isValidEgyptianMobile('01234567890'), isTrue);
      expect(PhoneUtils.isValidEgyptianMobile('01511223344'), isTrue);

      expect(
        PhoneUtils.normalizeEgyptianMobile('01012345678'),
        equals('01012345678'),
      );
    });

    test('handles international prefixes (+20, 0020, 20)', () {
      expect(
        PhoneUtils.normalizeEgyptianMobile('+201012345678'),
        equals('01012345678'),
      );
      expect(
        PhoneUtils.normalizeEgyptianMobile('00201012345678'),
        equals('01012345678'),
      );
      expect(
        PhoneUtils.normalizeEgyptianMobile('201012345678'),
        equals('01012345678'),
      );
    });

    test('handles formatted numbers with spaces, dashes, and parentheses', () {
      expect(
        PhoneUtils.normalizeEgyptianMobile('010 1234 5678'),
        equals('01012345678'),
      );
      expect(
        PhoneUtils.normalizeEgyptianMobile('+20 (11) 9876-5432'),
        equals('01198765432'),
      );
    });

    test('handles Arabic-Indic digits', () {
      expect(
        PhoneUtils.normalizeEgyptianMobile('٠١٠١٢٣٤٥٦٧٨'),
        equals('01012345678'),
      );
      expect(PhoneUtils.isValidEgyptianMobile('٠١٠١٢٣٤٥٦٧٨'), isTrue);
    });

    test('rejects invalid numbers', () {
      // Invalid prefix
      expect(PhoneUtils.isValidEgyptianMobile('01312345678'), isFalse);
      expect(PhoneUtils.isValidEgyptianMobile('01412345678'), isFalse);
      expect(
        PhoneUtils.isValidEgyptianMobile('0223456789'),
        isFalse,
      ); // Landline

      // Invalid length
      expect(PhoneUtils.isValidEgyptianMobile('010123456'), isFalse);
      expect(PhoneUtils.isValidEgyptianMobile('010123456789'), isFalse);

      // Malformed / Empty
      expect(PhoneUtils.isValidEgyptianMobile(''), isFalse);
      expect(PhoneUtils.isValidEgyptianMobile(null), isFalse);
      expect(PhoneUtils.isValidEgyptianMobile('abcdefghijk'), isFalse);
    });
  });

  group('PhoneUtils.isValidPhone & normalizePhone', () {
    test('accepts international numbers and valid local lengths', () {
      expect(PhoneUtils.isValidPhone('+1 (202) 555-0123'), isTrue);
      expect(PhoneUtils.normalizePhone('+1 (202) 555-0123'), '+12025550123');
      expect(PhoneUtils.normalizePhone('0044 20 7946 0958'), '+442079460958');
      expect(PhoneUtils.normalizePhone('1234567'), '1234567');
      expect(PhoneUtils.normalizePhone('+201012345678'), '01012345678');
    });

    test('rejects malformed or out-of-range numbers', () {
      expect(PhoneUtils.isValidPhone('123456'), isFalse);
      expect(PhoneUtils.isValidPhone('1234567890123456'), isFalse);
      expect(PhoneUtils.isValidPhone('+1+2025550123'), isFalse);
      expect(PhoneUtils.isValidPhone('phone12345678'), isFalse);
      expect(PhoneUtils.isValidPhone(''), isFalse);
      expect(PhoneUtils.isValidPhone(null), isFalse);
    });
  });

  group('PhoneUtils.toWhatsAppFormat', () {
    test(
      'converts valid Egyptian numbers to WhatsApp international format (201XXXXXXXXX)',
      () {
        expect(
          PhoneUtils.toWhatsAppFormat('01012345678'),
          equals('201012345678'),
        );
        expect(
          PhoneUtils.toWhatsAppFormat('+201198765432'),
          equals('201198765432'),
        );
        expect(
          PhoneUtils.toWhatsAppFormat('012 3456 7890'),
          equals('201234567890'),
        );
        expect(
          PhoneUtils.toWhatsAppFormat('٠١٥١١٢٢٣٣٤٤'),
          equals('201511223344'),
        );
      },
    );

    test('returns null for invalid phone numbers', () {
      expect(PhoneUtils.toWhatsAppFormat('01312345678'), isNull);
      expect(PhoneUtils.toWhatsAppFormat(''), isNull);
      expect(PhoneUtils.toWhatsAppFormat(null), isNull);
    });

    test('supports international numbers with a country prefix', () {
      expect(PhoneUtils.toWhatsAppFormat('+1 (202) 555-0123'), '12025550123');
      expect(PhoneUtils.toWhatsAppFormat('0044 20 7946 0958'), '442079460958');
      expect(PhoneUtils.toWhatsAppFormat('12025550123'), isNull);
    });
  });

  group('PhoneUtils.formatDisplay', () {
    test('formats valid numbers for display', () {
      expect(PhoneUtils.formatDisplay('01012345678'), equals('010 1234 5678'));
      expect(
        PhoneUtils.formatDisplay('+201198765432'),
        equals('011 9876 5432'),
      );
    });

    test('returns original string or empty for invalid/null input', () {
      expect(PhoneUtils.formatDisplay('123'), equals('123'));
      expect(PhoneUtils.formatDisplay(null), equals(''));
    });
  });
}
