import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../core/constants/app_colors.dart';
import '../../features/collection/presentation/collection_providers.dart';
import '../../features/settings/data/settings_repository.dart';
import '../../features/settings/domain/app_features.dart';
import '../../l10n/app_localizations.dart';

/// Bottom navigation bar shell widget wrapping the primary sections.
/// Uses [GNav] (Google Nav Bar) to ensure selected tabs expand smoothly with a pill shape
/// and labels never wrap to multiple lines or cause horizontal overflow errors.
class ScaffoldWithNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final dueCustomersCount =
        ref.watch(dueCustomersStreamProvider).valueOrNull?.length ?? 0;
    final isQuickPosEnabled = ref.watch(
      isFeatureEnabledProvider(AppFeature.quickPos),
    );
    final isSuppliersEnabled = ref.watch(
      isFeatureEnabledProvider(AppFeature.suppliers),
    );

    // Dynamic branches mapping
    final items = <_NavBranchItem>[
      if (isQuickPosEnabled)
        _NavBranchItem(
          branchIndex: 0,
          icon: Icons.home_outlined,
          selectedIcon: Icons.home_rounded,
          label: l10n.navHome,
        ),
      _NavBranchItem(
        branchIndex: 1,
        icon: Icons.people_alt_outlined,
        selectedIcon: Icons.people_alt_rounded,
        label: l10n.navCustomers,
      ),
      _NavBranchItem(
        branchIndex: 2,
        icon: Icons.notifications_active_outlined,
        selectedIcon: Icons.notifications_active_rounded,
        label: l10n.navCollection,
        badgeCount: dueCustomersCount,
      ),
      if (isSuppliersEnabled)
        _NavBranchItem(
          branchIndex: 3,
          icon: Icons.local_shipping_outlined,
          selectedIcon: Icons.local_shipping_rounded,
          label: l10n.navSuppliers,
        ),
      _NavBranchItem(
        branchIndex: 4,
        icon: Icons.more_horiz_rounded,
        selectedIcon: Icons.more_horiz_rounded,
        label: l10n.moreActions,
      ),
    ];

    int visibleIndex = items.indexWhere(
      (item) => item.branchIndex == navigationShell.currentIndex,
    );
    if (visibleIndex == -1) {
      final fallbackIndex = items.indexWhere((item) => item.branchIndex == 1);
      visibleIndex = fallbackIndex != -1 ? fallbackIndex : 0;
    }

    final inactiveColor = isDark
        ? const Color(0xFF9CA3AF)
        : AppColors.neutralGrey;
    final activePillColor = isDark
        ? colorScheme.primary.withValues(alpha: 0.2)
        : AppColors.primaryBlue.withValues(alpha: 0.12);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 360;

          return Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? const Color(0xFF374151)
                      : const Color(0xFFE5E7EB),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 6.0 : 12.0,
                  vertical: 8.0,
                ),
                child: GNav(
                  selectedIndex: visibleIndex,
                  onTabChange: (idx) {
                    HapticFeedback.selectionClick();
                    final targetBranch = items[idx].branchIndex;
                    navigationShell.goBranch(
                      targetBranch,
                      initialLocation:
                          targetBranch == navigationShell.currentIndex,
                    );
                  },
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  gap: isNarrow ? 4 : 8,
                  iconSize: 22,
                  padding: EdgeInsets.symmetric(
                    horizontal: isNarrow ? 8 : 12,
                    vertical: 8,
                  ),
                  duration: const Duration(milliseconds: 250),
                  tabBackgroundColor: activePillColor,
                  activeColor: colorScheme.primary,
                  color: inactiveColor,
                  textStyle: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: isNarrow ? 11.5 : 13,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                  tabs: items.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final item = entry.value;
                    final isSelected = idx == visibleIndex;

                    Widget? leading;
                    if (item.badgeCount > 0) {
                      leading = Badge.count(
                        count: item.badgeCount,
                        child: Icon(
                          isSelected ? item.selectedIcon : item.icon,
                          size: 22,
                          color:
                              isSelected ? colorScheme.primary : inactiveColor,
                        ),
                      );
                    }

                    return GButton(
                      icon: isSelected ? item.selectedIcon : item.icon,
                      leading: leading,
                      text: item.label,
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NavBranchItem {
  final int branchIndex;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final int badgeCount;

  const _NavBranchItem({
    required this.branchIndex,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.badgeCount = 0,
  });
}
