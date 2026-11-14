import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/db/app_database.dart';
import '../../../../core/utils/money.dart';
import '../../domain/installment_plan_with_details.dart';
import 'installment_progress_bar.dart';
import '../../../../l10n/l10n.dart';

/// Card item displaying an installment plan in lists.
class InstallmentPlanCard extends StatelessWidget {
  final InstallmentPlanWithDetails item;
  final VoidCallback onTap;

  const InstallmentPlanCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat('yyyy/MM/dd');

    final plan = item.plan;
    final customer = item.customer;
    final isCompleted = plan.status == PlanStatus.completed || item.isFullyPaid;
    final isCancelled = plan.status == PlanStatus.cancelled;
    final hasOverdue = item.hasOverdue && !isCompleted && !isCancelled;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: hasOverdue
              ? AppColors.debtRed.withValues(alpha: 0.6)
              : (isCompleted
                  ? AppColors.primaryGreen.withValues(alpha: 0.4)
                  : theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
          width: hasOverdue ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header: Item name + Status / Overdue Badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: hasOverdue
                          ? AppColors.debtRed.withValues(alpha: 0.12)
                          : (isCompleted
                              ? AppColors.primaryGreen.withValues(alpha: 0.12)
                              : theme.colorScheme.primaryContainer.withValues(alpha: 0.5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.receipt_long_rounded,
                      color: hasOverdue
                          ? AppColors.debtRed
                          : (isCompleted ? AppColors.primaryGreen : theme.colorScheme.primary),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.itemDescription,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          customer.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (hasOverdue)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.debtRed.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        L10n.t.installmentPlanCard1(item.overdueCount),
                        style: const TextStyle(
                          color: AppColors.debtRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  else if (isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        L10n.t.installmentPlanCard2,
                        style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  else if (isCancelled)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        L10n.t.installmentPlanCard3,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),

              // Progress Bar
              InstallmentProgressBar(
                paidCount: item.paidInstallmentsCount,
                totalCount: item.totalInstallmentsCount,
                remainingPiasters: item.remainingPiasters,
                progressPercentage: item.progressPercentage,
                isOverdue: hasOverdue,
              ),
              const SizedBox(height: 12),

              // Footer row: Next Due / Details
              Row(
                children: [
                  Expanded(
                    child: (!isCompleted && !isCancelled && item.nextDueInstallment != null)
                        ? Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  L10n.t.installmentPlanCard4(dateFmt.format(item.nextDueInstallment!.dueDate), MoneyUtils.formatMoney(item.nextDueInstallment!.amountPiasters - item.nextDueInstallment!.paidPiasters)),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            L10n.t.installmentPlanCard5(MoneyUtils.formatMoney(plan.totalPricePiasters)),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_left_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
