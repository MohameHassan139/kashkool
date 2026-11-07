import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/money.dart';
import '../../../../l10n/app_localizations.dart';

/// Top summary card showing total market payables ("عليك للموردين") and net market position.
class PayablesHeaderCard extends StatelessWidget {
  final int totalPiasters;
  final int? netPositionPiasters;

  const PayablesHeaderCard({
    super.key,
    required this.totalPiasters,
    this.netPositionPiasters,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFFFF1F2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFFECDD3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.debtRed.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_shipping_rounded,
                  color: AppColors.debtRed,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.totalPayablesTitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      MoneyUtils.formatMoney(totalPiasters),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.debtRed,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Net Market Position tie-in
          if (netPositionPiasters != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F172A) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    netPositionPiasters! >= 0
                        ? Icons.check_circle_outline_rounded
                        : Icons.warning_amber_rounded,
                    size: 18,
                    color: netPositionPiasters! > 0
                        ? AppColors.paymentGreen
                        : (netPositionPiasters! < 0 ? AppColors.debtRed : AppColors.neutralGrey),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      netPositionPiasters! > 0
                          ? l10n.netReceivables(MoneyUtils.formatMoney(netPositionPiasters!))
                          : (netPositionPiasters! < 0
                              ? l10n.netPayables(MoneyUtils.formatMoney(netPositionPiasters!.abs()))
                              : l10n.netSettled),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: netPositionPiasters! > 0
                            ? AppColors.paymentGreen
                            : (netPositionPiasters! < 0
                                ? AppColors.debtRed
                                : AppColors.neutralGrey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
