import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../onboarding/data/shop_repository.dart';
import '../data/offers_broadcaster_repository.dart';
import '../domain/offer_campaign.dart';
import 'offers_providers.dart';
import 'widgets/manual_customer_picker_dialog.dart';

/// Screen for configuring and launching an offers & greetings WhatsApp broadcast.
class OffersBroadcasterScreen extends ConsumerStatefulWidget {
  const OffersBroadcasterScreen({super.key});

  @override
  ConsumerState<OffersBroadcasterScreen> createState() => _OffersBroadcasterScreenState();
}

class _OffersBroadcasterScreenState extends ConsumerState<OffersBroadcasterScreen> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String _getDefaultTemplateText(AppLocalizations l10n, OfferTemplateType type) {
    switch (type) {
      case OfferTemplateType.ramadan:
        return l10n.offersDefaultRamadanText;
      case OfferTemplateType.eid:
        return l10n.offersDefaultEidText;
      case OfferTemplateType.backToSchool:
        return l10n.offersDefaultBackToSchoolText;
      case OfferTemplateType.newOffer:
        return l10n.offersDefaultNewOfferText;
      case OfferTemplateType.custom:
        return l10n.offersDefaultCustomText;
    }
  }

  void _insertPlaceholder(String placeholder) {
    final text = _messageController.text;
    final selection = _messageController.selection;
    if (selection.isValid && selection.start >= 0) {
      final newText = text.replaceRange(selection.start, selection.end, placeholder);
      _messageController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start + placeholder.length),
      );
    } else {
      _messageController.text = '$text$placeholder';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final selectedTemplate = ref.watch(offerTemplateTypeProvider);
    final selectedAudience = ref.watch(offerAudienceFilterProvider);
    final manualSelectedIds = ref.watch(manualSelectedCustomerIdsProvider);
    final includeGrowthFooter = ref.watch(offerIncludeGrowthFooterProvider);
    final recipientsAsync = ref.watch(previewRecipientsProvider);
    final activeCampaignAsync = ref.watch(campaignQueueNotifierProvider);
    final shopAsync = ref.watch(activeShopStreamProvider);

    // Populate initial text if empty
    if (_messageController.text.trim().isEmpty) {
      _messageController.text = _getDefaultTemplateText(l10n, selectedTemplate);
    }

    final recipients = recipientsAsync.valueOrNull ?? [];
    final activeCampaign = activeCampaignAsync.valueOrNull;
    final shopName = shopAsync.valueOrNull?.name ?? l10n.main1;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.offersBroadcasterTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // 0. Active Unfinished Campaign Banner (if any)
          if (activeCampaign != null && !activeCampaign.isCompleted) ...[
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.paymentGreen.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.paymentGreen.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.history_rounded, color: AppColors.paymentGreen),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.offersCampaignActiveBanner(
                            activeCampaign.sentCount,
                            activeCampaign.totalCount,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.paymentGreen,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: Text(l10n.offersResumeCampaign(activeCampaign.pendingCount)),
                          onPressed: () => context.push('/offers/queue'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () async {
                          await ref.read(campaignQueueNotifierProvider.notifier).discardCampaign();
                        },
                        child: Text(
                          l10n.offersDiscardCampaign,
                          style: TextStyle(color: theme.colorScheme.error, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          // 1. Template Section
          _buildSectionHeader(context, l10n.offersTemplateSection, Icons.category_outlined),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTemplateChip(
                  context: context,
                  label: l10n.offersTemplateRamadan,
                  type: OfferTemplateType.ramadan,
                  isSelected: selectedTemplate == OfferTemplateType.ramadan,
                  onSelected: () {
                    ref.read(offerTemplateTypeProvider.notifier).state = OfferTemplateType.ramadan;
                    _messageController.text = _getDefaultTemplateText(l10n, OfferTemplateType.ramadan);
                    setState(() {});
                  },
                ),
                const SizedBox(width: 8),
                _buildTemplateChip(
                  context: context,
                  label: l10n.offersTemplateEid,
                  type: OfferTemplateType.eid,
                  isSelected: selectedTemplate == OfferTemplateType.eid,
                  onSelected: () {
                    ref.read(offerTemplateTypeProvider.notifier).state = OfferTemplateType.eid;
                    _messageController.text = _getDefaultTemplateText(l10n, OfferTemplateType.eid);
                    setState(() {});
                  },
                ),
                const SizedBox(width: 8),
                _buildTemplateChip(
                  context: context,
                  label: l10n.offersTemplateBackToSchool,
                  type: OfferTemplateType.backToSchool,
                  isSelected: selectedTemplate == OfferTemplateType.backToSchool,
                  onSelected: () {
                    ref.read(offerTemplateTypeProvider.notifier).state = OfferTemplateType.backToSchool;
                    _messageController.text = _getDefaultTemplateText(l10n, OfferTemplateType.backToSchool);
                    setState(() {});
                  },
                ),
                const SizedBox(width: 8),
                _buildTemplateChip(
                  context: context,
                  label: l10n.offersTemplateNewOffer,
                  type: OfferTemplateType.newOffer,
                  isSelected: selectedTemplate == OfferTemplateType.newOffer,
                  onSelected: () {
                    ref.read(offerTemplateTypeProvider.notifier).state = OfferTemplateType.newOffer;
                    _messageController.text = _getDefaultTemplateText(l10n, OfferTemplateType.newOffer);
                    setState(() {});
                  },
                ),
                const SizedBox(width: 8),
                _buildTemplateChip(
                  context: context,
                  label: l10n.offersTemplateCustom,
                  type: OfferTemplateType.custom,
                  isSelected: selectedTemplate == OfferTemplateType.custom,
                  onSelected: () {
                    ref.read(offerTemplateTypeProvider.notifier).state = OfferTemplateType.custom;
                    _messageController.text = _getDefaultTemplateText(l10n, OfferTemplateType.custom);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Audience Section
          _buildSectionHeader(context, l10n.offersAudienceSection, Icons.groups_outlined),
          const SizedBox(height: 8),
          Column(
            children: [
              _buildAudienceRadioTile(
                context: context,
                title: l10n.offersAudienceAllWithPhone,
                value: OfferAudienceFilter.allWithPhone,
                groupValue: selectedAudience,
                onChanged: (val) {
                  ref.read(offerAudienceFilterProvider.notifier).state = val!;
                },
              ),
              _buildAudienceRadioTile(
                context: context,
                title: l10n.offersAudienceGoodRating,
                value: OfferAudienceFilter.goodRating,
                groupValue: selectedAudience,
                onChanged: (val) {
                  ref.read(offerAudienceFilterProvider.notifier).state = val!;
                },
              ),
              _buildAudienceRadioTile(
                context: context,
                title: l10n.offersAudienceActive30Days,
                value: OfferAudienceFilter.active30Days,
                groupValue: selectedAudience,
                onChanged: (val) {
                  ref.read(offerAudienceFilterProvider.notifier).state = val!;
                },
              ),
              _buildAudienceRadioTile(
                context: context,
                title: selectedAudience == OfferAudienceFilter.manual
                    ? l10n.offersSelectManualCustomers(manualSelectedIds.length)
                    : l10n.offersAudienceManual,
                value: OfferAudienceFilter.manual,
                groupValue: selectedAudience,
                trailing: IconButton(
                  icon: const Icon(Icons.edit_note_rounded),
                  onPressed: () async {
                    ref.read(offerAudienceFilterProvider.notifier).state = OfferAudienceFilter.manual;
                    final selected = await showDialog<Set<String>>(
                      context: context,
                      builder: (_) => ManualCustomerPickerDialog(
                        initialSelectedIds: manualSelectedIds,
                      ),
                    );
                    if (selected != null) {
                      ref.read(manualSelectedCustomerIdsProvider.notifier).state = selected;
                    }
                  },
                ),
                onChanged: (val) async {
                  ref.read(offerAudienceFilterProvider.notifier).state = val!;
                  final selected = await showDialog<Set<String>>(
                    context: context,
                    builder: (_) => ManualCustomerPickerDialog(
                      initialSelectedIds: manualSelectedIds,
                    ),
                  );
                  if (selected != null) {
                    ref.read(manualSelectedCustomerIdsProvider.notifier).state = selected;
                  }
                },
              ),
            ],
          ),

          // Audience Count Badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.person_pin_circle_outlined,
                  size: 18,
                  color: recipients.isEmpty ? theme.colorScheme.error : AppColors.paymentGreen,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    recipients.isEmpty
                        ? l10n.offersNoRecipients
                        : 'المستهدفون حالياً: ${recipients.length} عميل',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: recipients.isEmpty ? theme.colorScheme.error : AppColors.paymentGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 3. Message Section
          _buildSectionHeader(context, l10n.offersMessageSection, Icons.edit_note_rounded),
          const SizedBox(height: 8),

          // Placeholder quick inserter
          Text(
            l10n.offersInsertPlaceholderHint,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              ActionChip(
                avatar: const Icon(Icons.add, size: 16),
                label: const Text('{customer_name}'),
                onPressed: () => _insertPlaceholder('{customer_name}'),
              ),
              ActionChip(
                avatar: const Icon(Icons.add, size: 16),
                label: const Text('{shop_name}'),
                onPressed: () => _insertPlaceholder('{shop_name}'),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Message TextField
          TextField(
            controller: _messageController,
            maxLines: 5,
            minLines: 3,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Growth footer toggle
          SwitchListTile(
            value: includeGrowthFooter,
            onChanged: (val) => ref.read(offerIncludeGrowthFooterProvider.notifier).state = val,
            title: Text(
              l10n.offersIncludeGrowthFooter,
              style: const TextStyle(fontSize: 14),
            ),
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeTrackColor: AppColors.paymentGreen,
          ),
          const SizedBox(height: 8),

          // Anti-Spam Tip
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.warningAmber.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.warningAmber.withValues(alpha: 0.4)),
            ),
            child: Text(
              l10n.offersTipSpam,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          const SizedBox(height: 16),

          // Live Preview Card
          _buildLivePreviewCard(
            context: context,
            l10n: l10n,
            shopName: shopName,
            includeFooter: includeGrowthFooter,
          ),
          const SizedBox(height: 32),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.paymentGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
              ),
              icon: const Icon(Icons.rocket_launch_rounded),
              label: Text(
                l10n.offersStartCampaign(recipients.length),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: recipients.isEmpty
                  ? null
                  : () async {
                      final notifier = ref.read(campaignQueueNotifierProvider.notifier);

                      await notifier.startNewCampaign(
                        title: _getTemplateTitle(l10n, selectedTemplate),
                        templateType: selectedTemplate,
                        templateText: _messageController.text.trim(),
                        audienceFilter: selectedAudience,
                        recipients: recipients,
                        includeGrowthFooter: includeGrowthFooter,
                      );

                      if (context.mounted) {
                        unawaited(context.push('/offers/queue'));
                      }
                    },
            ),
          ),
        ),
      ),
    );
  }

  String _getTemplateTitle(AppLocalizations l10n, OfferTemplateType type) {
    switch (type) {
      case OfferTemplateType.ramadan:
        return l10n.offersTemplateRamadan;
      case OfferTemplateType.eid:
        return l10n.offersTemplateEid;
      case OfferTemplateType.backToSchool:
        return l10n.offersTemplateBackToSchool;
      case OfferTemplateType.newOffer:
        return l10n.offersTemplateNewOffer;
      case OfferTemplateType.custom:
        return l10n.offersTemplateCustom;
    }
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateChip({
    required BuildContext context,
    required String label,
    required OfferTemplateType type,
    required bool isSelected,
    required VoidCallback onSelected,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: AppColors.paymentGreen.withValues(alpha: 0.18),
      side: BorderSide(
        color: isSelected ? AppColors.paymentGreen : const Color(0xFFCBD5E1),
      ),
    );
  }

  Widget _buildAudienceRadioTile({
    required BuildContext context,
    required String title,
    required OfferAudienceFilter value,
    required OfferAudienceFilter groupValue,
    required ValueChanged<OfferAudienceFilter?> onChanged,
    Widget? trailing,
  }) {
    final isSelected = value == groupValue;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppColors.paymentGreen : const Color(0xFFE2E8F0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onChanged(value),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.paymentGreen : const Color(0xFF94A3B8),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.paymentGreen,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 14)),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLivePreviewCard({
    required BuildContext context,
    required AppLocalizations l10n,
    required String shopName,
    required bool includeFooter,
  }) {
    final repo = ref.read(offersBroadcasterRepositoryProvider);
    final rendered = repo.renderPersonalizedMessage(
      template: _messageController.text,
      customerName: l10n.offersSampleCustomerName,
      shopName: shopName,
      includeGrowthFooter: includeFooter,
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.preview_rounded, size: 18, color: AppColors.paymentGreen),
                const SizedBox(width: 6),
                Text(
                  l10n.offersPreviewCardTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFDCF8C6).withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                rendered,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
