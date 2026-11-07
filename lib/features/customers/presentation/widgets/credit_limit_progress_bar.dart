import 'package:flutter/material.dart';
import '../../../../core/utils/credit_limit.dart';
import '../../../../core/utils/money.dart';

/// Progress bar visualizing a customer's balance against their credit limit.
/// Color transitions:
/// - < 80% -> Neutral grey/blue
/// - 80%–100% -> Warning amber
/// - > 100% -> Exceeded red
class CreditLimitProgressBar extends StatelessWidget {
  final int balancePiasters;
  final int? limitPiasters;
  final bool showLabel;

  const CreditLimitProgressBar({
    super.key,
    required this.balancePiasters,
    required this.limitPiasters,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    if (limitPiasters == null || limitPiasters! <= 0) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final status = CreditLimitUtils.getStatus(
      balancePiasters: balancePiasters,
      limitPiasters: limitPiasters,
    );
    final color = CreditLimitUtils.getStatusColor(status, isDark: isDark);
    final rawRatio = CreditLimitUtils.getUsageRatio(
      balancePiasters: balancePiasters,
      limitPiasters: limitPiasters,
    );
    final clampedProgress = rawRatio.clamp(0.0, 1.0);
    final percentInt = (rawRatio * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'حد الدين: ${MoneyUtils.formatMoney(limitPiasters!)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$percentInt%',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: clampedProgress,
            minHeight: showLabel ? 6 : 4,
            backgroundColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
