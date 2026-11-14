import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/money.dart';
import '../../../l10n/l10n.dart';
import '../data/reports_repository.dart';
import '../domain/profit_loss_report.dart';

class ProfitLossScreen extends ConsumerWidget {
  const ProfitLossScreen({super.key});

  String _periodLabel(ReportPeriod period) {
    switch (period) {
      case ReportPeriod.today:
        return L10n.t.profitLossPeriodToday;
      case ReportPeriod.last7Days:
        return L10n.t.profitLossPeriodWeek;
      case ReportPeriod.thisMonth:
        return L10n.t.profitLossPeriodMonth;
      case ReportPeriod.allTime:
        return L10n.t.profitLossPeriodAll;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(profitLossReportStreamProvider);
    final selectedPeriod = ref.watch(selectedProfitLossPeriodProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.t.profitLossTitle),
      ),
      body: Column(
        children: [
          // Period Selector Chips
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: ReportPeriod.values.map((period) {
                  final isSelected = selectedPeriod == period;
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: ChoiceChip(
                      selected: isSelected,
                      label: Text(_periodLabel(period)),
                      onSelected: (_) {
                        ref
                            .read(selectedProfitLossPeriodProvider.notifier)
                            .state = period;
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: reportAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('خطأ: $err')),
              data: (report) {
                final isNetPositive = report.netProfitPiasters >= 0;
                final netColor = isNetPositive
                    ? AppColors.paymentGreen
                    : AppColors.debtRed;

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Main Net Profit/Loss Card
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: netColor.withValues(alpha: 0.4),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isNetPositive
                                    ? Icons.trending_up_rounded
                                    : Icons.trending_down_rounded,
                                color: netColor,
                                size: 28,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isNetPositive
                                    ? L10n.t.profitLossPositive
                                    : L10n.t.profitLossNegative,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: netColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            MoneyUtils.formatMoney(report.netProfitPiasters.abs()),
                            style: theme.textTheme.displaySmall?.copyWith(
                              color: netColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: netColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${L10n.t.profitLossMargin}: ${report.profitMarginPercentage.toStringAsFixed(1)}%',
                              style: TextStyle(
                                color: netColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Financial Breakdown
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'تفاصيل الحسابات',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(height: 24),
                            _buildRow(
                              context,
                              icon: Icons.point_of_sale_rounded,
                              iconColor: theme.colorScheme.primary,
                              label: L10n.t.profitLossRevenue,
                              amount: report.totalRevenuePiasters,
                              isBold: false,
                            ),
                            const SizedBox(height: 12),
                            _buildRow(
                              context,
                              icon: Icons.inventory_2_outlined,
                              iconColor: AppColors.neutralGrey,
                              label: L10n.t.profitLossCogs,
                              amount: report.costOfGoodsSoldPiasters,
                              isNegative: true,
                              isBold: false,
                            ),
                            const Divider(height: 20),
                            _buildRow(
                              context,
                              icon: Icons.calculate_outlined,
                              iconColor: theme.colorScheme.secondary,
                              label: L10n.t.profitLossGross,
                              amount: report.grossProfitPiasters,
                              isBold: true,
                            ),
                            const SizedBox(height: 12),
                            _buildRow(
                              context,
                              icon: Icons.receipt_long_rounded,
                              iconColor: AppColors.debtRed,
                              label: L10n.t.profitLossExpenses,
                              amount: report.operatingExpensesPiasters,
                              isNegative: true,
                              isBold: false,
                            ),
                            const Divider(height: 24),
                            _buildRow(
                              context,
                              icon: Icons.account_balance_wallet_rounded,
                              iconColor: netColor,
                              label: L10n.t.profitLossNet,
                              amount: report.netProfitPiasters,
                              customColor: netColor,
                              isBold: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Educational Explanation
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 20,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'صافي الربح = إجمالي المبيعات - تكلفة البضاعة المباعة - المصروفات التشغيلية (كهرباء، إيجار، عمالة، بوفيه، إلخ).',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required int amount,
    Color? customColor,
    bool isNegative = false,
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    final displayColor = customColor ??
        (isNegative ? AppColors.debtRed : theme.textTheme.bodyLarge?.color);

    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 15 : 14,
            ),
          ),
        ),
        Text(
          '${isNegative && amount > 0 ? "- " : ""}${MoneyUtils.formatMoney(amount.abs())}',
          style: TextStyle(
            color: displayColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            fontSize: isBold ? 16 : 14,
          ),
        ),
      ],
    );
  }
}
