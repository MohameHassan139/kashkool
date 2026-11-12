import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/money.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/glass_toast.dart';
import '../data/transaction_repository.dart';

/// Modal bottom sheet to view transaction details, photo full-screen, or delete.
class TransactionDetailsBottomSheet extends ConsumerWidget {
  final Transaction transaction;

  const TransactionDetailsBottomSheet({super.key, required this.transaction});

  void _viewFullScreenPhoto(BuildContext context, String photoPath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          backgroundColor: Colors.black,
          body: Center(
            child: InteractiveViewer(child: Image.file(File(photoPath))),
          ),
        ),
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final repo = ref.read(transactionRepositoryProvider);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteTransaction),
        content: Text(l10n.deleteTransactionConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.debtRed,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await repo.deleteTransaction(transaction.id);
      if (context.mounted) {
        Navigator.of(context).pop();
        AppGlassToast.showSuccess(context, l10n.transactionDeleted);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isDebt = transaction.type == TransactionType.debt;
    final isSupplierCredit = transaction.type == TransactionType.supplierCredit;
    final color = isDebt
        ? AppColors.debtRed
        : isSupplierCredit
        ? AppColors.warningAmber
        : AppColors.paymentGreen;
    final dateFmt = DateFormat('yyyy/MM/dd · hh:mm a');

    String methodStr = '';
    if (transaction.method != null) {
      switch (transaction.method!) {
        case PaymentMethod.cash:
          methodStr = l10n.methodCash;
          break;
        case PaymentMethod.instapay:
          methodStr = l10n.methodInstapay;
          break;
        case PaymentMethod.wallet:
          methodStr = l10n.methodWallet;
          break;
        case PaymentMethod.other:
          methodStr = l10n.methodOther;
          break;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Grab handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            // Header Row: Type and Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isSupplierCredit
                        ? l10n.supplierCreditNote
                        : isDebt
                        ? (transaction.partyType == PartyType.supplier
                              ? l10n.iOweHim
                              : l10n.debt)
                        : (transaction.partyType == PartyType.supplier
                              ? l10n.iPaidHim
                              : l10n.payment),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  MoneyUtils.formatMoney(transaction.amountPiasters),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Date & Time
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 20,
                  color: AppColors.neutralGrey,
                ),
                const SizedBox(width: 8),
                Text(
                  dateFmt.format(transaction.occurredAt),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.neutralGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Payment method (if applicable)
            if (methodStr.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(
                    Icons.payment_rounded,
                    size: 20,
                    color: AppColors.neutralGrey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${l10n.paymentMethod}: $methodStr',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // Note (if present)
            if (transaction.note != null && transaction.note!.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  transaction.note!,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Photo preview if attached
            if (transaction.photoPath != null &&
                File(transaction.photoPath!).existsSync()) ...[
              InkWell(
                onTap: () =>
                    _viewFullScreenPhoto(context, transaction.photoPath!),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF334155)
                          : const Color(0xFFCBD5E1),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        File(transaction.photoPath!),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.fullscreen_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                l10n.viewPhoto,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            if (!isSupplierCredit) ...[
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.debtRed,
                  side: const BorderSide(color: AppColors.debtRed),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.delete_outline_rounded),
                label: Text(
                  l10n.deleteTransaction,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => _delete(context, ref),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
