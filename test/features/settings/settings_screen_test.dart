import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/theme/app_theme.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';
import 'package:kashkool/features/settings/presentation/settings_screen.dart';
import 'package:kashkool/l10n/app_localizations.dart';

void main() {
  testWidgets('SettingsScreen renders without errors when PIN is disabled', (tester) async {
    tester.view.physicalSize = const Size(360 * 2.0, 640 * 2.0);
    tester.view.devicePixelRatio = 2.0;

    final db = AppDatabase(NativeDatabase.memory());
    final settingsRepo = SettingsRepository(db);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          settingsRepositoryProvider.overrideWithValue(settingsRepo),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: SettingsScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('بيانات المحل 🏪'), findsOneWidget);
    expect(find.text('الحماية والخصوصية 🔒'), findsOneWidget);
    expect(find.text('قفل التطبيق برمز PIN (4 أرقام)'), findsOneWidget);
    expect(find.text('إعداد'), findsOneWidget);

    // Scroll until theme setting is visible
    await tester.scrollUntilVisible(find.text('مظهر التطبيق'), 200);
    await tester.pumpAndSettle();

    expect(find.text('مظهر التطبيق'), findsOneWidget);

    await db.close();
  });

  testWidgets('SettingsScreen renders and opens dialogs when PIN is enabled', (tester) async {
    tester.view.physicalSize = const Size(360 * 2.0, 640 * 2.0);
    tester.view.devicePixelRatio = 2.0;

    final db = AppDatabase(NativeDatabase.memory());
    final settingsRepo = SettingsRepository(db);
    // Setup existing PIN
    await settingsRepo.setPin(hash: 'somehash', salt: 'somesalt');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          settingsRepositoryProvider.overrideWithValue(settingsRepo),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: SettingsScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('مفعّل 🔒'), findsOneWidget);
    expect(find.text('فتح بالبصمة / Face ID'), findsOneWidget);

    // Scroll until lock timeout is visible
    await tester.scrollUntilVisible(find.text('مدة القفل التلقائي'), 200);
    await tester.pumpAndSettle();

    expect(find.text('مدة القفل التلقائي'), findsOneWidget);

    // Tap on lock timeout to open dialog
    await tester.tap(find.text('مدة القفل التلقائي'));
    await tester.pumpAndSettle();

    expect(find.text('بعد 5 دقائق'), findsOneWidget);
    await tester.tap(find.text('بعد 5 دقائق'));
    await tester.pumpAndSettle();

    // Verify setting was updated
    expect(await settingsRepo.getLockTimeoutMinutes(), equals(5));

    await db.close();
  });
}
