import 'dart:convert';
import '../../../core/utils/customer_rating.dart';

/// Pre-configured template categories for greetings and offers.
enum OfferTemplateType {
  ramadan,
  eid,
  backToSchool,
  newOffer,
  custom,
}

/// Target audience segmentation for broadcasting.
enum OfferAudienceFilter {
  allWithPhone,
  goodRating,
  active30Days,
  manual,
}

/// A single customer recipient targeted in an offer campaign.
class OfferRecipient {
  final String id;
  final String name;
  final String phone;
  final RatingBadge ratingBadge;
  final int balancePiasters;
  final DateTime? lastTransactionAt;

  const OfferRecipient({
    required this.id,
    required this.name,
    required this.phone,
    required this.ratingBadge,
    required this.balancePiasters,
    this.lastTransactionAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'ratingBadge': ratingBadge.name,
        'balancePiasters': balancePiasters,
        'lastTransactionAt': lastTransactionAt?.toIso8601String(),
      };

  factory OfferRecipient.fromJson(Map<String, dynamic> json) {
    return OfferRecipient(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      ratingBadge: RatingBadge.values.firstWhere(
        (b) => b.name == json['ratingBadge'],
        orElse: () => RatingBadge.newCustomer,
      ),
      balancePiasters: (json['balancePiasters'] as num?)?.toInt() ?? 0,
      lastTransactionAt: json['lastTransactionAt'] != null
          ? DateTime.tryParse(json['lastTransactionAt'] as String)
          : null,
    );
  }
}

/// Represents an ongoing or completed WhatsApp broadcasting campaign.
class BroadcasterCampaign {
  final String id;
  final String title;
  final OfferTemplateType templateType;
  final String templateText;
  final OfferAudienceFilter audienceFilter;
  final List<OfferRecipient> recipients;
  final List<String> sentCustomerIds;
  final List<String> skippedCustomerIds;
  final bool includeGrowthFooter;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BroadcasterCampaign({
    required this.id,
    required this.title,
    required this.templateType,
    required this.templateText,
    required this.audienceFilter,
    required this.recipients,
    this.sentCustomerIds = const [],
    this.skippedCustomerIds = const [],
    this.includeGrowthFooter = true,
    required this.createdAt,
    required this.updatedAt,
  });

  int get totalCount => recipients.length;
  int get sentCount => sentCustomerIds.length;
  int get skippedCount => skippedCustomerIds.length;
  int get processedCount => sentCount + skippedCount;
  int get pendingCount => totalCount - processedCount;
  double get progressPercent => totalCount == 0 ? 1.0 : (sentCount / totalCount).clamp(0.0, 1.0);
  bool get isCompleted => processedCount >= totalCount;

  /// Returns the next customer waiting in the queue, or null if all are done.
  OfferRecipient? get nextPendingRecipient {
    final handled = {...sentCustomerIds, ...skippedCustomerIds};
    for (final recipient in recipients) {
      if (!handled.contains(recipient.id)) {
        return recipient;
      }
    }
    return null;
  }

  BroadcasterCampaign copyWith({
    String? id,
    String? title,
    OfferTemplateType? templateType,
    String? templateText,
    OfferAudienceFilter? audienceFilter,
    List<OfferRecipient>? recipients,
    List<String>? sentCustomerIds,
    List<String>? skippedCustomerIds,
    bool? includeGrowthFooter,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BroadcasterCampaign(
      id: id ?? this.id,
      title: title ?? this.title,
      templateType: templateType ?? this.templateType,
      templateText: templateText ?? this.templateText,
      audienceFilter: audienceFilter ?? this.audienceFilter,
      recipients: recipients ?? this.recipients,
      sentCustomerIds: sentCustomerIds ?? this.sentCustomerIds,
      skippedCustomerIds: skippedCustomerIds ?? this.skippedCustomerIds,
      includeGrowthFooter: includeGrowthFooter ?? this.includeGrowthFooter,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'templateType': templateType.name,
        'templateText': templateText,
        'audienceFilter': audienceFilter.name,
        'recipients': recipients.map((r) => r.toJson()).toList(),
        'sentCustomerIds': sentCustomerIds,
        'skippedCustomerIds': skippedCustomerIds,
        'includeGrowthFooter': includeGrowthFooter,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory BroadcasterCampaign.fromJson(Map<String, dynamic> json) {
    return BroadcasterCampaign(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      templateType: OfferTemplateType.values.firstWhere(
        (t) => t.name == json['templateType'],
        orElse: () => OfferTemplateType.custom,
      ),
      templateText: json['templateText'] as String? ?? '',
      audienceFilter: OfferAudienceFilter.values.firstWhere(
        (a) => a.name == json['audienceFilter'],
        orElse: () => OfferAudienceFilter.allWithPhone,
      ),
      recipients: (json['recipients'] as List<dynamic>? ?? [])
          .map((r) => OfferRecipient.fromJson(r as Map<String, dynamic>))
          .toList(),
      sentCustomerIds: (json['sentCustomerIds'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      skippedCustomerIds: (json['skippedCustomerIds'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      includeGrowthFooter: json['includeGrowthFooter'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  String toJsonString() => jsonEncode(toJson());

  static BroadcasterCampaign? tryParse(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return BroadcasterCampaign.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }
}
