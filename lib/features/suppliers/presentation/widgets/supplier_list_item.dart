import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/phone.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/supplier_with_balance.dart';

/// Single supplier card item for the suppliers ledger list.
class SupplierListItem extends StatelessWidget {
  final SupplierWithBalance item;
  final VoidCallback onTap;
  final void Function(String phone)? onCallPhone;

  const SupplierListItem({
    super.key,
    required this.item,
    required this.onTap,
    this.onCallPhone,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final balance = item.balancePiasters;
    final bool hasDebt = balance > 0;
    final bool isSettled = balance == 0;

    final Color balanceColor;
    final String balanceText;
    final String statusLabel;

    if (hasDebt) {
      balanceColor = AppColors.debtRed;
      balanceText = MoneyUtils.formatMoney(balance);
      statusLabel = l10n.iOweHim;
    } else if (isSettled) {
      balanceColor = AppColors.paymentGreen;
      balanceText = l10n.settled;
      statusLabel = '';
    } else {
      balanceColor = AppColors.primaryBlueLight;
      balanceText = MoneyUtils.formatMoney(balance.abs());
      statusLabel = l10n.hePaid;
    }

    final hasCompany = item.supplier.company != null && item.supplier.company!.isNotEmpty;
    final visitDay = item.visitDayLabel;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Avatar circle with truck icon
              CircleAvatar(
                radius: 24,
                backgroundColor: hasDebt
                    ? AppColors.debtRed.withValues(alpha: 0.12)
                    : AppColors.paymentGreen.withValues(alpha: 0.12),
                child: Icon(
                  Icons.local_shipping_rounded,
                  color: hasDebt ? AppColors.debtRed : AppColors.paymentGreen,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),

              // Rep & Company info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.supplier.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),

                    // Company name
                    if (hasCompany) ...[
                      Text(
                        item.supplier.company!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                    ],

                    // Visit Day badge or phone
                    Row(
                      children: [
                        if (visitDay != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              l10n.visitDayPrefix(visitDay),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (item.supplier.phone != null) ...[
                          Text(
                            PhoneUtils.formatDisplay(item.supplier.phone),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.disabledColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Financial status (Balance)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    balanceText,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: balanceColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  if (statusLabel.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      statusLabel,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: balanceColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
