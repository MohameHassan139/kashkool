import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

/// Modular capabilities in Kashkool that a shop owner can toggle on or off
/// to tailor the app's interface to their exact daily workflow.
enum AppFeature {
  quickPos,
  suppliers,
  installments,
  inventory,
  cashDrawer,
  profitLoss,
  offers;

  String get settingKey => 'feature_${name}_enabled';

  bool get defaultEnabled {
    switch (this) {
      case AppFeature.quickPos:
      case AppFeature.suppliers:
      case AppFeature.inventory:
      case AppFeature.cashDrawer:
      case AppFeature.profitLoss:
        return true;
      case AppFeature.installments:
      case AppFeature.offers:
        return false;
    }
  }

  IconData get icon {
    switch (this) {
      case AppFeature.quickPos:
        return Icons.point_of_sale_rounded;
      case AppFeature.suppliers:
        return Icons.local_shipping_rounded;
      case AppFeature.installments:
        return Icons.event_repeat_rounded;
      case AppFeature.inventory:
        return Icons.inventory_2_rounded;
      case AppFeature.cashDrawer:
        return Icons.account_balance_wallet_rounded;
      case AppFeature.profitLoss:
        return Icons.trending_up_rounded;
      case AppFeature.offers:
        return Icons.campaign_rounded;
    }
  }

  Color get color {
    switch (this) {
      case AppFeature.quickPos:
        return const Color(0xFF0284C7);
      case AppFeature.suppliers:
        return const Color(0xFFEA580C);
      case AppFeature.installments:
        return const Color(0xFFD97706);
      case AppFeature.inventory:
        return const Color(0xFF2563EB);
      case AppFeature.cashDrawer:
        return const Color(0xFF16A34A);
      case AppFeature.profitLoss:
        return const Color(0xFF059669);
      case AppFeature.offers:
        return const Color(0xFF7C3AED);
    }
  }

  String title(AppLocalizations l10n) {
    switch (this) {
      case AppFeature.quickPos:
        return l10n.featureQuickPosTitle;
      case AppFeature.suppliers:
        return l10n.featureSuppliersTitle;
      case AppFeature.installments:
        return l10n.featureInstallmentsTitle;
      case AppFeature.inventory:
        return l10n.featureInventoryTitle;
      case AppFeature.cashDrawer:
        return l10n.featureCashDrawerTitle;
      case AppFeature.profitLoss:
        return l10n.featureProfitLossTitle;
      case AppFeature.offers:
        return l10n.featureOffersTitle;
    }
  }

  String description(AppLocalizations l10n) {
    switch (this) {
      case AppFeature.quickPos:
        return l10n.featureQuickPosDesc;
      case AppFeature.suppliers:
        return l10n.featureSuppliersDesc;
      case AppFeature.installments:
        return l10n.featureInstallmentsDesc;
      case AppFeature.inventory:
        return l10n.featureInventoryDesc;
      case AppFeature.cashDrawer:
        return l10n.featureCashDrawerDesc;
      case AppFeature.profitLoss:
        return l10n.featureProfitLossDesc;
      case AppFeature.offers:
        return l10n.featureOffersDesc;
    }
  }
}

/// Ready-made quick profiles that adapt the whole app in one tap.
enum FeaturePreset {
  simpleLedger,
  grocery,
  electronics,
  allFeatures;

  String title(AppLocalizations l10n) {
    switch (this) {
      case FeaturePreset.simpleLedger:
        return l10n.featurePresetSimple;
      case FeaturePreset.grocery:
        return l10n.featurePresetGrocery;
      case FeaturePreset.electronics:
        return l10n.featurePresetElectronics;
      case FeaturePreset.allFeatures:
        return l10n.featurePresetAll;
    }
  }

  String description(AppLocalizations l10n) {
    switch (this) {
      case FeaturePreset.simpleLedger:
        return l10n.featurePresetSimpleDesc;
      case FeaturePreset.grocery:
        return l10n.featurePresetGroceryDesc;
      case FeaturePreset.electronics:
        return l10n.featurePresetElectronicsDesc;
      case FeaturePreset.allFeatures:
        return l10n.featurePresetAllDesc;
    }
  }

  IconData get icon {
    switch (this) {
      case FeaturePreset.simpleLedger:
        return Icons.menu_book_rounded;
      case FeaturePreset.grocery:
        return Icons.shopping_basket_rounded;
      case FeaturePreset.electronics:
        return Icons.devices_other_rounded;
      case FeaturePreset.allFeatures:
        return Icons.auto_awesome_rounded;
    }
  }

  Color get color {
    switch (this) {
      case FeaturePreset.simpleLedger:
        return const Color(0xFF0F766E);
      case FeaturePreset.grocery:
        return const Color(0xFFEA580C);
      case FeaturePreset.electronics:
        return const Color(0xFF2563EB);
      case FeaturePreset.allFeatures:
        return const Color(0xFF9333EA);
    }
  }

  Set<AppFeature> get enabledFeatures {
    switch (this) {
      case FeaturePreset.simpleLedger:
        return {};
      case FeaturePreset.grocery:
        return {
          AppFeature.quickPos,
          AppFeature.suppliers,
          AppFeature.inventory,
          AppFeature.cashDrawer,
          AppFeature.profitLoss,
        };
      case FeaturePreset.electronics:
        return {
          AppFeature.quickPos,
          AppFeature.suppliers,
          AppFeature.installments,
          AppFeature.inventory,
          AppFeature.cashDrawer,
          AppFeature.profitLoss,
        };
      case FeaturePreset.allFeatures:
        return AppFeature.values.toSet();
    }
  }
}
