import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/features/cash_drawer/data/expenses_repository.dart';
import 'package:kashkool/features/cash_drawer/domain/drawer_day_summary.dart';
import 'package:kashkool/l10n/app_localizations.dart';
import 'add_expense_bottom_sheet.dart';

/// Card displaying the list of expenses recorded for the day with edit/delete actions.
class ExpensesListCard extends ConsumerWidget {
  final DrawerDaySummary summary;

  const ExpensesListCard({
    super.key,
    required this.summary,
  });

  String _getCategoryLabel(ExpenseCategory cat, AppLocalizations l10n) {
    switch (cat) {
      case ExpenseCategory.rent:
        return l10n.catRent;
      case ExpenseCategory.electricity:
        return l10n.catElectricity;
      case ExpenseCategory.salary:
        return l10n.catSalary;
      case ExpenseCategory.supplies:
        return l10n.catSupplies;
      case ExpenseCategory.supplierPayment:
        return l10n.catSupplierPayment;
      case ExpenseCategory.other:
        return l10n.catOther;
    }
  }

  IconData _getCategoryIcon(ExpenseCategory cat) {
    switch (cat) {
      case ExpenseCategory.rent:
        return Icons.store_rounded;
      case ExpenseCategory.electricity:
        return Icons.bolt_rounded;
      case ExpenseCategory.salary:
        return Icons.person_outline_rounded;
      case ExpenseCategory.supplies:
        return Icons.shopping_cart_outlined;
      case ExpenseCategory.supplierPayment:
        return Icons.inventory_2_outlined;
      case ExpenseCategory.other:
        return Icons.more_horiz_rounded;
    }
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, Expense expense) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteExpense),
        content: Text(l10n.deleteExpenseConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.debtRed),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(expensesRepositoryProvider).deleteExpense(expense.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final expenses = summary.expenses;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_long_outlined, color: AppColors.debtRed, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      l10n.expensesCash,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '${expenses.length} مصروف',
                  style: const TextStyle(fontSize: 13, color: AppColors.neutralGrey),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (expenses.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    l10n.noExpensesYet,
                    style: const TextStyle(fontSize: 14, color: AppColors.neutralGrey),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  final timeStr = DateFormat('hh:mm a').format(expense.date);

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: AppColors.debtRedLight,
                      child: Icon(_getCategoryIcon(expense.category), color: AppColors.debtRed, size: 20),
                    ),
                    title: Text(
                      _getCategoryLabel(expense.category, l10n),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(
                      [
                        if (expense.note != null && expense.note!.isNotEmpty) expense.note!,
                        timeStr,
                        if (expense.method != PaymentMethod.cash)
                          expense.method == PaymentMethod.instapay ? 'إنستاباي' : 'محفظة',
                      ].join(' · '),
                      style: const TextStyle(fontSize: 12, color: AppColors.neutralGrey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          MoneyUtils.formatMoney(expense.amountPiasters),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.debtRed,
                          ),
                        ),
                        if (!isClosed) ...[
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert_rounded, size: 20, color: Colors.grey),
                            onSelected: (val) {
                              if (val == 'edit') {
                                AddExpenseBottomSheet.show(
                                  context,
                                  date: summary.date,
                                  existingExpense: expense,
                                );
                              } else if (val == 'delete') {
                                _confirmDelete(context, ref, expense);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit_outlined, size: 18),
                                    const SizedBox(width: 8),
                                    Text(l10n.editExpense),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.debtRed),
                                    const SizedBox(width: 8),
                                    Text(l10n.delete, style: const TextStyle(color: AppColors.debtRed)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
