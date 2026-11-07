import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/utils/money.dart';

void main() {
  group('MoneyUtils.toPiasters', () {
    test('converts plain integer pounds', () {
      expect(MoneyUtils.toPiasters('50'), equals(5000));
      expect(MoneyUtils.toPiasters('1'), equals(100));
      expect(MoneyUtils.toPiasters('0'), equals(0));
    });

    test('converts decimal pounds with 1 or 2 decimal places', () {
      expect(MoneyUtils.toPiasters('12.5'), equals(1250));
      expect(MoneyUtils.toPiasters('12.50'), equals(1250));
      expect(MoneyUtils.toPiasters('0.05'), equals(5));
      expect(MoneyUtils.toPiasters('0.75'), equals(75));
      expect(MoneyUtils.toPiasters('100.99'), equals(10099));
    });

    test('converts strings with commas and whitespace', () {
      expect(MoneyUtils.toPiasters('1,000'), equals(100000));
      expect(MoneyUtils.toPiasters(' 1,000.50 '), equals(100050));
      expect(MoneyUtils.toPiasters('25,000'), equals(2500000));
    });

    test('handles Arabic-Indic numerals and Arabic decimal separator', () {
      expect(MoneyUtils.toPiasters('٥٠'), equals(5000));
      expect(MoneyUtils.toPiasters('١٢.٥'), equals(1250));
      expect(MoneyUtils.toPiasters('١٢٫٥'), equals(1250));
      expect(MoneyUtils.toPiasters('١,٠٠٠'), equals(100000));
      expect(MoneyUtils.toPiasters('١٬٠٠٠'), equals(100000));
    });

    test('rounds fractional piasters (> 2 decimal places)', () {
      expect(MoneyUtils.toPiasters('10.556'), equals(1056));
      expect(MoneyUtils.toPiasters('10.554'), equals(1055));
    });

    test('handles negative values', () {
      expect(MoneyUtils.toPiasters('-50'), equals(-5000));
      expect(MoneyUtils.toPiasters('-12.50'), equals(-1250));
    });

    test('handles invalid inputs gracefully by returning fallback', () {
      expect(MoneyUtils.toPiasters(''), equals(0));
      expect(MoneyUtils.toPiasters('abc'), equals(0));
      expect(MoneyUtils.toPiasters('12.34.56'), equals(0));
      expect(MoneyUtils.toPiasters('-', fallback: -1), equals(-1));
      expect(MoneyUtils.toPiasters('invalid', fallback: 999), equals(999));
    });
  });

  group('MoneyUtils.formatMoney', () {
    test('formats whole pounds without trailing decimal zeros', () {
      expect(MoneyUtils.formatMoney(5000), equals('50 جنيه'));
      expect(MoneyUtils.formatMoney(0), equals('0 جنيه'));
      expect(MoneyUtils.formatMoney(100000), equals('1,000 جنيه'));
    });

    test('formats pounds with piasters when present', () {
      expect(MoneyUtils.formatMoney(1250), equals('12.50 جنيه'));
      expect(MoneyUtils.formatMoney(5), equals('0.05 جنيه'));
      expect(MoneyUtils.formatMoney(100075), equals('1,000.75 جنيه'));
    });

    test('formats without currency suffix when requested', () {
      expect(MoneyUtils.formatMoney(5000, includeCurrency: false), equals('50'));
      expect(MoneyUtils.formatMoney(1250, includeCurrency: false), equals('12.50'));
    });

    test('formats negative amounts correctly', () {
      expect(MoneyUtils.formatMoney(-2500), equals('-25 جنيه'));
      expect(MoneyUtils.formatMoney(-1250), equals('-12.50 جنيه'));
    });
  });

  group('MoneyUtils.toPounds', () {
    test('converts piasters to pounds as double', () {
      expect(MoneyUtils.toPounds(5000), equals(50.0));
      expect(MoneyUtils.toPounds(1250), equals(12.5));
      expect(MoneyUtils.toPounds(0), equals(0.0));
      expect(MoneyUtils.toPounds(-2500), equals(-25.0));
    });
  });
}
