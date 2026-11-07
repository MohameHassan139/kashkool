import '../../../core/db/app_database.dart';

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
        return 'السبت';
      case 1:
        return 'الأحد';
      case 2:
        return 'الإثنين';
      case 3:
        return 'الثلاثاء';
      case 4:
        return 'الأربعاء';
      case 5:
        return 'الخميس';
      case 6:
        return 'الجمعة';
      default:
        return null;
    }
  }

  String? get visitDayLabel => getWeekdayName(supplier.visitDay);
}
