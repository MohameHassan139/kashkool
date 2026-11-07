import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/cash_drawer/presentation/cash_drawer_screen.dart';
import '../../features/collection/presentation/collection_screen.dart';
import '../../features/customers/presentation/customers_screen.dart';
import '../../features/installments/presentation/add_installment_plan_screen.dart';
import '../../features/installments/presentation/installment_plan_details_screen.dart';
import '../../features/installments/presentation/installments_screen.dart';
import '../../features/onboarding/data/shop_repository.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
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
      return '/';
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // 1. العملاء (Customers)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const CustomersScreen(),
              ),
            ],
          ),
          // 2. التحصيل (Collection)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/collection',
                builder: (context, state) => const CollectionScreen(),
              ),
            ],
          ),
          // 3. الموردين (Suppliers)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/suppliers',
                builder: (context, state) => const SuppliersScreen(),
              ),
            ],
          ),
          // 4. الدرج (Cash Drawer)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cash-drawer',
                builder: (context, state) => const CashDrawerScreen(),
              ),
            ],
          ),
          // 5. الإعدادات (Settings)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
