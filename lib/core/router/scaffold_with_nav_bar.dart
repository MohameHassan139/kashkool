import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/collection/presentation/collection_providers.dart';
import '../../l10n/app_localizations.dart';

/// Bottom navigation bar shell widget wrapping the primary 5 sections.
/// Less used tools (inventory, cash drawer, installments, offers, settings)
/// live under the "More" tab to keep the bar readable on small phones.
class ScaffoldWithNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  void _onDestinationSelected(int index) {
    HapticFeedback.selectionClick();
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dueCustomersCount = ref.watch(dueCustomersStreamProvider).valueOrNull?.length ?? 0;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_alt_outlined),
            selectedIcon: const Icon(Icons.people_alt_rounded),
            label: l10n.navCustomers,
          ),
          NavigationDestination(
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
          NavigationDestination(
            icon: const Icon(Icons.local_shipping_outlined),
            selectedIcon: const Icon(Icons.local_shipping_rounded),
            label: l10n.navSuppliers,
          ),
          NavigationDestination(
            icon: const Icon(Icons.more_horiz_rounded),
            selectedIcon: const Icon(Icons.more_horiz_rounded),
            label: l10n.moreActions,
          ),
        ],
      ),
    );
  }
}
