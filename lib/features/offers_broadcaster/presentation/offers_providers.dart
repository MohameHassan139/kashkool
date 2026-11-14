import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../data/offers_broadcaster_repository.dart';
import '../domain/offer_campaign.dart';

/// Currently selected template type in the campaign setup screen.
final offerTemplateTypeProvider = StateProvider<OfferTemplateType>((ref) => OfferTemplateType.ramadan);

/// Currently selected audience filter in the campaign setup screen.
final offerAudienceFilterProvider = StateProvider<OfferAudienceFilter>((ref) => OfferAudienceFilter.allWithPhone);

/// Manually selected customer IDs when [OfferAudienceFilter.manual] is active.
final manualSelectedCustomerIdsProvider = StateProvider<Set<String>>((ref) => {});

/// Edited message text in the campaign setup screen.
final offerCustomMessageTextProvider = StateProvider<String?>((ref) => null);

/// Whether to include the Kashkool referral footer in the broadcast.
final offerIncludeGrowthFooterProvider = StateProvider<bool>((ref) => true);

/// Provides the active campaign saved in storage, if any.
final activeCampaignStreamProvider = FutureProvider.autoDispose<BroadcasterCampaign?>((ref) async {
  final repo = ref.watch(offersBroadcasterRepositoryProvider);
  return repo.getActiveCampaign();
});

/// Live list of recipients for the currently configured audience filter.
final previewRecipientsProvider = FutureProvider.autoDispose<List<OfferRecipient>>((ref) async {
  final repo = ref.watch(offersBroadcasterRepositoryProvider);
  final filter = ref.watch(offerAudienceFilterProvider);
  final manualIds = ref.watch(manualSelectedCustomerIdsProvider);

  return repo.loadRecipients(
    filter: filter,
    manualSelectedIds: manualIds,
  );
});

/// Notifier managing active campaign queue operations.
class CampaignQueueNotifier extends StateNotifier<AsyncValue<BroadcasterCampaign?>> {
  final OffersBroadcasterRepository _repo;

  CampaignQueueNotifier(this._repo) : super(const AsyncValue.loading()) {
    loadActiveCampaign();
  }

  Future<void> loadActiveCampaign() async {
    state = const AsyncValue.loading();
    try {
      final campaign = await _repo.getActiveCampaign();
      state = AsyncValue.data(campaign);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<BroadcasterCampaign> startNewCampaign({
    required String title,
    required OfferTemplateType templateType,
    required String templateText,
    required OfferAudienceFilter audienceFilter,
    required List<OfferRecipient> recipients,
    required bool includeGrowthFooter,
  }) async {
    final campaign = BroadcasterCampaign(
      id: const Uuid().v4(),
      title: title,
      templateType: templateType,
      templateText: templateText,
      audienceFilter: audienceFilter,
      recipients: recipients,
      includeGrowthFooter: includeGrowthFooter,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _repo.saveCampaign(campaign);
    state = AsyncValue.data(campaign);
    return campaign;
  }

  Future<void> markCurrentSent(String customerId) async {
    final updated = await _repo.markCustomerSent(customerId);
    state = AsyncValue.data(updated);
  }

  Future<void> markCurrentSkipped(String customerId) async {
    final updated = await _repo.markCustomerSkipped(customerId);
    state = AsyncValue.data(updated);
  }

  Future<void> discardCampaign() async {
    await _repo.clearActiveCampaign();
    state = const AsyncValue.data(null);
  }
}

final campaignQueueNotifierProvider =
    StateNotifierProvider<CampaignQueueNotifier, AsyncValue<BroadcasterCampaign?>>((ref) {
  final repo = ref.watch(offersBroadcasterRepositoryProvider);
  return CampaignQueueNotifier(repo);
});
