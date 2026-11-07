import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/utils/credit_limit.dart';

void main() {
  group('CreditLimitUtils.willExceed', () {
    test('returns false when credit limit is null', () {
      expect(
        CreditLimitUtils.willExceed(
          currentBalancePiasters: 100000,
          addedDebtPiasters: 50000,
          limitPiasters: null,
        ),
        isFalse,
      );
    });

    test('returns false when credit limit is zero or negative', () {
      expect(
        CreditLimitUtils.willExceed(
          currentBalancePiasters: 5000,
          addedDebtPiasters: 5000,
          limitPiasters: 0,
        ),
        isFalse,
      );
      expect(
        CreditLimitUtils.willExceed(
          currentBalancePiasters: 5000,
          addedDebtPiasters: 5000,
          limitPiasters: -1000,
        ),
        isFalse,
      );
    });

    test('returns false when new balance is strictly less than limit', () {
      // 500 EGP + 299 EGP = 799 EGP < 800 EGP
      expect(
        CreditLimitUtils.willExceed(
          currentBalancePiasters: 50000,
          addedDebtPiasters: 29900,
          limitPiasters: 80000,
        ),
        isFalse,
      );
    });

    test('returns false when new balance is exactly equal to limit (not exceeded)', () {
      // 500 EGP + 300 EGP = 800 EGP == 800 EGP
      expect(
        CreditLimitUtils.willExceed(
          currentBalancePiasters: 50000,
          addedDebtPiasters: 30000,
          limitPiasters: 80000,
        ),
        isFalse,
      );
    });

    test('returns true strictly when new balance exceeds limit', () {
      // 500 EGP + 301 EGP = 801 EGP > 800 EGP
      expect(
        CreditLimitUtils.willExceed(
          currentBalancePiasters: 50000,
          addedDebtPiasters: 30100,
          limitPiasters: 80000,
        ),
        isTrue,
      );
    });
  });

  group('CreditLimitUtils.getUsageRatio', () {
    test('computes exact ratio of balance vs limit', () {
      expect(
        CreditLimitUtils.getUsageRatio(balancePiasters: 40000, limitPiasters: 80000),
        equals(0.5),
      );
      expect(
        CreditLimitUtils.getUsageRatio(balancePiasters: 80000, limitPiasters: 80000),
        equals(1.0),
      );
      expect(
        CreditLimitUtils.getUsageRatio(balancePiasters: 120000, limitPiasters: 80000),
        equals(1.5),
      );
    });

    test('returns 0.0 when limit is null or non-positive', () {
      expect(
        CreditLimitUtils.getUsageRatio(balancePiasters: 50000, limitPiasters: null),
        equals(0.0),
      );
      expect(
        CreditLimitUtils.getUsageRatio(balancePiasters: 50000, limitPiasters: 0),
        equals(0.0),
      );
    });

    test('returns 0.0 when balance is non-positive', () {
      expect(
        CreditLimitUtils.getUsageRatio(balancePiasters: 0, limitPiasters: 50000),
        equals(0.0),
      );
      expect(
        CreditLimitUtils.getUsageRatio(balancePiasters: -1000, limitPiasters: 50000),
        equals(0.0),
      );
    });
  });

  group('CreditLimitUtils.getStatus threshold logic (< 80%, 80-100%, > 100%)', () {
    const limit = 100000; // 1,000 EGP

    test('returns none when limit is null', () {
      expect(
        CreditLimitUtils.getStatus(balancePiasters: 50000, limitPiasters: null),
        equals(CreditLimitStatus.none),
      );
    });

    test('returns safe when balance is below 80% of limit', () {
      // 0%
      expect(
        CreditLimitUtils.getStatus(balancePiasters: 0, limitPiasters: limit),
        equals(CreditLimitStatus.safe),
      );
      // 50% (500 EGP)
      expect(
        CreditLimitUtils.getStatus(balancePiasters: 50000, limitPiasters: limit),
        equals(CreditLimitStatus.safe),
      );
      // 79.9% (799 EGP)
      expect(
        CreditLimitUtils.getStatus(balancePiasters: 79900, limitPiasters: limit),
        equals(CreditLimitStatus.safe),
      );
    });

    test('returns warning when balance is between 80% and 100%', () {
      // Exactly 80% (800 EGP)
      expect(
        CreditLimitUtils.getStatus(balancePiasters: 80000, limitPiasters: limit),
        equals(CreditLimitStatus.warning),
      );
      // 90% (900 EGP)
      expect(
        CreditLimitUtils.getStatus(balancePiasters: 90000, limitPiasters: limit),
        equals(CreditLimitStatus.warning),
      );
      // Exactly 100% (1,000 EGP)
      expect(
        CreditLimitUtils.getStatus(balancePiasters: 100000, limitPiasters: limit),
        equals(CreditLimitStatus.warning),
      );
    });

    test('returns exceeded when balance is strictly greater than 100%', () {
      // 100.01% (1,000.10 EGP)
      expect(
        CreditLimitUtils.getStatus(balancePiasters: 100010, limitPiasters: limit),
        equals(CreditLimitStatus.exceeded),
      );
      // 150% (1,500 EGP)
      expect(
        CreditLimitUtils.getStatus(balancePiasters: 150000, limitPiasters: limit),
        equals(CreditLimitStatus.exceeded),
      );
    });
  });
}
