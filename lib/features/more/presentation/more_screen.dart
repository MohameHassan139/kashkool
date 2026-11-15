import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../l10n/l10n.dart';
import '../../settings/data/settings_repository.dart';
import '../../settings/domain/app_features.dart';

/// "المزيد" hub: keeps the bottom navigation simple by grouping the less
/// frequent tools (inventory, cash drawer, installments, offers, settings).
/// Dynamically filters tiles based on shop-enabled features.
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isInventoryEnabled = ref.watch(isFeatureEnabledProvider(AppFeature.inventory));
    final isCashDrawerEnabled = ref.watch(isFeatureEnabledProvider(AppFeature.cashDrawer));
    final isProfitLossEnabled = ref.watch(isFeatureEnabledProvider(AppFeature.profitLoss));
    final isInstallmentsEnabled = ref.watch(isFeatureEnabledProvider(AppFeature.installments));
    final isOffersEnabled = ref.watch(isFeatureEnabledProvider(AppFeature.offers));

    final hasShopSectionItems = isInventoryEnabled || isCashDrawerEnabled || isProfitLossEnabled || isInstallmentsEnabled;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.t.moreActions,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Banner for quick feature personalization
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 0,
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: const Icon(Icons.tune_rounded, color: Colors.white),
              ),
              title: Text(
                L10n.t.featureManagerTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                L10n.t.featureManagerSubtitle,
                style: TextStyle(fontSize: 12, color: AppColors.secondaryText(isDark)),
              ),
              trailing: Icon(
                L10n.isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
                color: theme.hintColor,
              ),
              onTap: () => context.push('/settings/features'),
            ),
          ),

          if (hasShopSectionItems) ...[
            _SectionHeader(title: L10n.t.moreSectionShop),
            const SizedBox(height: 8),
            if (isInventoryEnabled)
              _MoreTile(
                icon: Icons.inventory_2_rounded,
                color: AppColors.primaryBlueLight,
                title: L10n.t.inventoryTitle,
                subtitle: L10n.t.moreInventorySubtitle,
                isDark: isDark,
                onTap: () => context.push('/inventory'),
              ),
            if (isCashDrawerEnabled)
              _MoreTile(
                icon: Icons.account_balance_wallet_rounded,
                color: AppColors.paymentGreen,
                title: L10n.t.navCashDrawer,
                subtitle: L10n.t.moreCashDrawerSubtitle,
                isDark: isDark,
                onTap: () => context.push('/cash-drawer'),
              ),
            if (isProfitLossEnabled)
              _MoreTile(
                icon: Icons.trending_up_rounded,
                color: AppColors.paymentGreen,
                title: L10n.t.profitLossTitle,
                subtitle: 'صافي أرباح ومصروفات المحل',
                isDark: isDark,
                onTap: () => context.push('/profit-loss'),
              ),
            _MoreTile(
              icon: Icons.analytics_outlined,
              color: const Color(0xFF6366F1),
              title: L10n.t.shopReportTitle,
              subtitle: 'إجمالي البضاعة والفلوس والديون',
              isDark: isDark,
              onTap: () => context.push('/shop-overview'),
            ),
            if (isInstallmentsEnabled)
              _MoreTile(
                icon: Icons.receipt_long_rounded,
                color: AppColors.warningAmber,
                title: L10n.t.moreInstallmentsTitle,
                subtitle: L10n.t.moreInstallmentsSubtitle,
                isDark: isDark,
                onTap: () => context.push('/installments'),
              ),
            const SizedBox(height: 16),
          ],

          _SectionHeader(title: L10n.t.moreSectionApp),
          const SizedBox(height: 8),
          if (isOffersEnabled)
            _MoreTile(
              icon: Icons.campaign_rounded,
              color: AppColors.primaryBlue,
              title: L10n.t.offersBroadcasterTitle,
              subtitle: L10n.t.moreOffersSubtitle,
              isDark: isDark,
              onTap: () => context.push('/offers'),
            ),
          _MoreTile(
            icon: Icons.tune_rounded,
            color: theme.colorScheme.primary,
            title: L10n.t.featureManagerTitle,
            subtitle: L10n.t.featureManagerSubtitle,
            isDark: isDark,
            onTap: () => context.push('/settings/features'),
          ),
          _MoreTile(
            icon: Icons.settings_rounded,
            color: AppColors.neutralGrey,
            title: L10n.t.navSettings,
            subtitle: L10n.t.moreSettingsSubtitle,
            isDark: isDark,
            onTap: () => context.push('/settings'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final bool isDark;
  final VoidCallback onTap;

  const _MoreTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = AppColors.secondaryText(isDark);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.cardBorder(isDark)),
      ),
      child: ListTile(
        minVerticalPadding: 14,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: isDark ? 0.25 : 0.12),
          child: Icon(icon, color: isDark ? color.withValues(alpha: 0.9) : color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: secondaryColor),
        ),
        trailing: Icon(
          L10n.isRtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
          color: theme.hintColor,
        ),
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
      ),
    );
  }
}
