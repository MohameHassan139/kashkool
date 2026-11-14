import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/growth/growth_footer.dart';
import '../../../core/utils/customer_rating.dart';
import '../../customers/data/customer_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../domain/offer_campaign.dart';

/// Repository for handling audience segmentation, message templating, and campaign state.
class OffersBroadcasterRepository {
  final CustomerRepository _customerRepo;
  final SettingsRepository _settingsRepo;

  static const String keyActiveCampaign = 'active_offers_campaign';

  OffersBroadcasterRepository({
    required CustomerRepository customerRepo,
    required SettingsRepository settingsRepo,
  })  : _customerRepo = customerRepo,
        _settingsRepo = settingsRepo;

  /// Loads and segments recipients according to [filter].
  Future<List<OfferRecipient>> loadRecipients({
    required OfferAudienceFilter filter,
    Set<String>? manualSelectedIds,
  }) async {
    final customersWithBalance = await _customerRepo.watchCustomersWithBalance().first;
    final now = DateTime.now();

    // 1. Basic requirement: must have a non-empty phone number
    final withPhone = customersWithBalance.where((c) {
      final phone = c.customer.phone;
      return phone != null && phone.trim().isNotEmpty;
    }).toList();

    // 2. Audience filter
    final results = <OfferRecipient>[];
    for (final item in withPhone) {
      bool matches = false;
      switch (filter) {
        case OfferAudienceFilter.allWithPhone:
          matches = true;
          break;
        case OfferAudienceFilter.goodRating:
          matches = item.rating.badge == RatingBadge.good;
          break;
        case OfferAudienceFilter.active30Days:
          final lastTx = item.lastTransactionAt;
          matches = lastTx != null && now.difference(lastTx).inDays <= 30;
          break;
        case OfferAudienceFilter.manual:
          matches = manualSelectedIds?.contains(item.customer.id) ?? false;
          break;
      }

      if (matches) {
        results.add(
          OfferRecipient(
            id: item.customer.id,
            name: item.customer.name,
            phone: item.customer.phone!.trim(),
            ratingBadge: item.rating.badge,
            balancePiasters: item.balancePiasters,
            lastTransactionAt: item.lastTransactionAt,
          ),
        );
      }
    }

    return results;
  }

  /// Personalizes the message body with customer name, shop name, and optional growth footer.
  String renderPersonalizedMessage({
    required String template,
    required String customerName,
    required String shopName,
    bool includeGrowthFooter = true,
    String? shopCode,
  }) {
    var text = template
        .replaceAll('{customer_name}', customerName.trim().isEmpty ? 'عميلنا العزيز' : customerName.trim())
        .replaceAll('{shop_name}', shopName.trim().isEmpty ? 'المحل' : shopName.trim());

    if (includeGrowthFooter) {
      text = '$text\n\n${GrowthFooter.footerText(shopCode)}';
    }

    return text;
  }

  /// Retrieves the active unfinished campaign, if any.
  Future<BroadcasterCampaign?> getActiveCampaign() async {
    final raw = await _settingsRepo.getString(keyActiveCampaign);
    return BroadcasterCampaign.tryParse(raw);
  }

  /// Saves or updates the campaign state.
  Future<void> saveCampaign(BroadcasterCampaign campaign) async {
    final updated = campaign.copyWith(updatedAt: DateTime.now());
    await _settingsRepo.setString(keyActiveCampaign, updated.toJsonString());
  }

  /// Marks a recipient as sent and advances campaign progress.
  Future<BroadcasterCampaign?> markCustomerSent(String customerId) async {
    final campaign = await getActiveCampaign();
    if (campaign == null) return null;

    final updatedSent = [...campaign.sentCustomerIds];
    if (!updatedSent.contains(customerId)) {
      updatedSent.add(customerId);
    }
    // If was previously skipped, remove from skipped
    final updatedSkipped = campaign.skippedCustomerIds.where((id) => id != customerId).toList();

    final updated = campaign.copyWith(
      sentCustomerIds: updatedSent,
      skippedCustomerIds: updatedSkipped,
      updatedAt: DateTime.now(),
    );
    await saveCampaign(updated);
    return updated;
  }

  /// Marks a recipient as skipped.
  Future<BroadcasterCampaign?> markCustomerSkipped(String customerId) async {
    final campaign = await getActiveCampaign();
    if (campaign == null) return null;

    final updatedSkipped = [...campaign.skippedCustomerIds];
    if (!updatedSkipped.contains(customerId)) {
      updatedSkipped.add(customerId);
    }

    final updated = campaign.copyWith(
      skippedCustomerIds: updatedSkipped,
      updatedAt: DateTime.now(),
    );
    await saveCampaign(updated);
    return updated;
  }

  /// Clears the saved active campaign.
  Future<void> clearActiveCampaign() async {
    await _settingsRepo.remove(keyActiveCampaign);
  }
}

/// Provider for [OffersBroadcasterRepository].
final offersBroadcasterRepositoryProvider = Provider<OffersBroadcasterRepository>((ref) {
  final customerRepo = ref.watch(customerRepositoryProvider);
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  return OffersBroadcasterRepository(
    customerRepo: customerRepo,
    settingsRepo: settingsRepo,
  );
});
