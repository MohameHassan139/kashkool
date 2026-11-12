import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/utils/quantity.dart';

void main() {
  group('QuantityUtils.parseMilliUnits', () {
    test('converts whole and fractional quantities to fixed-point units', () {
      expect(QuantityUtils.parseMilliUnits('2'), 2000);
      expect(QuantityUtils.parseMilliUnits('1.25'), 1250);
      expect(QuantityUtils.parseMilliUnits('0.005'), 5);
    });

    test('accepts Arabic digits and decimal separators', () {
      expect(QuantityUtils.parseMilliUnits('١٢٫٥'), 12500);
      expect(QuantityUtils.parseMilliUnits('١٫٢٥'), 1250);
    });

    test('rejects negative values and precision beyond three places', () {
      expect(QuantityUtils.parseMilliUnits('-1'), isNull);
      expect(QuantityUtils.parseMilliUnits('1.0001'), isNull);
      expect(QuantityUtils.parseMilliUnits('invalid'), isNull);
    });
  });

  group('QuantityUtils.formatMilliUnits', () {
    test('formats whole and fractional quantities without trailing zeroes', () {
      expect(QuantityUtils.formatMilliUnits(2000), '2');
      expect(QuantityUtils.formatMilliUnits(1250), '1.25');
      expect(QuantityUtils.formatMilliUnits(5), '0.005');
      expect(QuantityUtils.formatMilliUnits(-1250), '-1.25');
    });
  });
}
