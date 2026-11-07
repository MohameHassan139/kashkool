import '../../../core/db/app_database.dart';
import 'installment_calculator.dart';

/// Rich composite domain model representing an installment plan with its customer and scheduled installments.
class InstallmentPlanWithDetails {
  final InstallmentPlan plan;
  final Customer customer;
  final List<Installment> installments;

  const InstallmentPlanWithDetails({
    required this.plan,
    required this.customer,
    required this.installments,
  });

  /// Total sum of all payments made towards installments (excluding down payment).
  int get totalInstallmentsPaidPiasters {
    return installments.fold<int>(0, (sum, inst) => sum + inst.paidPiasters);
  }

  /// Total paid including the initial down payment.
  int get totalPaidWithDownPaymentPiasters {
    return plan.downPaymentPiasters + totalInstallmentsPaidPiasters;
  }

  /// Remaining unpaid balance for this plan in piasters.
  int get remainingPiasters {
    return InstallmentCalculator.calculateRemainingPiasters(
      totalPricePiasters: plan.totalPricePiasters,
      downPaymentPiasters: plan.downPaymentPiasters,
      totalPaidPiasters: totalInstallmentsPaidPiasters,
    );
  }

  /// Number of fully paid installments.
  int get paidInstallmentsCount {
    return installments.where((inst) => inst.paidPiasters >= inst.amountPiasters).length;
  }

  /// Total number of installments.
  int get totalInstallmentsCount => plan.installmentCount;

  /// Progress percentage (0.0 to 1.0) based on amount paid vs total.
  double get progressPercentage {
    if (plan.totalPricePiasters <= 0) return 1.0;
    final progress = totalPaidWithDownPaymentPiasters / plan.totalPricePiasters;
    return progress.clamp(0.0, 1.0);
  }

  /// Whether the plan is fully paid and completed.
  bool get isFullyPaid => remainingPiasters <= 0;

  /// Whether any unpaid installment is past its due date.
  bool get hasOverdue {
    final now = DateTime.now();
    return installments.any(
      (inst) => InstallmentCalculator.isOverdue(
        dueDate: inst.dueDate,
        amountPiasters: inst.amountPiasters,
        paidPiasters: inst.paidPiasters,
        now: now,
      ),
    );
  }

  /// Number of overdue installments.
  int get overdueCount {
    final now = DateTime.now();
    return installments
        .where(
          (inst) => InstallmentCalculator.isOverdue(
            dueDate: inst.dueDate,
            amountPiasters: inst.amountPiasters,
            paidPiasters: inst.paidPiasters,
            now: now,
          ),
        )
        .length;
  }

  /// Finds the next upcoming or unpaid installment.
  Installment? get nextDueInstallment {
    final unpaid = installments.where((inst) => inst.paidPiasters < inst.amountPiasters).toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return unpaid.isNotEmpty ? unpaid.first : null;
  }
}
