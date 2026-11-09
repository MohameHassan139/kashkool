import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/phone.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../customers/presentation/widgets/rating_badge.dart';
import '../../domain/due_customer.dart';

/// Single row item representing a customer due for collection.
class CollectionListItem extends StatelessWidget {
  final DueCustomer item;
  final VoidCallback onTap;
  final VoidCallback onWhatsApp;
  final VoidCallback onSms;
  final VoidCallback onCall;
  final void Function(String action) onActionSelected;

  const CollectionListItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.onWhatsApp,
    required this.onSms,
    required this.onCall,
    required this.onActionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final customer = item.customer;
    final balance = item.balancePiasters;
    final daysSinceReminder = item.daysSinceLastReminder;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row: Name + Phone + Balance
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (customer.phone != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            PhoneUtils.formatDisplay(customer.phone),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.disabledColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Balance (Flexible + FittedBox prevents overflow on large amounts / fonts)
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        MoneyUtils.formatMoney(balance),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.debtRed,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Metadata chips: Rating badge, Debt age & Last reminder
              Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CustomerRatingBadge(
                    customerName: customer.name,
                    rating: item.rating,
                  ),
                  // Debt Age
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.schedule_rounded, size: 14, color: AppColors.neutralGrey),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            item.oldestUnpaidAgeDays == 0
                                ? l10n.oldestDebtToday
                                : l10n.oldestDebtDays(item.oldestUnpaidAgeDays),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Last Reminder
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          daysSinceReminder == null
                              ? Icons.mark_chat_unread_outlined
                              : Icons.mark_chat_read_outlined,
                          size: 14,
                          color: AppColors.neutralGrey,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            daysSinceReminder == null
                              ? l10n.neverReminded
                              : (daysSinceReminder == 0
                                  ? l10n.lastReminderToday
                                  : l10n.lastReminderDays(daysSinceReminder)),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Action Buttons Row: WhatsApp (Primary) + SMS + Call + More
              Row(
                children: [
                  // Primary WhatsApp button
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366), // WhatsApp Brand Green
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      icon: const Icon(Icons.chat_bubble_rounded, size: 20),
                      label: Text(
                        l10n.sendWhatsApp,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: onWhatsApp,
                    ),
                  ),
                  const SizedBox(width: 6),

                  // SMS Button
                  Container(
                    width: 42,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.sms_outlined, size: 20),
                      tooltip: l10n.sendSms,
                      color: isDark ? Colors.white : AppColors.primaryBlue,
                      onPressed: onSms,
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Call Button
                  Container(
                    width: 42,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.phone_in_talk_outlined, size: 20),
                      tooltip: l10n.callCustomer,
                      color: AppColors.paymentGreen,
                      onPressed: onCall,
                    ),
                  ),
                  const SizedBox(width: 6),

                  // More Options Popup Menu
                  Container(
                    width: 42,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.more_horiz_rounded, size: 20),
                      tooltip: l10n.moreActions,
                      onSelected: onActionSelected,
                      itemBuilder: (ctx) => [
                        PopupMenuItem(
                          value: 'snooze_3',
                          child: Row(
                            children: [
                              const Icon(Icons.snooze_rounded, color: AppColors.warningAmber),
                              const SizedBox(width: 8),
                              Text(l10n.snooze3Days),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'snooze_7',
                          child: Row(
                            children: [
                              const Icon(Icons.alarm_off_rounded, color: AppColors.warningAmber),
                              const SizedBox(width: 8),
                              Text(l10n.snooze7Days),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          value: 'record_payment',
                          child: Row(
                            children: [
                              const Icon(Icons.add_circle_outline_rounded,
                                  color: AppColors.paymentGreen),
                              const SizedBox(width: 8),
                              Text(
                                l10n.recordCollectionPayment,
                                style: const TextStyle(
                                  color: AppColors.paymentGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
