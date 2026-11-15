import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/cash_drawer/presentation/cash_drawer_screen.dart';
import '../../features/collection/presentation/collection_screen.dart';
import '../../features/customers/presentation/customers_screen.dart';
import '../../features/installments/presentation/add_installment_plan_screen.dart';
import '../../features/installments/presentation/installment_plan_details_screen.dart';
import '../../features/installments/presentation/installments_screen.dart';
import '../../features/inventory/presentation/inventory_screen.dart';
import '../../features/more/presentation/more_screen.dart';
import '../../features/offers_broadcaster/presentation/offers_broadcaster_screen.dart';
import '../../features/offers_broadcaster/presentation/offers_queue_screen.dart';
import '../../features/onboarding/data/shop_repository.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/quick_pos/presentation/quick_pos_screen.dart';
import '../../features/reports/presentation/profit_loss_screen.dart';
import '../../features/reports/presentation/shop_financial_report_screen.dart';
import '../../features/settings/data/settings_repository.dart';
import '../../features/settings/domain/app_features.dart';
import '../../features/settings/presentation/feature_manager_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/suppliers/presentation/suppliers_screen.dart';
import 'scaffold_with_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Router notifier coordinating onboarding redirects with Riverpod
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(isOnboardingCompletedStreamProvider, (_, _) {
      notifyListeners();
    });
    _ref.listen(enabledFeaturesStreamProvider, (_, _) {
      notifyListeners();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final onboardingState = _ref.read(isOnboardingCompletedStreamProvider);
    final isComplete = onboardingState.valueOrNull ?? false;
    final isGoingToOnboarding = state.matchedLocation == '/onboarding';

    if (onboardingState.isLoading) return null;

    if (!isComplete && !isGoingToOnboarding) {
      return '/onboarding';
    }
    if (isComplete && isGoingToOnboarding) {
      final isQuickPosEnabled = _ref.read(isFeatureEnabledProvider(AppFeature.quickPos));
      return isQuickPosEnabled ? '/' : '/customers';
    }

    if (isComplete && (state.matchedLocation == '/' || state.matchedLocation == '/pos')) {
      final isQuickPosEnabled = _ref.read(isFeatureEnabledProvider(AppFeature.quickPos));
      if (!isQuickPosEnabled) {
        return '/customers';
      }
    }

    if (isComplete && state.matchedLocation == '/suppliers') {
      final isSuppliersEnabled = _ref.read(isFeatureEnabledProvider(AppFeature.suppliers));
      if (!isSuppliersEnabled) {
        return '/customers';
      }
    }

    return null;
  }
}

/// Main GoRouter provider for the app
final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/pos',
        builder: (context, state) {
          final customerId = state.uri.queryParameters['customerId'];
          return QuickPosScreen(initialCustomerId: customerId);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/offers',
        builder: (context, state) => const OffersBroadcasterScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'queue',
            builder: (context, state) => const OffersQueueScreen(),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/installments',
        builder: (context, state) => const InstallmentsScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'new',
            builder: (context, state) {
              final customerId = state.uri.queryParameters['customerId'];
              return AddInstallmentPlanScreen(initialCustomerId: customerId);
            },
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: ':id',
            builder: (context, state) {
              final planId = state.pathParameters['id']!;
              return InstallmentPlanDetailsScreen(planId: planId);
            },
          ),
        ],
      ),
      // Tools grouped under the "More" tab. They live outside the shell so the
      // bottom bar stays focused on the five main sections.
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/inventory',
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/cash-drawer',
        builder: (context, state) => const CashDrawerScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'features',
            builder: (context, state) => const FeatureManagerScreen(),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/profit-loss',
        builder: (context, state) => const ProfitLossScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/shop-overview',
        builder: (context, state) => const ShopFinancialReportScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // 1. نقطة البيع والدفع السريع (Pay / Quick POS Home Page)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const QuickPosScreen(),
              ),
            ],
          ),
          // 2. العملاء (Customers)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/customers',
                builder: (context, state) => const CustomersScreen(),
              ),
            ],
          ),
          // 3. التحصيل (Collection)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/collection',
                builder: (context, state) => const CollectionScreen(),
              ),
            ],
          ),
          // 4. الموردين (Suppliers)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/suppliers',
                builder: (context, state) => const SuppliersScreen(),
              ),
            ],
          ),
          // 5. المزيد (More): inventory, cash drawer, installments, offers, settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/more',
                builder: (context, state) => const MoreScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
