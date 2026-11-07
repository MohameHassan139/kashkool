import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/utils/arabic_search.dart';

void main() {
  group('ArabicSearchUtils.normalize', () {
    test('normalizes various Alef forms to bare Alef (ا)', () {
      expect(ArabicSearchUtils.normalize('أحمد'), equals('احمد'));
      expect(ArabicSearchUtils.normalize('إبراهيم'), equals('ابراهيم'));
      expect(ArabicSearchUtils.normalize('آدم'), equals('ادم'));
      expect(ArabicSearchUtils.normalize('ٱبن'), equals('ابن'));
    });

    test('normalizes Taa Marbouta (ة) to Haa (ه)', () {
      expect(ArabicSearchUtils.normalize('فاطمة'), equals('فاطمه'));
      expect(ArabicSearchUtils.normalize('مكتبة'), equals('مكتبه'));
    });

    test('normalizes Alef Maksoura (ى) to Yaa (ي)', () {
      expect(ArabicSearchUtils.normalize('منى'), equals('مني'));
      expect(ArabicSearchUtils.normalize('مستشفى'), equals('مستشفي'));
    });

    test('strips Tashkeel (diacritics) and Tatweel (kashida)', () {
      expect(ArabicSearchUtils.normalize('مُحَمَّدٌ'), equals('محمد'));
      expect(ArabicSearchUtils.normalize('عـلـي'), equals('علي'));
    });
  });

  group('ArabicSearchUtils.matches', () {
    test('matches text regardless of orthographic variants', () {
      expect(ArabicSearchUtils.matches('أحمد محمد', 'احمد'), isTrue);
      expect(ArabicSearchUtils.matches('احمد محمد', 'أحمد'), isTrue);
      expect(ArabicSearchUtils.matches('فاطمة الزهراء', 'فاطمه'), isTrue);
      expect(ArabicSearchUtils.matches('علي حسن', 'على'), isTrue);
      expect(ArabicSearchUtils.matches('مصطفى كامل', 'مصطفي'), isTrue);
    });

    test('returns false when text does not match', () {
      expect(ArabicSearchUtils.matches('أحمد محمد', 'محمود'), isFalse);
    });

    test('returns true for empty or whitespace query', () {
      expect(ArabicSearchUtils.matches('أي كلام', ''), isTrue);
      expect(ArabicSearchUtils.matches('أي كلام', '   '), isTrue);
    });
  });
}
