import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/security/app_lock_wrapper.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/home_widget_service.dart';
import 'core/widgets/home_widget_sync_coordinator.dart';
import 'features/settings/data/settings_repository.dart';
import 'l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: KashkoolApp(),
    ),
  );
}

class KashkoolApp extends ConsumerStatefulWidget {
  const KashkoolApp({super.key});

  @override
  ConsumerState<KashkoolApp> createState() => _KashkoolAppState();
}

class _KashkoolAppState extends ConsumerState<KashkoolApp> {
  @override
  void initState() {
    super.initState();
    // Initialize Home Widget sync coordinator
    ref.read(homeWidgetSyncCoordinatorProvider);

    // Ensure the stable shop referral code exists from first launch (Feature 11)
    ref.read(settingsRepositoryProvider).getOrCreateShopCode();

    // Setup Home Widget deep link routing
    final homeWidgetService = ref.read(homeWidgetServiceProvider);
    homeWidgetService.init(
      onDeepLink: (uri) {
        final router = ref.read(routerProvider);
        if (uri.scheme == 'kashkool') {
          if (uri.host == 'collection' || uri.path.contains('collection')) {
            router.go('/collection');
          } else {
            router.go('/');
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;

    return MaterialApp.router(
      title: 'كشكول',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: const Locale('ar'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AppLockWrapper(child: child ?? const SizedBox.shrink()),
        );
      },
    );
  }
}
