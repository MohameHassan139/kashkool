import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/utils/phone.dart';

void main() {
  group('PhoneUtils.isValid & normalize', () {
    test('validates standard local mobile numbers without country code', () {
      expect(PhoneUtils.isValid('01012345678'), isTrue);
      expect(PhoneUtils.isValid('01198765432'), isTrue);
      expect(PhoneUtils.isValid('01234567890'), isTrue);
      expect(PhoneUtils.isValid('01511223344'), isTrue);

      expect(PhoneUtils.normalize('01012345678'), equals('01012345678'));
    });

    test('validates 10-digit Egyptian mobile without leading 0', () {
      expect(PhoneUtils.isValid('1012345678'), isTrue);
      expect(PhoneUtils.normalize('1012345678'), equals('01012345678'));
    });

    test('handles international prefixes for Egyptian numbers (+20, 0020, 20)', () {
      expect(PhoneUtils.normalize('+201012345678'), equals('01012345678'));
      expect(PhoneUtils.normalize('00201012345678'), equals('01012345678'));
      expect(PhoneUtils.normalize('201012345678'), equals('01012345678'));
    });

    test('handles formatted numbers with spaces, dashes, and parentheses', () {
      expect(PhoneUtils.normalize('010 1234 5678'), equals('01012345678'));
      expect(PhoneUtils.normalize('+20 (11) 9876-5432'), equals('01198765432'));
    });

    test('handles Arabic-Indic digits', () {
      expect(PhoneUtils.normalize('٠١٠١٢٣٤٥٦٧٨'), equals('01012345678'));
      expect(PhoneUtils.isValid('٠١٠١٢٣٤٥٦٧٨'), isTrue);
    });

    test('validates Egyptian landlines', () {
      expect(PhoneUtils.isValid('0223456789'), isTrue);
      expect(PhoneUtils.normalize('0223456789'), equals('0223456789'));
    });

    test('validates international phone numbers', () {
      // Saudi Arabia
      expect(PhoneUtils.isValid('+966501234567'), isTrue);
      expect(PhoneUtils.normalize('+966501234567'), equals('+966501234567'));

      // Saudi Arabia with 00
      expect(PhoneUtils.isValid('00966501234567'), isTrue);
      expect(PhoneUtils.normalize('00966501234567'), equals('+966501234567'));

      // Saudi Arabia without +
      expect(PhoneUtils.isValid('966501234567'), isTrue);
      expect(PhoneUtils.normalize('966501234567'), equals('+966501234567'));

      // UAE
      expect(PhoneUtils.isValid('+971501234567'), isTrue);
      expect(PhoneUtils.normalize('+971501234567'), equals('+971501234567'));

      // USA
      expect(PhoneUtils.isValid('+12025550123'), isTrue);
      expect(PhoneUtils.normalize('+12025550123'), equals('+12025550123'));
    });

    test('rejects fake/invalid phone numbers', () {
      // Invalid Egyptian mobile prefix
      expect(PhoneUtils.isValid('01312345678'), isFalse);
      expect(PhoneUtils.isValid('01412345678'), isFalse);

      // Too short
      expect(PhoneUtils.isValid('010123456'), isFalse);
      expect(PhoneUtils.isValid('12345'), isFalse);

      // Malformed / Empty
      expect(PhoneUtils.isValid(''), isFalse);
      expect(PhoneUtils.isValid(null), isFalse);
      expect(PhoneUtils.isValid('abcdefghijk'), isFalse);
    });
  });

  group('PhoneUtils.toWhatsAppFormat', () {
    test('converts valid Egyptian numbers to WhatsApp format (201XXXXXXXXX)', () {
      expect(PhoneUtils.toWhatsAppFormat('01012345678'), equals('201012345678'));
      expect(PhoneUtils.toWhatsAppFormat('+201198765432'), equals('201198765432'));
      expect(PhoneUtils.toWhatsAppFormat('012 3456 7890'), equals('201234567890'));
      expect(PhoneUtils.toWhatsAppFormat('٠١٥١١٢٢٣٣٤٤'), equals('201511223344'));
    });

    test('converts valid international numbers to WhatsApp format (<countryCode><number>)', () {
      expect(PhoneUtils.toWhatsAppFormat('+966501234567'), equals('966501234567'));
      expect(PhoneUtils.toWhatsAppFormat('00966501234567'), equals('966501234567'));
      expect(PhoneUtils.toWhatsAppFormat('966501234567'), equals('966501234567'));
      expect(PhoneUtils.toWhatsAppFormat('+971501234567'), equals('971501234567'));
      expect(PhoneUtils.toWhatsAppFormat('+12025550123'), equals('12025550123'));
    });

    test('returns null for invalid phone numbers', () {
      expect(PhoneUtils.toWhatsAppFormat('01312345678'), isNull);
      expect(PhoneUtils.toWhatsAppFormat(''), isNull);
      expect(PhoneUtils.toWhatsAppFormat(null), isNull);
    });
  });

  group('PhoneUtils.formatDisplay', () {
    test('formats Egyptian mobile numbers for display', () {
      expect(PhoneUtils.formatDisplay('01012345678'), equals('010 1234 5678'));
      expect(PhoneUtils.formatDisplay('+201198765432'), equals('011 9876 5432'));
    });

    test('formats international numbers for display', () {
      expect(PhoneUtils.formatDisplay('+966501234567'), contains('+966'));
    });

    test('returns original string or empty for invalid/null input', () {
      expect(PhoneUtils.formatDisplay('123'), equals('123'));
      expect(PhoneUtils.formatDisplay(null), equals(''));
    });
  });
}
