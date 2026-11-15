import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:workmanager/workmanager.dart';

import '../../features/settings/data/settings_repository.dart';
import '../../l10n/l10n.dart';
import 'notification_service.dart';
import 'reminder_evaluator.dart';

/// Unique name of the periodic WorkManager task that keeps the daily reminder
/// alive while the app is closed.
const String dailyReminderTaskName = 'kashkool_daily_reminder';

/// WorkManager's minimum periodic interval (Android limitation).
const Duration dailyReminderFrequency = Duration(minutes: 15);

/// Runs on every periodic wake-up, in a dedicated background isolate.
///
/// Must stay a top-level function annotated with `@pragma('vm:entry-point')`,
/// otherwise release builds strip it and the worker never runs.
@pragma('vm:entry-point')
void reminderCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    _configureSqlCipher();

    final container = ProviderContainer();
    try {
      // Translations in the background isolate: services read `L10n.t`.
      final settings = container.read(settingsRepositoryProvider);
      L10n.setLocale(await _resolveLocale(settings));

      await container.read(notificationServiceProvider).initialize();

      final result = await container.read(reminderEvaluatorProvider).run();
      debugPrint('Kashkool background reminder: $result');
      return true;
    } catch (e) {
      debugPrint('Kashkool background reminder failed: $e');
      // Returning true avoids WorkManager's retry storm; the next periodic run
      // (15 minutes later) tries again anyway.
      return true;
    } finally {
      container.dispose();
    }
  });
}

/// The SQLCipher native library overrides that `main()` applies for the UI
/// isolate are per-isolate, so the worker needs them too.
void _configureSqlCipher() {
  if (!Platform.isAndroid) return;
  try {
    applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
  } catch (_) {}
  open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
}

Future<Locale> _resolveLocale(SettingsRepository settings) async {
  final saved = await settings.getLanguageCode();
  final explicit = L10n.localeForCode(saved);
  if (explicit != null) return explicit;

  final platformLocales = WidgetsBinding.instance.platformDispatcher.locales;
  if (platformLocales.isEmpty) return L10n.fallback;
  return L10n.resolve(platformLocales);
}

/// Registers the periodic reminder worker. Safe to call on every app start:
/// WorkManager keeps the existing task unless it is gone.
Future<void> initializeBackgroundReminderWorker() async {
  if (kIsWeb || !Platform.isAndroid) return;

  try {
    await Workmanager().initialize(reminderCallbackDispatcher);
    await Workmanager().registerPeriodicTask(
      dailyReminderTaskName,
      dailyReminderTaskName,
      frequency: dailyReminderFrequency,
      initialDelay: const Duration(minutes: 1),
      constraints: Constraints(networkType: NetworkType.notRequired),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
      backoffPolicy: BackoffPolicy.linear,
      backoffPolicyDelay: const Duration(minutes: 10),
    );
  } catch (e) {
    debugPrint('Kashkool: could not register the background reminder worker: $e');
  }
}
