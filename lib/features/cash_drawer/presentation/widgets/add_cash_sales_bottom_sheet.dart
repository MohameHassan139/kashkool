import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/l10n/app_localizations.dart';

/// Modal bottom sheet allowing the shopkeeper to record cash sales for the day.
class AddCashSalesBottomSheet extends ConsumerStatefulWidget {
  final DateTime date;
  final int currentSalesPiasters;

  const AddCashSalesBottomSheet({
    super.key,
    required this.date,
    required this.currentSalesPiasters,
  });

  static Future<void> show(
    BuildContext context, {
    required DateTime date,
    required int currentSalesPiasters,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCashSalesBottomSheet(
        date: date,
        currentSalesPiasters: currentSalesPiasters,
      ),
    );
  }

  @override
  ConsumerState<AddCashSalesBottomSheet> createState() => _AddCashSalesBottomSheetState();
}

class _AddCashSalesBottomSheetState extends ConsumerState<AddCashSalesBottomSheet> {
  final _amountController = TextEditingController();
  bool _isAddMode = true; // true = add to existing, false = replace total
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _addQuickAmount(int pounds) {
    final currentPounds = double.tryParse(_amountController.text) ?? 0.0;
    final newAmount = currentPounds + pounds;
    _amountController.text = newAmount % 1 == 0 ? newAmount.toInt().toString() : newAmount.toString();
  }

  Future<void> _submit() async {
    final amountPiasters = MoneyUtils.toPiasters(_amountController.text);
    if (amountPiasters <= 0 && _isAddMode) return;

    setState(() => _isSubmitting = true);

    try {
      final repo = ref.read(cashDrawerRepositoryProvider);
      if (_isAddMode) {
        await repo.addCashSales(widget.date, amountPiasters);
      } else {
        await repo.updateCashSales(widget.date, amountPiasters);
      }

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.cashSalesAddedSuccess)),
        );
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
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            Text(
              l10n.addCashSales,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Current sales indication
            Center(
              child: Text(
                'المبيعات المسجلة حتى الآن: ${MoneyUtils.formatMoney(widget.currentSalesPiasters)}',
                style: const TextStyle(fontSize: 14, color: AppColors.neutralGrey),
              ),
            ),
            const SizedBox(height: 16),

            // Mode toggle
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: true,
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('إضافة للمبيعات (+)'),
                  ),
                  icon: Icon(Icons.add_rounded),
                ),
                ButtonSegment(
                  value: false,
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('تعديل الإجمالي (=)'),
                  ),
                  icon: Icon(Icons.edit_outlined),
                ),
              ],
              selected: {_isAddMode},
              onSelectionChanged: (set) => setState(() => _isAddMode = set.first),
            ),
            const SizedBox(height: 16),

            // Amount field
            TextField(
              controller: _amountController,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen,
              ),
              decoration: InputDecoration(
                hintText: '0',
                suffixText: l10n.currency,
                suffixStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                labelText: _isAddMode ? 'المبلغ المراد إضافته' : 'إجمالي المبيعات الجديد',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                filled: true,
                fillColor: isDark ? const Color(0xFF111827) : Colors.grey.shade50,
              ),
            ),
            const SizedBox(height: 12),

            // Quick add buttons
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [50, 100, 200, 500, 1000].map((val) {
                return ActionChip(
                  label: Text('+$val جنيه'),
                  onPressed: () => _addQuickAmount(val),
                  backgroundColor: AppColors.paymentContainer(isDark),
                  labelStyle: TextStyle(
                    color: isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Save button
            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: _isSubmitting ? null : _submit,
                icon: const Icon(Icons.check_rounded, size: 26),
                label: Text(
                  l10n.save,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.paymentGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
