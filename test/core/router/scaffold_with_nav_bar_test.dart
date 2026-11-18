import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kashkool/core/router/scaffold_with_nav_bar.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';
import 'package:kashkool/features/settings/domain/app_features.dart';
import 'package:kashkool/l10n/app_localizations.dart';

void main() {
  testWidgets('ScaffoldWithNavBar renders GNav and buttons without overflow on narrow screen', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 640 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    int currentBranch = 1;

    final router = GoRouter(
      initialLocation: '/customers',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            currentBranch = navigationShell.currentIndex;
            return ScaffoldWithNavBar(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  builder: (context, state) => const Text('Home Page'),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/customers',
                  builder: (context, state) => const Text('Customers Page'),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/collection',
                  builder: (context, state) => const Text('Collection Page'),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/suppliers',
                  builder: (context, state) => const Text('Suppliers Page'),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/more',
                  builder: (context, state) => const Text('More Page'),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          isFeatureEnabledProvider(AppFeature.quickPos).overrideWithValue(true),
          isFeatureEnabledProvider(AppFeature.suppliers).overrideWithValue(true),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          locale: const Locale('ar'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(GNav), findsOneWidget);
    expect(find.byType(GButton), findsNWidgets(5));
    expect(find.text('Customers Page'), findsOneWidget);
    expect(currentBranch, 1);
    expect(tester.takeException(), isNull);

    // Tap first tab (Home)
    await tester.tap(find.byType(GButton).first);
    await tester.pumpAndSettle();
    expect(find.text('Home Page'), findsOneWidget);
    expect(currentBranch, 0);
    expect(tester.takeException(), isNull);

    // Tap last tab (More)
    await tester.tap(find.byType(GButton).last);
    await tester.pumpAndSettle();
    expect(find.text('More Page'), findsOneWidget);
    expect(currentBranch, 4);
    expect(tester.takeException(), isNull);
  });
}
