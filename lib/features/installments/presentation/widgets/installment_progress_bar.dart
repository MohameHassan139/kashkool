import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/money.dart';

/// Visual progress indicator for installment repayment.
class InstallmentProgressBar extends StatelessWidget {
  final int paidCount;
  final int totalCount;
  final int remainingPiasters;
  final double progressPercentage;
  final bool isOverdue;

  const InstallmentProgressBar({
    super.key,
    required this.paidCount,
    required this.totalCount,
    required this.remainingPiasters,
    required this.progressPercentage,
    this.isOverdue = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentInt = (progressPercentage * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'سداد $paidCount من $totalCount قسط ($percentInt%)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                remainingPiasters > 0
                    ? 'باقي: ${MoneyUtils.formatMoney(remainingPiasters)}'
                    : 'خالص بالكامل ✓',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: remainingPiasters > 0
                      ? (isOverdue ? AppColors.debtRed : AppColors.primaryGreen)
                      : AppColors.primaryGreen,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progressPercentage,
            minHeight: 8,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(
              progressPercentage >= 1.0
                  ? AppColors.primaryGreen
                  : (isOverdue ? AppColors.warningAmber : AppColors.primaryGreen),
            ),
          ),
        ),
      ],
    );
  }
}
