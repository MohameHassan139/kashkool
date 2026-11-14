import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/customer_rating.dart';
import '../../../../core/utils/money.dart';
import '../../../../core/utils/phone.dart';
import '../../../../core/utils/whatsapp_template.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/glass_toast.dart';
import '../../customers/presentation/widgets/rating_badge.dart';
import '../../onboarding/data/shop_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../data/offers_broadcaster_repository.dart';
import '../domain/offer_campaign.dart';
import 'offers_providers.dart';

/// Screen handling sequential 1-by-1 sending of campaign messages via WhatsApp.
class OffersQueueScreen extends ConsumerStatefulWidget {
  const OffersQueueScreen({super.key});

  @override
  ConsumerState<OffersQueueScreen> createState() => _OffersQueueScreenState();
}

class _OffersQueueScreenState extends ConsumerState<OffersQueueScreen> {
  bool _isPrompting = false;

  Future<void> _sendWhatsApp({
    required OfferRecipient recipient,
    required BroadcasterCampaign campaign,
    required String shopName,
    required String? shopCode,
    required AppLocalizations l10n,
  }) async {
    final repo = ref.read(offersBroadcasterRepositoryProvider);
    final personalizedMessage = repo.renderPersonalizedMessage(
      template: campaign.templateText,
      customerName: recipient.name,
      shopName: shopName,
      includeGrowthFooter: campaign.includeGrowthFooter,
      shopCode: shopCode,
    );

    final launched = await WhatsAppTemplateUtils.launchWhatsApp(
      phone: recipient.phone,
      message: personalizedMessage,
    );

    if (!launched && mounted) {
      AppGlassToast.showError(context, l10n.whatsAppNotInstalled);
      return;
    }

    if (!mounted || _isPrompting) return;
    _isPrompting = true;

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.offersSentSuccessPrompt(recipient.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.offersNotSent),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.paymentGreen,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.offersYesSent),
          ),
        ],
      ),
    );

    _isPrompting = false;

    if (confirmed == true && mounted) {
      await ref.read(campaignQueueNotifierProvider.notifier).markCurrentSent(recipient.id);
      if (mounted) {
        AppGlassToast.showSuccess(context, l10n.reminderMarkedSent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final campaignAsync = ref.watch(campaignQueueNotifierProvider);
    final shopAsync = ref.watch(activeShopStreamProvider);
    final shopCodeAsync = ref.watch(shopCodeProvider);

    final campaign = campaignAsync.valueOrNull;
    final shopName = shopAsync.valueOrNull?.name ?? l10n.main1;
    final shopCode = shopCodeAsync.valueOrNull;

    if (campaignAsync.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.offersQueueTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (campaign == null || campaign.isCompleted || campaign.nextPendingRecipient == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.offersQueueTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.celebration_rounded, size: 72, color: AppColors.paymentGreen),
                const SizedBox(height: 16),
                Text(
                  l10n.offersCampaignCompleteTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.offersCampaignCompleteSubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.paymentGreen,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    ref.read(campaignQueueNotifierProvider.notifier).discardCampaign();
                    context.go('/');
                  },
                  child: Text(l10n.save),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final recipient = campaign.nextPendingRecipient!;
    final repo = ref.read(offersBroadcasterRepositoryProvider);
    final personalizedMessage = repo.renderPersonalizedMessage(
      template: campaign.templateText,
      customerName: recipient.name,
      shopName: shopName,
      includeGrowthFooter: campaign.includeGrowthFooter,
      shopCode: shopCode,
    );

    final percentInt = (campaign.progressPercent * 100).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.offersQueueTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            tooltip: l10n.offersPauseQueue,
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // 1. Progress Bar & Counter
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.offersProgressLabel(campaign.sentCount, campaign.totalCount, percentInt),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      '$percentInt%',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.paymentGreen,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: campaign.progressPercent,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.paymentGreen),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 2. Customer Card
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: AppColors.paymentGreen.withValues(alpha: 0.15),
                        child: Text(
                          recipient.name.isNotEmpty ? recipient.name[0] : '؟',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.paymentGreen,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipient.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              PhoneUtils.formatDisplay(recipient.phone),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomerRatingBadge(
                        customerName: recipient.name,
                        rating: CustomerRatingResult(
                          badge: recipient.ratingBadge,
                          explanation: '',
                        ),
                      ),
                    ],
                  ),
                  if (recipient.balancePiasters > 0) ...[
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.currentBalance,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor),
                        ),
                        Text(
                          MoneyUtils.formatMoney(recipient.balancePiasters),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.debtRed,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 3. Personalized Message Bubble
          Text(
            l10n.offersPreviewCardTitle,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.disabledColor,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFDCF8C6).withValues(alpha: isDark ? 0.2 : 0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.paymentGreen.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              personalizedMessage,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Big 56dp Primary WhatsApp button
              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                  ),
                  icon: const Icon(Icons.send_rounded, size: 22),
                  label: Text(
                    l10n.offersSendViaWhatsApp,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _sendWhatsApp(
                    recipient: recipient,
                    campaign: campaign,
                    shopName: shopName,
                    shopCode: shopCode,
                    l10n: l10n,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Secondary Buttons (Skip / Pause)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () async {
                        await ref
                            .read(campaignQueueNotifierProvider.notifier)
                            .markCurrentSkipped(recipient.id);
                      },
                      child: Text(l10n.offersSkipCustomer),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => context.pop(),
                      child: Text(l10n.offersPauseQueue),
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
