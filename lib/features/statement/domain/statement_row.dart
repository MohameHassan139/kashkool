import '../../../core/db/app_database.dart';

/// Single chronological row in a customer's statement of account.
class StatementRow {
  final Transaction transaction;

  /// Amount added to debt in piasters (0 if payment)
  final int debtPiasters;

  /// Amount paid by customer in piasters (0 if debt)
  final int paymentPiasters;

  /// Running balance in piasters immediately after this transaction
  final int runningBalancePiasters;

  const StatementRow({
    required this.transaction,
    required this.debtPiasters,
    required this.paymentPiasters,
    required this.runningBalancePiasters,
  });

  bool get isDebt => debtPiasters > 0;
  bool get isPayment => paymentPiasters > 0;
}
