import '../../../core/db/app_database.dart';
import '../../../core/utils/customer_rating.dart';
import '../../../l10n/l10n.dart';

/// Presentation/Domain model combining customer entity with real-time computed financial balance and rating.
class CustomerWithBalance {
  final Customer customer;

  /// Computed running balance in integer piasters (Σ debt − Σ payment).
  /// Positive (> 0): Customer owes money to the shop ("عليه").
  /// Zero (== 0): Customer has settled balance ("خالص").
  /// Negative (< 0): Customer has overpaid / credit at the shop ("له").
  final int balancePiasters;

  /// Timestamp of the latest recorded transaction
  final DateTime? lastTransactionAt;

  /// Total count of active transactions for this customer
  final int transactionCount;

  /// Real-time computed customer rating badge and explanation
  final CustomerRatingResult? _rating;

  CustomerRatingResult get rating =>
      _rating ?? CustomerRatingResult(badge: RatingBadge.newCustomer, explanation: L10n.t.customerWithBalance1);

  const CustomerWithBalance({
    required this.customer,
    required this.balancePiasters,
    this.lastTransactionAt,
    this.transactionCount = 0,
    CustomerRatingResult? rating,
  }) : _rating = rating;

  bool get hasDebt => balancePiasters > 0;
  bool get isSettled => balancePiasters == 0;
  bool get hasCredit => balancePiasters < 0;

  /// Whether the customer has exceeded their credit limit
  bool get isCreditLimitExceeded {
    final limit = customer.creditLimitPiasters;
    if (limit == null || limit <= 0) return false;
    return balancePiasters > limit;
  }
}
