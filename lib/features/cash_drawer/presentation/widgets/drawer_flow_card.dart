import 'package:flutter/material.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/features/cash_drawer/domain/drawer_day_summary.dart';
import 'package:kashkool/l10n/app_localizations.dart';
import 'add_cash_sales_bottom_sheet.dart';
import 'add_expense_bottom_sheet.dart';

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
    final isClosed = summary.isClosed;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row with Quick Action Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: FilledButton.tonalIcon(
                      onPressed: isClosed
                          ? null
                          : () => AddCashSalesBottomSheet.show(
                                context,
                                date: summary.date,
                                currentSalesPiasters: summary.cashSalesPiasters,
                              ),
                      icon: const Icon(Icons.add_shopping_cart_rounded, size: 20, color: AppColors.paymentGreen),
                      label: Text(
                        l10n.addCashSales,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.paymentGreen,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.paymentGreenLight,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: FilledButton.tonalIcon(
                      onPressed: isClosed
                          ? null
                          : () => AddExpenseBottomSheet.show(
                                context,
                                date: summary.date,
                              ),
                      icon: const Icon(Icons.receipt_long_rounded, size: 20, color: AppColors.debtRed),
                      label: Text(
                        l10n.addExpense,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.debtRed,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.debtRedLight,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
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
                color: Colors.green.shade50.withAlpha(120),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.arrow_downward_rounded, color: AppColors.paymentGreen, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            l10n.cashIn,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.paymentGreen,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        MoneyUtils.formatMoney(summary.cashInPiasters),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.paymentGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _subRow(l10n.cashSales, summary.cashSalesPiasters),
                  _subRow(l10n.customerPaymentsCash, summary.customerCashPaymentsPiasters),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Cash Outflow Breakdown
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.shade50.withAlpha(120),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.arrow_upward_rounded, color: AppColors.debtRed, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            l10n.cashOut,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.debtRed,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        MoneyUtils.formatMoney(summary.cashOutPiasters),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.debtRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _subRow(l10n.expensesCash, summary.expensesCashPiasters),
                  _subRow(l10n.supplierPaymentsCash, summary.supplierCashPaymentsPiasters),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Digital Inflow (Separate, not in drawer)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50.withAlpha(120),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blueGrey.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.phone_android_rounded, color: Colors.blueGrey, size: 20),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.digitalIn,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const Text(
                            '(إنستاباي / محفظة - خارج الدرج)',
                            style: TextStyle(fontSize: 11, color: AppColors.neutralGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    MoneyUtils.formatMoney(summary.digitalInPiasters),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
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

  Widget _subRow(String label, int amountPiasters) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.neutralGreyDark),
          ),
          Text(
            MoneyUtils.formatMoney(amountPiasters),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
