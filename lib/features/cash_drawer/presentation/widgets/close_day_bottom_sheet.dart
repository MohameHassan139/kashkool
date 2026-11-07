import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/features/cash_drawer/domain/drawer_day_summary.dart';
import 'package:kashkool/l10n/app_localizations.dart';

/// Modal bottom sheet for performing end-of-day drawer closing and counting.
class CloseDayBottomSheet extends ConsumerStatefulWidget {
  final DrawerDaySummary summary;

  const CloseDayBottomSheet({
    super.key,
    required this.summary,
  });

  static Future<void> show(BuildContext context, {required DrawerDaySummary summary}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CloseDayBottomSheet(summary: summary),
    );
  }

  @override
  ConsumerState<CloseDayBottomSheet> createState() => _CloseDayBottomSheetState();
}

class _CloseDayBottomSheetState extends ConsumerState<CloseDayBottomSheet> {
  final _countController = TextEditingController();
  final _notesController = TextEditingController();

  int? _enteredActualPiasters;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.summary.actualCountPiasters != null) {
      _enteredActualPiasters = widget.summary.actualCountPiasters;
      _countController.text = MoneyUtils.formatMoney(
        widget.summary.actualCountPiasters!,
        includeCurrency: false,
      );
    }
    if (widget.summary.notes != null) {
      _notesController.text = widget.summary.notes!;
    }

    _countController.addListener(() {
      final piasters = MoneyUtils.toPiasters(_countController.text);
      setState(() {
        _enteredActualPiasters = _countController.text.trim().isEmpty ? null : piasters;
      });
    });
  }

  @override
  void dispose() {
    _countController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_enteredActualPiasters == null || _enteredActualPiasters! < 0) return;

    setState(() => _isSubmitting = true);
    try {
      final repo = ref.read(cashDrawerRepositoryProvider);
      await repo.closeDay(
        widget.summary.date,
        actualCountPiasters: _enteredActualPiasters!,
        notes: _notesController.text,
      );

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.dayClosedSuccess),
            backgroundColor: AppColors.paymentGreen,
          ),
        );
        Navigator.pop(context);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final expected = widget.summary.expectedDrawerPiasters;
    final actual = _enteredActualPiasters;

    int? diff;
    if (actual != null) {
      diff = actual - expected;
    }

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
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
              l10n.closeDay,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Expected amount card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.expectedInDrawer,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  Text(
                    MoneyUtils.formatMoney(expected),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Counted amount input
            TextField(
              controller: _countController,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
              decoration: InputDecoration(
                hintText: '0',
                suffixText: l10n.currency,
                suffixStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                labelText: l10n.actualCountLabel,
                helperText: l10n.actualCountHint,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
            const SizedBox(height: 20),

            // Live difference calculation card
            if (diff != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: diff == 0
                      ? AppColors.paymentGreenLight
                      : diff < 0
                          ? AppColors.debtRedLight
                          : AppColors.warningAmberLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: diff == 0
                        ? AppColors.paymentGreen
                        : diff < 0
                            ? AppColors.debtRed
                            : AppColors.warningAmber,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          diff == 0
                              ? Icons.check_circle_rounded
                              : diff < 0
                                  ? Icons.error_rounded
                                  : Icons.info_rounded,
                          color: diff == 0
                              ? AppColors.paymentGreen
                              : diff < 0
                                  ? AppColors.debtRed
                                  : AppColors.warningAmber,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          diff == 0
                              ? l10n.drawerBalanced
                              : diff < 0
                                  ? l10n.drawerShortage
                                  : l10n.drawerSurplus,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: diff == 0
                                ? AppColors.paymentGreen
                                : diff < 0
                                    ? AppColors.debtRed
                                    : AppColors.warningAmber,
                          ),
                        ),
                      ],
                    ),
                    if (diff != 0) ...[
                      const SizedBox(height: 8),
                      Text(
                        l10n.differenceAmount(MoneyUtils.formatMoney(diff)),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: diff < 0 ? AppColors.debtRed : AppColors.warningAmber,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Notes
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: l10n.drawerNotes,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.note_alt_outlined),
              ),
            ),
            const SizedBox(height: 24),

            // Confirm button
            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: (_enteredActualPiasters == null || _isSubmitting) ? null : _submit,
                icon: const Icon(Icons.lock_rounded, size: 24),
                label: Text(
                  l10n.confirmCloseDay,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
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
