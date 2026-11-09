import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'core/cloud/auto_backup_coordinator.dart';
import 'core/router/app_router.dart';
import 'core/security/app_lock_wrapper.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/home_widget_service.dart';
import 'core/widgets/home_widget_sync_coordinator.dart';
import 'features/settings/data/settings_repository.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // On Android, configure SQLCipher native library before any database access
  if (Platform.isAndroid) {
    try {
      await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
    } catch (_) {}
    open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
  }

  // Read the saved language before the first frame, so the app doesn't flash in another language.
  final container = ProviderContainer();
  String? languageCode;
  try {
    languageCode = await container.read(settingsRepositoryProvider).getLanguageCode();
  } catch (_) {}

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: KashkoolApp(initialLanguageCode: languageCode),
    ),
  );
}

class KashkoolApp extends ConsumerStatefulWidget {
  final String? initialLanguageCode;

  const KashkoolApp({super.key, this.initialLanguageCode});

  @override
  ConsumerState<KashkoolApp> createState() => _KashkoolAppState();
}

class _KashkoolAppState extends ConsumerState<KashkoolApp> {
  @override
  void initState() {
    super.initState();
    // Initialize Home Widget sync coordinator
    ref.read(homeWidgetSyncCoordinatorProvider);

    // Automatic cloud backup (when signed in): on reconnect, after changes, on resume
    ref.read(autoBackupCoordinatorProvider);

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

  static void _rebuildEverything() {
    void mark(Element element) {
      element.markNeedsBuild();
      element.visitChildren(mark);
    }

    WidgetsBinding.instance.rootElement?.visitChildren(mark);
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;
    final languageCode = ref.watch(languageCodeProvider).valueOrNull ?? widget.initialLanguageCode;

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      // null = follow the phone's language (see L10n.resolve).
      locale: L10n.localeForCode(languageCode),
      localeListResolutionCallback: (deviceLocales, supported) =>
          L10n.localeForCode(languageCode) ?? L10n.resolve(deviceLocales),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) {
        // Text direction comes from the language (RTL for Arabic, Urdu and Persian).
        final locale = Localizations.localeOf(context);
        if (locale != L10n.locale) {
          L10n.setLocale(locale);
          // Screens and helpers that read L10n.t don't depend on Localizations, so after a
          // language change rebuild every widget once (open screens keep their state).
          WidgetsBinding.instance.addPostFrameCallback((_) => _rebuildEverything());
        }
        return AppLockWrapper(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
