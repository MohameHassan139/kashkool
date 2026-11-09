import 'package:intl/intl.dart';
import '../../../core/db/app_database.dart';
import '../domain/statement_filter.dart';
import '../domain/statement_row.dart';
import '../../../l10n/l10n.dart';

/// Calculation result containing statement rows and summary balances.
class StatementResult {
  final List<StatementRow> rows;
  final int openingBalancePiasters;
  final int periodDebitsPiasters;
  final int periodCreditsPiasters;
  final int finalBalancePiasters;
  final String periodDescription;

  const StatementResult({
    required this.rows,
    required this.openingBalancePiasters,
    required this.periodDebitsPiasters,
    required this.periodCreditsPiasters,
    required this.finalBalancePiasters,
    required this.periodDescription,
  });
}

/// Computes running balances and filters transactions for customer statements.
abstract final class StatementCalculator {
  /// Computes chronological running balance and filters by period.
  static StatementResult compute({
    required List<Transaction> allTransactions,
    StatementPeriod period = StatementPeriod.allTime,
    DateTime? customStart,
    DateTime? customEnd,
    DateTime? now,
  }) {
    final currentTime = now ?? DateTime.now();

    // 1. Sort all active transactions chronologically (oldest first)
    final sortedTxs = List<Transaction>.from(allTransactions)
      ..sort((a, b) => a.occurredAt.compareTo(b.occurredAt));

    DateTime? startDate;
    DateTime? endDate;
    String periodDesc;

    switch (period) {
      case StatementPeriod.allTime:
        periodDesc = L10n.t.statementCalculator1;
        break;

      case StatementPeriod.thisMonth:
        startDate = DateTime(currentTime.year, currentTime.month, 1);
        endDate = DateTime(currentTime.year, currentTime.month + 1, 0, 23, 59, 59);
        final arabicMonths = [
          L10n.t.statementCalculator2, L10n.t.statementCalculator3, L10n.t.statementCalculator4, L10n.t.statementCalculator5, L10n.t.statementCalculator6, L10n.t.statementCalculator7,
          L10n.t.statementCalculator8, L10n.t.statementCalculator9, L10n.t.statementCalculator10, L10n.t.statementCalculator11, L10n.t.statementCalculator12, L10n.t.statementCalculator13
        ];
        periodDesc = '${arabicMonths[currentTime.month - 1]} ${currentTime.year}';
        break;

      case StatementPeriod.custom:
        startDate = customStart != null
            ? DateTime(customStart.year, customStart.month, customStart.day, 0, 0, 0)
            : null;
        endDate = customEnd != null
            ? DateTime(customEnd.year, customEnd.month, customEnd.day, 23, 59, 59)
            : null;

        final dFmt = DateFormat('yyyy/MM/dd');
        if (startDate != null && endDate != null) {
          periodDesc = L10n.t.statementCalculator14(dFmt.format(startDate), dFmt.format(endDate));
        } else if (startDate != null) {
          periodDesc = L10n.t.statementCalculator15(dFmt.format(startDate));
        } else if (endDate != null) {
          periodDesc = L10n.t.statementCalculator16(dFmt.format(endDate));
        } else {
          periodDesc = L10n.t.statementCalculator1;
        }
        break;
    }

    var runningBalance = 0;
    var openingBalance = 0;
    var periodDebits = 0;
    var periodCredits = 0;

    final List<StatementRow> rows = [];

    for (final tx in sortedTxs) {
      final isDebt = tx.type == TransactionType.debt;
      final amount = tx.amountPiasters;

      // Check if transaction is before the period starts
      if (startDate != null && tx.occurredAt.isBefore(startDate)) {
        if (isDebt) {
          runningBalance += amount;
          openingBalance += amount;
        } else {
          runningBalance -= amount;
          openingBalance -= amount;
        }
        continue;
      }

      // Check if transaction is after the period ends
      if (endDate != null && tx.occurredAt.isAfter(endDate)) {
        break;
      }

      // Transaction is within the period
      final int debt = isDebt ? amount : 0;
      final int payment = !isDebt ? amount : 0;

      if (isDebt) {
        runningBalance += amount;
        periodDebits += amount;
      } else {
        runningBalance -= amount;
        periodCredits += amount;
      }

      rows.add(
        StatementRow(
          transaction: tx,
          debtPiasters: debt,
          paymentPiasters: payment,
          runningBalancePiasters: runningBalance,
        ),
      );
    }

    return StatementResult(
      rows: rows,
      openingBalancePiasters: openingBalance,
      periodDebitsPiasters: periodDebits,
      periodCreditsPiasters: periodCredits,
      finalBalancePiasters: runningBalance,
      periodDescription: periodDesc,
    );
  }
}
