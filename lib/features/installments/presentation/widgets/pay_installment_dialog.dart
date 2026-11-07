import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/db/app_database.dart';
import '../../../../core/utils/money.dart';
import '../../data/installment_repository.dart';

/// Modal dialog for recording an installment payment.
class PayInstallmentDialog extends ConsumerStatefulWidget {
  final String planId;
  final Installment? installment;
  final int defaultAmountPiasters;
  final String itemDescription;

  const PayInstallmentDialog({
    super.key,
    required this.planId,
    this.installment,
    required this.defaultAmountPiasters,
    required this.itemDescription,
  });

  @override
  ConsumerState<PayInstallmentDialog> createState() => _PayInstallmentDialogState();
}

class _PayInstallmentDialogState extends ConsumerState<PayInstallmentDialog> {
  late final TextEditingController _amountController;
  final _notesController = TextEditingController();
  PaymentMethod _selectedMethod = PaymentMethod.cash;
  DateTime _selectedDate = DateTime.now();
  bool _linkToLedger = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final initialEgp = (widget.defaultAmountPiasters / 100).toStringAsFixed(0);
    _amountController = TextEditingController(text: initialEgp);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _amountController.text.trim();
    final amountEgp = double.tryParse(text);
    if (amountEgp == null || amountEgp <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('برجاء كتابة مبلغ سداد صحيح أكبر من صفر')),
      );
      return;
    }

    final amountPiasters = (amountEgp * 100).round();

    setState(() => _isLoading = true);
    try {
      final repo = ref.read(installmentRepositoryProvider);
      await repo.recordPayment(
        planId: widget.planId,
        installmentId: widget.installment?.id,
        amountPiasters: amountPiasters,
        method: _selectedMethod,
        paymentDate: _selectedDate,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        linkToCustomerLedger: _linkToLedger,
      );

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم تسجيل سداد ${MoneyUtils.formatMoney(amountPiasters)} بنجاح ✓'),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء السداد: $e'), backgroundColor: AppColors.debtRed),
        );
      }
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat('yyyy/MM/dd');

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.payment_rounded, color: AppColors.primaryGreen),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.installment != null
                  ? 'سداد القسط رقم ${widget.installment!.installmentIndex}'
                  : 'سداد قسط (${widget.itemDescription})',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.installment != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Expanded(child: Text('المبلغ المطلوب للقسط:')),
                    Text(
                      MoneyUtils.formatMoney(widget.installment!.amountPiasters - widget.installment!.paidPiasters),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Amount Input
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
              decoration: const InputDecoration(
                labelText: 'المبلغ المدفوع (جنيه)',
                prefixIcon: Icon(Icons.attach_money_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Payment Method
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
            const SizedBox(height: 12),

            // Date picker tile
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_rounded),
              title: const Text('تاريخ السداد'),
              subtitle: Text(dateFmt.format(_selectedDate)),
              trailing: TextButton(
                onPressed: _pickDate,
                child: const Text('تغيير'),
              ),
            ),

            // Notes
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'ملاحظة (اختياري)',
                hintText: 'مثلاً: تحويل مع فلان',
                prefixIcon: Icon(Icons.note_alt_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),

            // Link to customer ledger checkbox
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('تسجيل في كشف حساب العميل'),
              subtitle: const Text('يخصم المبلغ تلقائياً من رصيد العميل العام'),
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
            minimumSize: const Size(110, 48),
          ),
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Text('تأكيد السداد', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
