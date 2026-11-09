import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/phone.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/customer_with_balance.dart';
import 'credit_limit_progress_bar.dart';
import 'rating_badge.dart';

/// Single item tile in the customers list
class CustomerListItem extends StatelessWidget {
  final CustomerWithBalance item;
  final VoidCallback onTap;

  const CustomerListItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final customer = item.customer;
    final balance = item.balancePiasters;

    final Color balanceColor;
    final String balanceText;
    final String statusLabel;

    if (balance > 0) {
      balanceColor = AppColors.debtRed;
      balanceText = MoneyUtils.formatMoney(balance);
      statusLabel = l10n.debt;
    } else if (balance == 0) {
      balanceColor = AppColors.paymentGreen;
      balanceText = l10n.settled;
      statusLabel = '';
    } else {
      balanceColor = AppColors.primaryBlueLight;
      balanceText = MoneyUtils.formatMoney(balance.abs());
      statusLabel = l10n.hePaid;
    }

    String? lastActivityStr;
    if (item.lastTransactionAt != null) {
      final formatter = DateFormat('yyyy/MM/dd');
      lastActivityStr = l10n.lastActivityDate(formatter.format(item.lastTransactionAt!));
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Avatar circle with first letter
              CircleAvatar(
                radius: 24,
                backgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFE2E8F0),
                child: Text(
                  customer.name.isNotEmpty ? customer.name.characters.first : '؟',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Name and secondary details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            customer.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: CustomerRatingBadge(
                            customerName: customer.name,
                            rating: item.rating,
                          ),
                        ),
                        if (item.isCreditLimitExceeded) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.debtRedLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              '!',
                              style: TextStyle(
                                color: AppColors.debtRed,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    if (customer.phone != null && customer.phone!.isNotEmpty)
                      Text(
                        PhoneUtils.formatDisplay(customer.phone),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.neutralGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    else if (lastActivityStr != null)
                      Text(
                        lastActivityStr,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.neutralGrey,
                        ),
                      ),
                    if (customer.creditLimitPiasters != null) ...[
                      const SizedBox(height: 6),
                      CreditLimitProgressBar(
                        balancePiasters: balance,
                        limitPiasters: customer.creditLimitPiasters,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Financial Balance Display
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (statusLabel.isNotEmpty)
                    Text(
                      statusLabel,
                      style: TextStyle(
                        color: balanceColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  Text(
                    balanceText,
                    style: TextStyle(
                      color: balanceColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
