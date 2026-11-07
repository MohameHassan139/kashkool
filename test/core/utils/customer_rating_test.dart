import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/utils/customer_rating.dart';

void main() {
  final now = DateTime(2026, 11, 6, 12, 0);

  Transaction makeTx({
    required String id,
    required TransactionType type,
    required int amountPiasters,
    required DateTime occurredAt,
  }) {
    return Transaction(
      id: id,
      shopId: 'shop-1',
      deviceId: 'dev-1',
      createdBy: 'user-1',
      partyType: PartyType.customer,
      partyId: 'cust-1',
      type: type,
      amountPiasters: amountPiasters,
      occurredAt: occurredAt,
      createdAt: occurredAt,
      updatedAt: occurredAt,
    );
  }

  group('CustomerRatingUtils FIFO analysis', () {
    test('assigns newCustomer badge when customer has less than 3 transactions', () {
      final txs = [
        makeTx(
          id: '1',
          type: TransactionType.debt,
          amountPiasters: 5000,
          occurredAt: now.subtract(const Duration(days: 60)),
        ),
      ];

      final result = CustomerRatingUtils.compute(
        transactions: txs,
        balancePiasters: 5000,
        creditLimitPiasters: null,
        now: now,
      );

      expect(result.badge, equals(RatingBadge.newCustomer));
    });

    test('assigns good badge when balance is settled or negative (overpaid)', () {
      final txs = [
        makeTx(
          id: '1',
          type: TransactionType.debt,
          amountPiasters: 5000,
          occurredAt: now.subtract(const Duration(days: 60)),
        ),
        makeTx(
          id: '2',
          type: TransactionType.debt,
          amountPiasters: 3000,
          occurredAt: now.subtract(const Duration(days: 50)),
        ),
        makeTx(
          id: '3',
          type: TransactionType.payment,
          amountPiasters: 8000,
          occurredAt: now.subtract(const Duration(days: 1)),
        ),
      ];

      final result = CustomerRatingUtils.compute(
        transactions: txs,
        balancePiasters: 0,
        creditLimitPiasters: null,
        now: now,
      );

      expect(result.badge, equals(RatingBadge.good));
      expect(result.oldestUnpaidAgeDays, equals(0));
    });

    test('assigns good badge when oldest unpaid debt is <= 14 days old', () {
      final txs = [
        makeTx(
          id: '1',
          type: TransactionType.debt,
          amountPiasters: 5000,
          occurredAt: now.subtract(const Duration(days: 10)),
        ),
        makeTx(
          id: '2',
          type: TransactionType.debt,
          amountPiasters: 2000,
          occurredAt: now.subtract(const Duration(days: 5)),
        ),
        makeTx(
          id: '3',
          type: TransactionType.payment,
          amountPiasters: 1000,
          occurredAt: now.subtract(const Duration(days: 1)),
        ),
      ];

      final result = CustomerRatingUtils.compute(
        transactions: txs,
        balancePiasters: 6000,
        creditLimitPiasters: null,
        now: now,
      );

      expect(result.badge, equals(RatingBadge.good));
      expect(result.oldestUnpaidAgeDays, equals(10));
    });

    test('FIFO: past payments settle oldest debts first and reveal correct oldest unpaid age', () {
      final txs = [
        // Debt 1: 50 EGP, 50 days ago (Old)
        makeTx(
          id: '1',
          type: TransactionType.debt,
          amountPiasters: 5000,
          occurredAt: now.subtract(const Duration(days: 50)),
        ),
        // Debt 2: 30 EGP, 10 days ago (Recent)
        makeTx(
          id: '2',
          type: TransactionType.debt,
          amountPiasters: 3000,
          occurredAt: now.subtract(const Duration(days: 10)),
        ),
        // Payment: 50 EGP (fully covers Debt 1!)
        makeTx(
          id: '3',
          type: TransactionType.payment,
          amountPiasters: 5000,
          occurredAt: now.subtract(const Duration(days: 2)),
        ),
      ];

      // Total balance is 30 EGP (Debt 2 only)
      final result = CustomerRatingUtils.compute(
        transactions: txs,
        balancePiasters: 3000,
        creditLimitPiasters: null,
        now: now,
      );

      // Since Debt 1 was completely settled, oldest unpaid debt is Debt 2 (10 days old <= 14) -> Good!
      expect(result.badge, equals(RatingBadge.good));
      expect(result.oldestUnpaidAgeDays, equals(10));
    });

    test('FIFO: partial payment leaving old debt unsettled flags customer as late', () {
      final txs = [
        // Debt 1: 50 EGP, 50 days ago
        makeTx(
          id: '1',
          type: TransactionType.debt,
          amountPiasters: 5000,
          occurredAt: now.subtract(const Duration(days: 50)),
        ),
        // Debt 2: 30 EGP, 10 days ago
        makeTx(
          id: '2',
          type: TransactionType.debt,
          amountPiasters: 3000,
          occurredAt: now.subtract(const Duration(days: 10)),
        ),
        // Payment: only 20 EGP (leaves 30 EGP of Debt 1 unpaid)
        makeTx(
          id: '3',
          type: TransactionType.payment,
          amountPiasters: 2000,
          occurredAt: now.subtract(const Duration(days: 2)),
        ),
      ];

      final result = CustomerRatingUtils.compute(
        transactions: txs,
        balancePiasters: 6000,
        creditLimitPiasters: null,
        now: now,
      );

      // Oldest unpaid debt is still Debt 1 (50 days old > 45 days) -> Late!
      expect(result.badge, equals(RatingBadge.late));
      expect(result.oldestUnpaidAgeDays, equals(50));
    });

    test('assigns late badge when credit limit is exceeded even if debt is fresh', () {
      final txs = [
        makeTx(
          id: '1',
          type: TransactionType.debt,
          amountPiasters: 120000, // 1,200 EGP
          occurredAt: now.subtract(const Duration(days: 2)),
        ),
        makeTx(
          id: '2',
          type: TransactionType.debt,
          amountPiasters: 10000,
          occurredAt: now.subtract(const Duration(days: 1)),
        ),
        makeTx(
          id: '3',
          type: TransactionType.payment,
          amountPiasters: 10000,
          occurredAt: now,
        ),
      ];

      final result = CustomerRatingUtils.compute(
        transactions: txs,
        balancePiasters: 120000, // 1,200 EGP
        creditLimitPiasters: 100000, // 1,000 EGP limit
        now: now,
      );

      expect(result.badge, equals(RatingBadge.late));
      expect(result.explanation, contains('تعدى حد الدين'));
    });

    test('assigns watch badge when oldest debt is between 15 and 45 days old', () {
      final txs = [
        makeTx(
          id: '1',
          type: TransactionType.debt,
          amountPiasters: 4000,
          occurredAt: now.subtract(const Duration(days: 25)),
        ),
        makeTx(
          id: '2',
          type: TransactionType.debt,
          amountPiasters: 1000,
          occurredAt: now.subtract(const Duration(days: 5)),
        ),
        makeTx(
          id: '3',
          type: TransactionType.payment,
          amountPiasters: 1000,
          occurredAt: now,
        ),
      ];

      final result = CustomerRatingUtils.compute(
        transactions: txs,
        balancePiasters: 4000,
        creditLimitPiasters: null,
        now: now,
      );

      expect(result.badge, equals(RatingBadge.watch));
      expect(result.oldestUnpaidAgeDays, equals(25));
    });
  });
}
