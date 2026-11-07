import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/db/app_database.dart';
import '../../../../core/utils/money.dart';
import '../../data/installment_repository.dart';

/// Modal dialog for early settlement of the entire remaining balance with optional discount.
class EarlySettlementDialog extends ConsumerStatefulWidget {
  final String planId;
  final String itemDescription;
  final int remainingPiasters;

  const EarlySettlementDialog({
    super.key,
    required this.planId,
    required this.itemDescription,
    required this.remainingPiasters,
  });

  @override
  ConsumerState<EarlySettlementDialog> createState() => _EarlySettlementDialogState();
}

class _EarlySettlementDialogState extends ConsumerState<EarlySettlementDialog> {
  final _discountController = TextEditingController(text: '0');
  PaymentMethod _selectedMethod = PaymentMethod.cash;
  bool _linkToLedger = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _discountController.dispose();
    super.dispose();
  }

  int get _discountPiasters {
    final text = _discountController.text.trim();
    final discountEgp = double.tryParse(text) ?? 0.0;
    return (discountEgp * 100).round();
  }

  int get _netSettlementPiasters {
    final net = widget.remainingPiasters - _discountPiasters;
    return net < 0 ? 0 : net;
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(installmentRepositoryProvider);
      await repo.settlePlanEarly(
        planId: widget.planId,
        discountPiasters: _discountPiasters,
        method: _selectedMethod,
        linkToCustomerLedger: _linkToLedger,
      );

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تمت تسوية وتصفية قسط (${widget.itemDescription}) بنجاح ✓',
            ),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء التسوية: $e'),
            backgroundColor: AppColors.debtRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.verified_rounded, color: AppColors.primaryGreen),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'سداد مبكر وتصفية القسط',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(child: Text('إجمالي باقي الأقساط:')),
                      Text(
                        MoneyUtils.formatMoney(widget.remainingPiasters),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Expanded(child: Text('المبلغ المطلوب تحصيله:')),
                      Text(
                        MoneyUtils.formatMoney(_netSettlementPiasters),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryGreen),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Discount Input
            TextField(
              controller: _discountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'خصم تعجيل سداد (جنيه)',
                hintText: '0',
                prefixIcon: Icon(Icons.discount_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Payment method
            Text('طريقة الدفع', style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('كاش 💵'),
                  selected: _selectedMethod == PaymentMethod.cash,
                  onSelected: (val) {
                    if (val) setState(() => _selectedMethod = PaymentMethod.cash);
                  },
                ),
                ChoiceChip(
                  label: const Text('إنستاباي ⚡'),
                  selected: _selectedMethod == PaymentMethod.instapay,
                  onSelected: (val) {
                    if (val) setState(() => _selectedMethod = PaymentMethod.instapay);
                  },
                ),
                ChoiceChip(
                  label: const Text('محفظة 📱'),
                  selected: _selectedMethod == PaymentMethod.wallet,
                  onSelected: (val) {
                    if (val) setState(() => _selectedMethod = PaymentMethod.wallet);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('تسجيل في كشف حساب العميل'),
              value: _linkToLedger,
              onChanged: (val) => setState(() => _linkToLedger = val ?? true),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
            foregroundColor: Colors.white,
            minimumSize: const Size(120, 48),
          ),
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Text('تصفية القسط الآن', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
