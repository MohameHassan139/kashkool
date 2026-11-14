import 'package:flutter/material.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/features/cash_drawer/domain/drawer_day_summary.dart';
import 'package:kashkool/l10n/app_localizations.dart';
import 'add_cash_sales_bottom_sheet.dart';
import 'add_expense_bottom_sheet.dart';
import '../../../../l10n/l10n.dart';

/// Card breaking down the cash inflows, outflows, and digital receipts for the day,
/// along with quick buttons to add cash sales or expenses.
class DrawerFlowCard extends StatelessWidget {
  final DrawerDaySummary summary;

  const DrawerFlowCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isClosed = summary.isClosed;

    return Card(
      elevation: isDark ? 1 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row with Quick Action Buttons
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: isClosed
                        ? null
                        : () => AddCashSalesBottomSheet.show(
                              context,
                              date: summary.date,
                              currentSalesPiasters: summary.cashSalesPiasters,
                            ),
                    icon: Icon(
                      Icons.add_shopping_cart_rounded,
                      size: 20,
                      color: isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen,
                    ),
                    label: Text(
                      l10n.addCashSales,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      backgroundColor: isDark
                          ? const Color(0xFF064E3B).withValues(alpha: 0.5)
                          : AppColors.paymentGreenLight,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: isClosed
                        ? null
                        : () => AddExpenseBottomSheet.show(
                              context,
                              date: summary.date,
                            ),
                    icon: Icon(
                      Icons.receipt_long_rounded,
                      size: 20,
                      color: isDark ? AppColors.debtRedDark : AppColors.debtRed,
                    ),
                    label: Text(
                      l10n.addExpense,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.debtRedDark : AppColors.debtRed,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      backgroundColor: isDark
                          ? const Color(0xFF7F1D1D).withValues(alpha: 0.5)
                          : AppColors.debtRedLight,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Cash Inflow Breakdown
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF052E16).withValues(alpha: 0.4)
                    : Colors.green.shade50.withAlpha(120),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? const Color(0xFF166534) : Colors.green.shade200,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_downward_rounded,
                        color: isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l10n.cashIn,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            MoneyUtils.formatMoney(summary.cashInPiasters),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _subRow(context, l10n.cashSales, summary.cashSalesPiasters),
                  _subRow(context, l10n.customerPaymentsCash, summary.customerCashPaymentsPiasters),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Cash Outflow Breakdown
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF450A0A).withValues(alpha: 0.4)
                    : Colors.red.shade50.withAlpha(120),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? const Color(0xFF991B1B) : Colors.red.shade200,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_upward_rounded,
                        color: isDark ? AppColors.debtRedDark : AppColors.debtRed,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l10n.cashOut,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.debtRedDark : AppColors.debtRed,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            MoneyUtils.formatMoney(summary.cashOutPiasters),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.debtRedDark : AppColors.debtRed,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _subRow(context, l10n.expensesCash, summary.expensesCashPiasters),
                  _subRow(context, l10n.supplierPaymentsCash, summary.supplierCashPaymentsPiasters),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Digital Inflow (Separate, not in drawer)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E293B).withValues(alpha: 0.5)
                    : Colors.blueGrey.shade50.withAlpha(120),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? const Color(0xFF334155) : Colors.blueGrey.shade200,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.phone_android_rounded,
                    color: isDark ? const Color(0xFF94A3B8) : Colors.blueGrey,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.digitalIn,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? const Color(0xFFCBD5E1) : Colors.blueGrey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          L10n.t.drawerFlowCard1,
                          style: const TextStyle(fontSize: 11, color: AppColors.neutralGrey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        MoneyUtils.formatMoney(summary.digitalInPiasters),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? const Color(0xFFCBD5E1) : Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subRow(BuildContext context, String label, int amountPiasters) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? const Color(0xFF9CA3AF) : AppColors.neutralGreyDark,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            MoneyUtils.formatMoney(amountPiasters),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
