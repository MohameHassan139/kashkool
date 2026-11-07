import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/home_widget_service.dart';
import 'core/widgets/home_widget_sync_coordinator.dart';
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

    return MaterialApp.router(
      title: 'كشكول',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      locale: const Locale('ar'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
