import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/collection/presentation/collection_providers.dart';
import '../../features/settings/data/settings_repository.dart';
import '../../features/settings/domain/app_features.dart';
import '../../l10n/app_localizations.dart';

/// Bottom navigation bar shell widget wrapping the primary sections.
/// Less used tools (inventory, cash drawer, installments, offers, settings)
/// live under the "More" tab to keep the bar readable on small phones.
///
/// Quick POS and Suppliers can be dynamically hidden if disabled by shop settings.
class ScaffoldWithNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dueCustomersCount = ref.watch(dueCustomersStreamProvider).valueOrNull?.length ?? 0;
    final isQuickPosEnabled = ref.watch(isFeatureEnabledProvider(AppFeature.quickPos));
    final isSuppliersEnabled = ref.watch(isFeatureEnabledProvider(AppFeature.suppliers));

    // Dynamic branches mapping
    final items = <_NavBranchItem>[
      if (isQuickPosEnabled)
        _NavBranchItem(
          branchIndex: 0,
          destination: NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: l10n.navHome,
          ),
        ),
      _NavBranchItem(
        branchIndex: 1,
        destination: NavigationDestination(
          icon: const Icon(Icons.people_alt_outlined),
          selectedIcon: const Icon(Icons.people_alt_rounded),
          label: l10n.navCustomers,
        ),
      ),
      _NavBranchItem(
        branchIndex: 2,
        destination: NavigationDestination(
          icon: Badge.count(
            count: dueCustomersCount,
            isLabelVisible: dueCustomersCount > 0,
            child: const Icon(Icons.notifications_active_outlined),
          ),
          selectedIcon: Badge.count(
            count: dueCustomersCount,
            isLabelVisible: dueCustomersCount > 0,
            child: const Icon(Icons.notifications_active_rounded),
          ),
          label: l10n.navCollection,
        ),
      ),
      if (isSuppliersEnabled)
        _NavBranchItem(
          branchIndex: 3,
          destination: NavigationDestination(
            icon: const Icon(Icons.local_shipping_outlined),
            selectedIcon: const Icon(Icons.local_shipping_rounded),
            label: l10n.navSuppliers,
          ),
        ),
      _NavBranchItem(
        branchIndex: 4,
        destination: NavigationDestination(
          icon: const Icon(Icons.more_horiz_rounded),
          selectedIcon: const Icon(Icons.more_horiz_rounded),
          label: l10n.moreActions,
        ),
      ),
    ];

    int visibleIndex = items.indexWhere((item) => item.branchIndex == navigationShell.currentIndex);
    if (visibleIndex == -1) {
      final fallbackIndex = items.indexWhere((item) => item.branchIndex == 1);
      visibleIndex = fallbackIndex != -1 ? fallbackIndex : 0;
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: visibleIndex,
        onDestinationSelected: (idx) {
          HapticFeedback.selectionClick();
          final targetBranch = items[idx].branchIndex;
          navigationShell.goBranch(
            targetBranch,
            initialLocation: targetBranch == navigationShell.currentIndex,
          );
        },
        destinations: items.map((e) => e.destination).toList(),
      ),
    );
  }
}

class _NavBranchItem {
  final int branchIndex;
  final NavigationDestination destination;

  const _NavBranchItem({
    required this.branchIndex,
    required this.destination,
  });
}
