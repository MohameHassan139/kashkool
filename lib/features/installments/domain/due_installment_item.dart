import '../../../core/db/app_database.dart';
import 'installment_calculator.dart';

/// Domain item representing an installment due today or overdue, used in collections and reminders.
class DueInstallmentItem {
  final Installment installment;
  final InstallmentPlan plan;
  final Customer customer;

  const DueInstallmentItem({
    required this.installment,
    required this.plan,
    required this.customer,
  });

  /// Remaining unpaid piasters for this specific installment.
  int get remainingForInstallmentPiasters {
    final rem = installment.amountPiasters - installment.paidPiasters;
    return rem < 0 ? 0 : rem;
  }

  /// Whether this installment is overdue.
  bool get isOverdue {
    return InstallmentCalculator.isOverdue(
      dueDate: installment.dueDate,
      amountPiasters: installment.amountPiasters,
      paidPiasters: installment.paidPiasters,
    );
  }

  /// Whether this installment is due today.
  bool get isDueToday {
    return InstallmentCalculator.isDueToday(
      dueDate: installment.dueDate,
      amountPiasters: installment.amountPiasters,
      paidPiasters: installment.paidPiasters,
    );
  }

  /// Days overdue (0 if due today or upcoming).
  int get daysOverdue {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final dueDayStart = DateTime(installment.dueDate.year, installment.dueDate.month, installment.dueDate.day);
    final diff = todayStart.difference(dueDayStart).inDays;
    return diff > 0 ? diff : 0;
  }
}
