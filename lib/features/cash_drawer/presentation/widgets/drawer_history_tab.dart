import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/features/cash_drawer/domain/drawer_day_summary.dart';
import 'package:kashkool/l10n/app_localizations.dart';
import 'close_day_bottom_sheet.dart';

/// Tab displaying monthly totals and historical cash drawer days.
class DrawerHistoryTab extends ConsumerWidget {
  const DrawerHistoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final historyAsync = ref.watch(drawerHistoryProvider);
    final monthlyTotalsAsync = ref.watch(currentMonthTotalsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Monthly Totals Card
          monthlyTotalsAsync.when(
            data: (totals) => Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_rounded, color: AppColors.primaryBlue, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          l10n.monthlyTotals,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _statItem(
                            l10n.monthlySales,
                            totals.totalCashSales,
                            AppColors.paymentGreen,
                          ),
                        ),
                        Container(width: 1, height: 40, color: Colors.grey.shade200),
                        Expanded(
                          child: _statItem(
                            l10n.monthlyExpenses,
                            totals.totalExpensesCash,
                            AppColors.debtRed,
                          ),
                        ),
                        Container(width: 1, height: 40, color: Colors.grey.shade200),
                        Expanded(
                          child: _statItem(
                            l10n.monthlyNet,
                            totals.netCash,
                            totals.netCash >= 0 ? AppColors.primaryBlue : AppColors.debtRed,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),

          // History List Title
          Text(
            l10n.historyTab,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // History List
          historyAsync.when(
            data: (days) {
              if (days.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      l10n.noHistoryYet,
                      style: const TextStyle(fontSize: 15, color: AppColors.neutralGrey),
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: days.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final day = days[index];
                  return _HistoryDayCard(day: day);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error: $err')),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String title, int amountPiasters, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          MoneyUtils.formatMoney(amountPiasters),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _HistoryDayCard extends ConsumerWidget {
  final CashDay day;

  const _HistoryDayCard({required this.day});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isClosed = day.closedAt != null;
    final dateStr = DateFormat('EEEE، d MMMM yyyy').format(day.date);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () async {
          final summary = await ref.read(cashDrawerRepositoryProvider).getDaySummary(day.date);
          if (context.mounted) {
            _showDayDetailsModal(context, summary, ref);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: isClosed ? Colors.grey.shade100 : AppColors.paymentGreenLight,
                child: Icon(
                  isClosed ? Icons.lock_outline_rounded : Icons.lock_open_rounded,
                  color: isClosed ? Colors.grey.shade700 : AppColors.paymentGreen,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateStr,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'مبيعات كاش: ${MoneyUtils.formatMoney(day.cashSalesPiasters)} · افتتاح: ${MoneyUtils.formatMoney(day.openingCashPiasters)}',
                      style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
                    ),
                  ],
                ),
              ),
              if (isClosed && day.actualCountPiasters != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      MoneyUtils.formatMoney(day.actualCountPiasters!),
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      l10n.dayIsClosed,
                      style: const TextStyle(fontSize: 11, color: AppColors.neutralGrey),
                    ),
                  ],
                ),
              ] else ...[
                Text(
                  l10n.dayIsOpen,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.paymentGreen,
                  ),
                ),
              ],
              const SizedBox(width: 4),
              const Icon(Icons.chevron_left_rounded, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showDayDetailsModal(BuildContext context, DrawerDaySummary summary, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isClosed = summary.isClosed;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'تفاصيل يوم ${DateFormat('yyyy/MM/dd').format(summary.date)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _detailRow(l10n.openingCash, summary.openingCashPiasters),
              _detailRow(l10n.cashIn, summary.cashInPiasters, isPositive: true),
              _detailRow('  - ${l10n.cashSales}', summary.cashSalesPiasters),
              _detailRow('  - ${l10n.customerPaymentsCash}', summary.customerCashPaymentsPiasters),
              _detailRow(l10n.cashOut, summary.cashOutPiasters, isNegative: true),
              _detailRow('  - ${l10n.expensesCash}', summary.expensesCashPiasters),
              _detailRow('  - ${l10n.supplierPaymentsCash}', summary.supplierCashPaymentsPiasters),
              const Divider(height: 20),
              _detailRow(l10n.expectedInDrawer, summary.expectedDrawerPiasters, isBold: true),
              if (summary.actualCountPiasters != null) ...[
                _detailRow(l10n.actualCountLabel, summary.actualCountPiasters!, isBold: true),
                if (summary.differencePiasters != null)
                  _detailRow(
                    'الفرق',
                    summary.differencePiasters!,
                    isDiff: true,
                    isBold: true,
                  ),
              ],
              const SizedBox(height: 20),
              if (isClosed)
                OutlinedButton.icon(
                  onPressed: () async {
                    Navigator.pop(ctx);
                    await ref.read(cashDrawerRepositoryProvider).reopenDay(summary.date);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.dayReopenedSuccess)),
                      );
                    }
                  },
                  icon: const Icon(Icons.lock_open_rounded, color: AppColors.debtRed),
                  label: Text(l10n.reopenDay, style: const TextStyle(color: AppColors.debtRed)),
                )
              else
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    CloseDayBottomSheet.show(context, summary: summary);
                  },
                  icon: const Icon(Icons.lock_rounded),
                  label: Text(l10n.closeDay),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, int amount, {bool isBold = false, bool isPositive = false, bool isNegative = false, bool isDiff = false}) {
    Color color = Colors.black87;
    if (isPositive) color = AppColors.paymentGreen;
    if (isNegative) color = AppColors.debtRed;
    if (isDiff) {
      color = amount == 0
          ? AppColors.paymentGreen
          : amount < 0
              ? AppColors.debtRed
              : AppColors.warningAmber;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 15 : 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.black87 : AppColors.neutralGreyDark,
            ),
          ),
          Text(
            MoneyUtils.formatMoney(amount),
            style: TextStyle(
              fontSize: isBold ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
