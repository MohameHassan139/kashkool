import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/statement/data/pdf_statement_service.dart';
import 'package:kashkool/features/statement/data/statement_calculator.dart';
import 'package:kashkool/features/statement/domain/statement_filter.dart';

void main() {
  Transaction makeTx({
    required String id,
    required TransactionType type,
    required int amountPiasters,
    required DateTime occurredAt,
    String? note,
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
      note: note,
      occurredAt: occurredAt,
      createdAt: occurredAt,
      updatedAt: occurredAt,
    );
  }

  group('StatementCalculator running balance and filtering', () {
    test('computes running balance chronologically (Debt adds, Payment subtracts)', () {
      final txs = [
        makeTx(
          id: 'tx-1',
          type: TransactionType.debt,
          amountPiasters: 100000, // +1,000 EGP
          occurredAt: DateTime(2026, 1, 1),
          note: 'بضاعة أول المدة',
        ),
        makeTx(
          id: 'tx-2',
          type: TransactionType.payment,
          amountPiasters: 40000, // -400 EGP -> balance 600
          occurredAt: DateTime(2026, 1, 5),
          note: 'سداد نقدي',
        ),
        makeTx(
          id: 'tx-3',
          type: TransactionType.debt,
          amountPiasters: 25000, // +250 EGP -> balance 850
          occurredAt: DateTime(2026, 1, 10),
          note: 'طلبات إضافية',
        ),
      ];

      final result = StatementCalculator.compute(
        allTransactions: txs,
        period: StatementPeriod.allTime,
      );

      expect(result.rows.length, equals(3));
      expect(result.openingBalancePiasters, equals(0));

      expect(result.rows[0].debtPiasters, equals(100000));
      expect(result.rows[0].paymentPiasters, equals(0));
      expect(result.rows[0].runningBalancePiasters, equals(100000));

      expect(result.rows[1].debtPiasters, equals(0));
      expect(result.rows[1].paymentPiasters, equals(40000));
      expect(result.rows[1].runningBalancePiasters, equals(60000));

      expect(result.rows[2].debtPiasters, equals(25000));
      expect(result.rows[2].paymentPiasters, equals(0));
      expect(result.rows[2].runningBalancePiasters, equals(85000));

      expect(result.periodDebitsPiasters, equals(125000)); // 1,000 + 250 = 1,250 EGP
      expect(result.periodCreditsPiasters, equals(40000)); // 400 EGP
      expect(result.finalBalancePiasters, equals(85000)); // 850 EGP
    });

    test('period filtering accumulates prior transactions into opening balance', () {
      final txs = [
        // Before current month (in October 2026)
        makeTx(
          id: 'tx-1',
          type: TransactionType.debt,
          amountPiasters: 50000, // +500 EGP
          occurredAt: DateTime(2026, 10, 15),
        ),
        makeTx(
          id: 'tx-2',
          type: TransactionType.payment,
          amountPiasters: 20000, // -200 EGP -> Oct final balance = 300 EGP
          occurredAt: DateTime(2026, 10, 20),
        ),
        // In current month (November 2026)
        makeTx(
          id: 'tx-3',
          type: TransactionType.debt,
          amountPiasters: 40000, // +400 EGP -> balance 700 EGP
          occurredAt: DateTime(2026, 11, 2),
        ),
        makeTx(
          id: 'tx-4',
          type: TransactionType.payment,
          amountPiasters: 10000, // -100 EGP -> balance 600 EGP
          occurredAt: DateTime(2026, 11, 5),
        ),
      ];

      final now = DateTime(2026, 11, 6);
      final result = StatementCalculator.compute(
        allTransactions: txs,
        period: StatementPeriod.thisMonth,
        now: now,
      );

      // Opening balance must be 30,000 piasters (300 EGP)
      expect(result.openingBalancePiasters, equals(30000));

      // Rows only contain November transactions (tx-3 and tx-4)
      expect(result.rows.length, equals(2));
      expect(result.rows[0].transaction.id, equals('tx-3'));
      expect(result.rows[0].runningBalancePiasters, equals(70000)); // 300 + 400 = 700 EGP

      expect(result.rows[1].transaction.id, equals('tx-4'));
      expect(result.rows[1].runningBalancePiasters, equals(60000)); // 700 - 100 = 600 EGP

      expect(result.periodDebitsPiasters, equals(40000));
      expect(result.periodCreditsPiasters, equals(10000));
      expect(result.finalBalancePiasters, equals(60000));
    });

    test('custom date range filters correctly', () {
      final txs = [
        makeTx(id: '1', type: TransactionType.debt, amountPiasters: 10000, occurredAt: DateTime(2026, 5, 1)),
        makeTx(id: '2', type: TransactionType.debt, amountPiasters: 20000, occurredAt: DateTime(2026, 5, 10)),
        makeTx(id: '3', type: TransactionType.payment, amountPiasters: 5000, occurredAt: DateTime(2026, 5, 20)),
        makeTx(id: '4', type: TransactionType.debt, amountPiasters: 30000, occurredAt: DateTime(2026, 6, 1)),
      ];

      final result = StatementCalculator.compute(
        allTransactions: txs,
        period: StatementPeriod.custom,
        customStart: DateTime(2026, 5, 5),
        customEnd: DateTime(2026, 5, 25),
      );

      // Opening balance: tx 1 (10,000)
      expect(result.openingBalancePiasters, equals(10000));
      // In range: tx 2 & tx 3
      expect(result.rows.length, equals(2));
      expect(result.rows[0].transaction.id, equals('2'));
      expect(result.rows[1].transaction.id, equals('3'));
      expect(result.finalBalancePiasters, equals(25000)); // 10,000 + 20,000 - 5,000
    });

    test('processes 500 transactions in under 100 milliseconds', () {
      final txs = List.generate(500, (i) {
        return makeTx(
          id: 'tx-$i',
          type: i.isEven ? TransactionType.debt : TransactionType.payment,
          amountPiasters: (i + 1) * 100,
          occurredAt: DateTime(2026, 1, 1).add(Duration(hours: i)),
        );
      });

      final stopwatch = Stopwatch()..start();
      final result = StatementCalculator.compute(
        allTransactions: txs,
        period: StatementPeriod.allTime,
      );
      stopwatch.stop();

      expect(result.rows.length, equals(500));
      expect(stopwatch.elapsedMilliseconds, lessThan(100));
    });

    test('builds sanitized file name with Arabic support', () {
      final fileName = PdfStatementService.buildFileName(
        '  أحمد علي & محمود!  ',
        date: DateTime(2026, 11, 6),
      );

      expect(fileName, equals('كشف_حساب_أحمد_علي_محمود_2026-11-06.pdf'));
    });
  });
}
