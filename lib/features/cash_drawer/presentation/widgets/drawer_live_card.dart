import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/features/cash_drawer/data/cash_drawer_repository.dart';
import 'package:kashkool/features/cash_drawer/domain/drawer_day_summary.dart';
import 'package:kashkool/l10n/app_localizations.dart';
import 'close_day_bottom_sheet.dart';
import 'edit_opening_cash_dialog.dart';

/// Top card in the Cash Drawer screen displaying real-time expected balance,
/// opening cash, closing status, and the primary action button.
class DrawerLiveCard extends ConsumerWidget {
  final DrawerDaySummary summary;

  const DrawerLiveCard({
    super.key,
    required this.summary,
  });

  Future<void> _confirmReopen(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.reopenDay),
        content: Text(l10n.reopenDayConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.debtRed),
            child: Text(l10n.reopenDay),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(cashDrawerRepositoryProvider).reopenDay(summary.date);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.dayReopenedSuccess)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isClosed = summary.isClosed;

    return Card(
      elevation: isDark ? 1 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top row: Label & Status badge
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.point_of_sale_rounded, color: theme.colorScheme.primary, size: 28),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          l10n.expectedInDrawer,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isClosed
                        ? (isDark ? const Color(0xFF374151) : Colors.grey.shade200)
                        : AppColors.paymentContainer(isDark),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isClosed ? Icons.lock_outline_rounded : Icons.lock_open_rounded,
                        size: 14,
                        color: isClosed
                            ? (isDark ? const Color(0xFFD1D5DB) : Colors.grey.shade700)
                            : (isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isClosed ? l10n.dayIsClosed : l10n.dayIsOpen,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isClosed
                              ? (isDark ? const Color(0xFFF3F4F6) : Colors.grey.shade800)
                              : (isDark ? AppColors.paymentGreenDark : AppColors.paymentGreen),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Big Expected Amount
            Text(
              MoneyUtils.formatMoney(summary.expectedDrawerPiasters),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.primary,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),

            const Divider(height: 1),
            const SizedBox(height: 12),

            // Opening Cash row
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.openingCash,
                    style: const TextStyle(fontSize: 14, color: AppColors.neutralGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    Text(
                      MoneyUtils.formatMoney(summary.openingCashPiasters),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    if (!isClosed) ...[
                      const SizedBox(width: 4),
                      IconButton(
                        icon: Icon(Icons.edit_outlined, size: 18, color: theme.colorScheme.primary),
                        onPressed: () => EditOpeningCashDialog.show(
                          context,
                          date: summary.date,
                          currentOpeningPiasters: summary.openingCashPiasters,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: l10n.editOpeningCash,
                      ),
                    ],
                  ],
                ),
              ],
            ),

            // If closed: show actual count, difference, and closing time
            if (isClosed && summary.actualCountPiasters != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.actualCountLabel,
                      style: const TextStyle(fontSize: 14, color: AppColors.neutralGrey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    MoneyUtils.formatMoney(summary.actualCountPiasters!),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      summary.differenceStatus == DrawerDifferenceStatus.balanced
                          ? l10n.drawerBalanced
                          : summary.differenceStatus == DrawerDifferenceStatus.shortage
                              ? l10n.drawerShortage
                              : l10n.drawerSurplus,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: summary.differenceStatus == DrawerDifferenceStatus.balanced
                            ? AppColors.paymentGreen
                            : summary.differenceStatus == DrawerDifferenceStatus.shortage
                                ? AppColors.debtRed
                                : AppColors.warningAmber,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (summary.differencePiasters != null && summary.differencePiasters != 0)
                    Text(
                      MoneyUtils.formatMoney(summary.differencePiasters!),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: summary.differencePiasters! < 0
                            ? AppColors.debtRed
                            : AppColors.warningAmber,
                      ),
                    ),
                ],
              ),
              if (summary.closedAt != null) ...[
                const SizedBox(height: 6),
                Text(
                  l10n.closedAtTime(DateFormat('hh:mm a').format(summary.closedAt!)),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
              if (summary.notes != null && summary.notes!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  'ملاحظة: ${summary.notes!}',
                  style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.grey.shade700),
                ),
              ],
            ],

            const SizedBox(height: 16),

            // Action button: Close day OR Reopen day
            SizedBox(
              height: 52,
              child: isClosed
                  ? OutlinedButton.icon(
                      onPressed: () => _confirmReopen(context, ref),
                      icon: const Icon(Icons.lock_open_rounded, size: 22, color: AppColors.debtRed),
                      label: Text(
                        l10n.reopenDay,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.debtRed,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.debtRed, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    )
                  : FilledButton.icon(
                      onPressed: () => CloseDayBottomSheet.show(context, summary: summary),
                      icon: const Icon(Icons.lock_rounded, size: 22),
                      label: Text(
                        l10n.closeDay,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
