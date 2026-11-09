import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/l10n/app_localizations.dart';
import 'package:kashkool/shared/widgets/glass_toast.dart';

/// Dialog allowing manual adjustment of the day's opening cash balance.
class EditOpeningCashDialog extends ConsumerStatefulWidget {
  final DateTime date;
  final int currentOpeningPiasters;

  const EditOpeningCashDialog({
    super.key,
    required this.date,
    required this.currentOpeningPiasters,
  });

  static Future<void> show(
    BuildContext context, {
    required DateTime date,
    required int currentOpeningPiasters,
  }) {
    return showDialog(
      context: context,
      builder: (context) => EditOpeningCashDialog(
        date: date,
        currentOpeningPiasters: currentOpeningPiasters,
      ),
    );
  }

  @override
  ConsumerState<EditOpeningCashDialog> createState() => _EditOpeningCashDialogState();
}

class _EditOpeningCashDialogState extends ConsumerState<EditOpeningCashDialog> {
  late final TextEditingController _controller;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: MoneyUtils.formatMoney(widget.currentOpeningPiasters, includeCurrency: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final piasters = MoneyUtils.toPiasters(_controller.text);
    if (piasters < 0) return;

    setState(() => _isSubmitting = true);
    try {
      final repo = ref.read(cashDrawerRepositoryProvider);
      await repo.updateOpeningCash(widget.date, piasters);

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        AppGlassToast.showSuccess(context, l10n.openingCashUpdatedSuccess);
        Navigator.pop(context);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.editOpeningCash),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.openingCashHint,
              style: const TextStyle(fontSize: 14, color: AppColors.neutralGrey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
              decoration: InputDecoration(
                suffixText: l10n.currency,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _isSubmitting ? null : _submit,
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
