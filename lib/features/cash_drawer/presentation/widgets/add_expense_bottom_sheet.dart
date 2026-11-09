import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/features/cash_drawer/data/expenses_repository.dart';
import 'package:kashkool/l10n/app_localizations.dart';
import 'package:kashkool/shared/widgets/glass_toast.dart';

/// Modal bottom sheet allowing the shopkeeper to record a shop expense.
class AddExpenseBottomSheet extends ConsumerStatefulWidget {
  final DateTime date;
  final Expense? existingExpense;

  const AddExpenseBottomSheet({
    super.key,
    required this.date,
    this.existingExpense,
  });

  static Future<void> show(BuildContext context, {required DateTime date, Expense? existingExpense}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddExpenseBottomSheet(
        date: date,
        existingExpense: existingExpense,
      ),
    );
  }

  @override
  ConsumerState<AddExpenseBottomSheet> createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends ConsumerState<AddExpenseBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.supplies;
  PaymentMethod _selectedMethod = PaymentMethod.cash;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingExpense != null) {
      final exp = widget.existingExpense!;
      _amountController.text = MoneyUtils.formatMoney(exp.amountPiasters, includeCurrency: false);
      _noteController.text = exp.note ?? '';
      _selectedCategory = exp.category;
      _selectedMethod = exp.method;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final amountPiasters = MoneyUtils.toPiasters(_amountController.text);
    if (amountPiasters <= 0) return;

    setState(() => _isSubmitting = true);

    try {
      final repo = ref.read(expensesRepositoryProvider);
      if (widget.existingExpense == null) {
        await repo.addExpense(
          date: widget.date,
          category: _selectedCategory,
          amountPiasters: amountPiasters,
          method: _selectedMethod,
          note: _noteController.text,
        );
      } else {
        await repo.updateExpense(
          id: widget.existingExpense!.id,
          category: _selectedCategory,
          amountPiasters: amountPiasters,
          method: _selectedMethod,
          note: _noteController.text,
        );
      }

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        AppGlassToast.showSuccess(context, l10n.expenseAddedSuccess);
        Navigator.pop(context);
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.existingExpense != null;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: theme.dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Text(
                isEditing ? l10n.editExpense : l10n.addExpense,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Amount field
              TextFormField(
                controller: _amountController,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.debtRedDark : AppColors.debtRed,
                ),
                decoration: InputDecoration(
                  hintText: '0',
                  suffixText: l10n.currency,
                  suffixStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                  labelText: l10n.amountLabel,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  filled: true,
                  fillColor: isDark ? const Color(0xFF111827) : Colors.grey.shade50,
                ),
                validator: (val) {
                  final piasters = MoneyUtils.toPiasters(val ?? '');
                  if (piasters <= 0) return l10n.amountRequired;
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category chips
              Text(
                l10n.expenseCategory,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ExpenseCategory.values.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    avatar: Icon(
                      _getCategoryIcon(cat),
                      size: 18,
                      color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
                    ),
                    label: Text(_getCategoryLabel(cat, l10n)),
                    selected: isSelected,
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedCategory = cat);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Payment Method (Cash / Instapay / Wallet)
              Text(
                l10n.paymentMethod,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              SegmentedButton<PaymentMethod>(
                segments: [
                  ButtonSegment(
                    value: PaymentMethod.cash,
                    label: Text(l10n.methodCash),
                    icon: const Icon(Icons.money_rounded),
                  ),
                  ButtonSegment(
                    value: PaymentMethod.instapay,
                    label: Text(l10n.methodInstapay),
                    icon: const Icon(Icons.flash_on_rounded),
                  ),
                  ButtonSegment(
                    value: PaymentMethod.wallet,
                    label: Text(l10n.methodWallet),
                    icon: const Icon(Icons.account_balance_wallet_rounded),
                  ),
                ],
                selected: {_selectedMethod},
                onSelectionChanged: (set) => setState(() => _selectedMethod = set.first),
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: l10n.noteOptional,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.edit_note_rounded),
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                height: 56,
                child: FilledButton.icon(
                  onPressed: _isSubmitting ? null : _submit,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.check_rounded, size: 26),
                  label: Text(
                    l10n.save,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
