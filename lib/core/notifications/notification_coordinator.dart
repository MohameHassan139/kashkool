import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../router/app_router.dart';
import '../../features/settings/data/settings_repository.dart';
import 'background_reminder_worker.dart';
import 'notification_service.dart';
import 'reminder_evaluator.dart';

/// Global provider for NotificationCoordinator.
/// Initialized once in `main.dart`.
final notificationCoordinatorProvider = Provider<NotificationCoordinator>((ref) {
  final coordinator = NotificationCoordinator(ref);
  ref.onDispose(coordinator.dispose);
  coordinator.start();
  return coordinator;
});

/// Coordinates notifications and reminders:
/// 1. Initializes local notifications plugin with deep-link navigation on tap.
/// 2. Schedules the OS-level daily alarm (fires with the app closed).
/// 3. Registers the WorkManager worker that posts accurate reminders in the
///    background and refreshes that alarm.
/// 4. Listens to app lifecycle (onResume) and settings changes to re-evaluate
///    immediately (fallback for aggressive OEM battery killers).
class NotificationCoordinator {
  final Ref _ref;
  final NotificationService _service = NotificationService();

  AppLifecycleListener? _lifecycle;
  Timer? _periodicTimer;
  Timer? _initialCheckTimer;
  bool _disposed = false;
  bool _isChecking = false;

  NotificationCoordinator(this._ref);

  void start() {
    if (Platform.environment.containsKey('FLUTTER_TEST')) return;

    // Initialize notification plugin with deep-link handler
    _service.initialize(
      onNotificationTapped: (payload) {
        if (payload != null && payload.isNotEmpty) {
          _navigate(payload);
        }
      },
    );

    // Tapping a notification while the app was terminated launches it; the
    // payload is only available once, so route after the first frame.
    unawaited(_handleLaunchPayload());

    // Background worker that keeps reminders accurate while the app is closed.
    unawaited(initializeBackgroundReminderWorker());

    // Recompute on app resume (defends against aggressive OEM battery killers)
    try {
      _lifecycle = AppLifecycleListener(
        onResume: () => checkAndTriggerReminders(isResume: true),
      );
    } catch (_) {
      // No WidgetsBinding in headless environments
    }

    // Re-sync as soon as the user changes the reminder time or toggles
    // notifications, instead of waiting for the next periodic check.
    _ref.listen(notificationsEnabledProvider, (_, _) => _recheck());
    _ref.listen(reminderTimeHourProvider, (_, _) => _recheck());
    _ref.listen(reminderTimeMinuteProvider, (_, _) => _recheck());

    // Check periodically (every 15 minutes) while app is open
    _periodicTimer = Timer.periodic(
      const Duration(minutes: 15),
      (_) => checkAndTriggerReminders(),
    );

    // Initial check shortly after launch (2 seconds)
    _initialCheckTimer = Timer(
      const Duration(seconds: 2),
      () => checkAndTriggerReminders(isResume: true),
    );
  }

  void _recheck() {
    if (_disposed) return;
    unawaited(checkAndTriggerReminders());
  }

  Future<void> _handleLaunchPayload() async {
    final payload = await _service.getLaunchPayload();
    if (payload == null || payload.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_disposed) _navigate(payload);
    });
  }

  void _navigate(String payload) {
    try {
      final router = _ref.read(routerProvider);
      const tabLocations = {'/', '/customers', '/collection', '/suppliers', '/more'};
      if (tabLocations.contains(payload)) {
        router.go(payload);
      } else {
        // Screens outside the tab shell (e.g. /settings from the backup
        // reminder) are pushed so the user always has a way back.
        unawaited(router.push(payload));
      }
    } catch (e) {
      debugPrint('NotificationCoordinator: failed to navigate to $payload: $e');
    }
  }

  void dispose() {
    _disposed = true;
    _lifecycle?.dispose();
    _periodicTimer?.cancel();
    _initialCheckTimer?.cancel();
  }

  /// Evaluates whether notifications should be triggered right now.
  Future<void> checkAndTriggerReminders({bool isResume = false}) async {
    if (_disposed || _isChecking) return;
    _isChecking = true;

    try {
      await _ref.read(reminderEvaluatorProvider).run();
    } catch (e) {
      debugPrint('NotificationCoordinator error: $e');
    } finally {
      _isChecking = false;
    }
  }

  /// Sends a test notification immediately and returns success status.
  Future<bool> sendTestNotification() async {
    try {
      await _service.showTestNotification();
      return true;
    } catch (e) {
      debugPrint('NotificationCoordinator: sendTestNotification error: $e');
      return false;
    }
  }

  /// Requests notification permission from user.
  Future<bool> requestPermissions() async {
    final granted = await _service.requestPermissions();
    // Permission may have just been granted: evaluate and schedule right away.
    _recheck();
    return granted;
  }
}
