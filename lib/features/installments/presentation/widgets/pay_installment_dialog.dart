import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/db/app_database.dart';
import '../../../../core/utils/money.dart';
import '../../../../shared/widgets/glass_toast.dart';
import '../../data/installment_repository.dart';
import '../../../../l10n/l10n.dart';

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
      AppGlassToast.showError(context, L10n.t.payInstallmentDialog1);
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
        AppGlassToast.showSuccess(
          context,
          L10n.t.payInstallmentDialog2(MoneyUtils.formatMoney(amountPiasters)),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        AppGlassToast.showError(
          context,
          L10n.t.payInstallmentDialog3(e),
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
                  ? L10n.t.payInstallmentDialog4(widget.installment!.installmentIndex)
                  : L10n.t.payInstallmentDialog5(widget.itemDescription),
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
                    Expanded(child: Text(L10n.t.payInstallmentDialog6)),
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
              decoration: InputDecoration(
                labelText: L10n.t.payInstallmentDialog7,
                prefixIcon: Icon(Icons.attach_money_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Payment Method
            Text(L10n.t.payInstallmentDialog8, style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: Text(L10n.t.payInstallmentDialog9),
                  selected: _selectedMethod == PaymentMethod.cash,
                  onSelected: (val) {
                    if (val) setState(() => _selectedMethod = PaymentMethod.cash);
                  },
                ),
                ChoiceChip(
                  label: Text(L10n.t.payInstallmentDialog10),
                  selected: _selectedMethod == PaymentMethod.instapay,
                  onSelected: (val) {
                    if (val) setState(() => _selectedMethod = PaymentMethod.instapay);
                  },
                ),
                ChoiceChip(
                  label: Text(L10n.t.payInstallmentDialog11),
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
              title: Text(L10n.t.payInstallmentDialog12),
              subtitle: Text(dateFmt.format(_selectedDate)),
              trailing: TextButton(
                onPressed: _pickDate,
                child: Text(L10n.t.payInstallmentDialog13),
              ),
            ),

            // Notes
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: L10n.t.payInstallmentDialog14,
                hintText: L10n.t.payInstallmentDialog15,
                prefixIcon: Icon(Icons.note_alt_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),

            // Link to customer ledger checkbox
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(L10n.t.payInstallmentDialog16),
              subtitle: Text(L10n.t.payInstallmentDialog17),
              value: _linkToLedger,
              onChanged: (val) => setState(() => _linkToLedger = val ?? true),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: Text(L10n.t.installmentPlanDetailsScreen11),
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
              : Text(L10n.t.payInstallmentDialog18, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
