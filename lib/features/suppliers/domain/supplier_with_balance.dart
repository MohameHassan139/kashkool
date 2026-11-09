import '../../../core/db/app_database.dart';
import '../../../l10n/l10n.dart';

/// Presentation/Domain model combining supplier entity with real-time computed financial balance.
class SupplierWithBalance {
  final Supplier supplier;

  /// Computed running balance in integer piasters (Σ debt − Σ payment).
  /// Positive (> 0): Shop owes money to the supplier ("عليّا").
  /// Zero (== 0): Settled ("خالصين").
  /// Negative (< 0): Shop has overpaid ("دافع زيادة / ليا رصيد عنده").
  final int balancePiasters;

  /// Timestamp of the latest recorded transaction
  final DateTime? lastTransactionAt;

  /// Total count of active transactions for this supplier
  final int transactionCount;

  const SupplierWithBalance({
    required this.supplier,
    required this.balancePiasters,
    this.lastTransactionAt,
    this.transactionCount = 0,
  });

  bool get hasDebt => balancePiasters > 0;
  bool get isSettled => balancePiasters == 0;
  bool get hasCredit => balancePiasters < 0;

  /// Arabic name of the weekday when representative visits (0: Sat .. 6: Fri)
  static String? getWeekdayName(int? dayIndex) {
    if (dayIndex == null) return null;
    switch (dayIndex) {
      case 0:
        return L10n.t.supplierWithBalance1;
      case 1:
        return L10n.t.supplierWithBalance2;
      case 2:
        return L10n.t.supplierWithBalance3;
      case 3:
        return L10n.t.supplierWithBalance4;
      case 4:
        return L10n.t.supplierWithBalance5;
      case 5:
        return L10n.t.supplierWithBalance6;
      case 6:
        return L10n.t.supplierWithBalance7;
      default:
        return null;
    }
  }

  String? get visitDayLabel => getWeekdayName(supplier.visitDay);
}
