import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../data/installment_repository.dart';
import '../domain/due_installment_item.dart';
import '../domain/installment_plan_with_details.dart';

/// Provider for searching installment plans (by customer, phone, item, guarantor).
final installmentSearchQueryProvider = StateProvider<String>((ref) => '');

/// Provider for filtering installment plans by status (null = All, active, completed, cancelled).
final installmentStatusFilterProvider = StateProvider<PlanStatus?>((ref) => null);

/// Stream provider for all installment plans with live filtering and search.
final allInstallmentsStreamProvider = StreamProvider.autoDispose<List<InstallmentPlanWithDetails>>((ref) {
  final repo = ref.watch(installmentRepositoryProvider);
  final status = ref.watch(installmentStatusFilterProvider);
  final query = ref.watch(installmentSearchQueryProvider);

  return repo.watchAllPlans(statusFilter: status, searchQuery: query);
});

/// Stream provider for a specific customer's installment plans.
final customerInstallmentPlansStreamProvider =
    StreamProvider.family.autoDispose<List<InstallmentPlanWithDetails>, String>((ref, customerId) {
  final repo = ref.watch(installmentRepositoryProvider);
  return repo.watchPlansForCustomer(customerId);
});

/// Stream provider for a single plan with its scheduled installments.
final installmentPlanDetailsStreamProvider =
    StreamProvider.family.autoDispose<InstallmentPlanWithDetails?, String>((ref, planId) {
  final repo = ref.watch(installmentRepositoryProvider);
  return repo.watchPlanWithDetails(planId);
});

/// Stream provider for installments due today or overdue.
final dueInstallmentsStreamProvider = StreamProvider.autoDispose<List<DueInstallmentItem>>((ref) {
  final repo = ref.watch(installmentRepositoryProvider);
  return repo.watchDueInstallments();
});

/// Aggregate summary statistics for Installments header.
class InstallmentSummaryStats {
  final int totalActivePlans;
  final int totalRemainingDebtPiasters;
  final int totalOverdueInstallmentsCount;
  final int totalCollectedPiasters;

  const InstallmentSummaryStats({
    required this.totalActivePlans,
    required this.totalRemainingDebtPiasters,
    required this.totalOverdueInstallmentsCount,
    required this.totalCollectedPiasters,
  });
}

/// Stream provider for installment summary statistics.
final installmentSummaryStatsStreamProvider = StreamProvider.autoDispose<InstallmentSummaryStats>((ref) {
  final repo = ref.watch(installmentRepositoryProvider);

  return repo.watchAllPlans().map((plans) {
    int activeCount = 0;
    int remainingDebt = 0;
    int overdueCount = 0;
    int collected = 0;

    for (final p in plans) {
      if (p.plan.status == PlanStatus.active) {
        activeCount++;
        remainingDebt += p.remainingPiasters;
        overdueCount += p.overdueCount;
      }
      collected += p.totalPaidWithDownPaymentPiasters;
    }

    return InstallmentSummaryStats(
      totalActivePlans: activeCount,
      totalRemainingDebtPiasters: remainingDebt,
      totalOverdueInstallmentsCount: overdueCount,
      totalCollectedPiasters: collected,
    );
  });
});
