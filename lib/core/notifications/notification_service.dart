import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import '../utils/money.dart';
import '../../l10n/l10n.dart';
import 'reminder_notifier.dart';

/// Service managing local push notifications for daily collections.
class NotificationService implements ReminderNotifier {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Notification id of the daily collection reminder. The OS-scheduled fallback
  /// and the accurate reminder share it, so the user never sees two of them.
  static const int dailyReminderNotificationId = 1001;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool _isTimeZoneInitialized = false;

  /// The (hour, minute) currently scheduled on the OS, to avoid re-scheduling
  /// on every app resume / background worker run.
  int? _scheduledHour;
  int? _scheduledMinute;

  /// Initializes the local notification plugin with platform settings.
  Future<void> initialize({
    void Function(String? payload)? onNotificationTapped,
  }) async {
    if (_isInitialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (response) {
        if (onNotificationTapped != null) {
          onNotificationTapped(response.payload);
        }
      },
    );

    _isInitialized = true;
  }

  /// Requests notification permissions (Android 13+ & iOS).
  Future<bool> requestPermissions() async {
    try {
      final androidImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidImpl != null) {
        final granted = await androidImpl.requestNotificationsPermission();
        return granted ?? false;
      }

      final iosImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      if (iosImpl != null) {
        final granted = await iosImpl.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }

      return true;
    } catch (_) {
      return true;
    }
  }

  /// Checks if notification permission is currently granted.
  Future<bool> isPermissionGranted() async {
    try {
      final androidImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidImpl != null) {
        final granted = await androidImpl.areNotificationsEnabled();
        return granted ?? false;
      }
      return true;
    } catch (_) {
      return true;
    }
  }

  @override
  Future<bool> hasPermission() => isPermissionGranted();

  /// Loads the timezone database and applies the phone's timezone, so a
  /// reminder scheduled for 20:00 fires at 20:00 local time (DST included).
  Future<void> _ensureTimeZone() async {
    if (_isTimeZoneInitialized) return;

    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (e) {
      // Keep the default location; the daily alarm is still scheduled from the
      // device's local wall clock below.
      debugPrint('NotificationService: could not resolve timezone: $e');
    }
    _isTimeZoneInitialized = true;
  }

  /// The next occurrence of [hour]:[minute] in local time (today if still ahead).
  tz.TZDateTime _nextOccurrence(int hour, int minute) {
    final now = DateTime.now();
    var next = DateTime(now.year, now.month, now.day, hour, minute);
    if (!next.isAfter(now)) {
      next = next.add(const Duration(days: 1));
    }
    return tz.TZDateTime.from(next, tz.local);
  }

  AndroidNotificationDetails get _collectionAndroidDetails => AndroidNotificationDetails(
        'daily_collection_channel',
        L10n.t.notificationService1,
        channelDescription: L10n.t.notificationService2,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        showWhen: true,
      );

  /// Schedules a daily reminder at [hour]:[minute] that Android fires on its own,
  /// even if the app process is closed or the phone was rebooted.
  ///
  /// This is the safety net for the background worker: aggressive OEM battery
  /// managers throttle WorkManager, but the OS alarm still fires.
  @override
  Future<void> scheduleDailyReminder({required int hour, required int minute}) async {
    if (_scheduledHour == hour && _scheduledMinute == minute) return;

    await initialize();
    await _ensureTimeZone();

    // Android 12+ exact alarms may be denied; fall back to an inexact alarm
    // instead of failing the daily reminder completely.
    var scheduleMode = AndroidScheduleMode.inexactAllowWhileIdle;
    try {
      final androidImpl = _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      final canExact = await androidImpl?.canScheduleExactNotifications();
      if (canExact == true) {
        scheduleMode = AndroidScheduleMode.exactAllowWhileIdle;
      }
    } catch (_) {}

    await _notificationsPlugin.zonedSchedule(
      id: dailyReminderNotificationId,
      title: L10n.t.notificationServiceDailyScheduledTitle,
      body: L10n.t.notificationServiceDailyScheduledBody,
      scheduledDate: _nextOccurrence(hour, minute),
      notificationDetails: NotificationDetails(
        android: _collectionAndroidDetails,
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: scheduleMode,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '/collection',
    );

    _scheduledHour = hour;
    _scheduledMinute = minute;
  }

  /// Cancels the OS-scheduled daily reminder (notifications off, or nothing due).
  @override
  Future<void> cancelDailyReminder() async {
    final hadSchedule = _scheduledHour != null || _scheduledMinute != null;
    _scheduledHour = null;
    _scheduledMinute = null;

    try {
      await _notificationsPlugin.cancel(id: dailyReminderNotificationId);
    } catch (e) {
      if (hadSchedule) {
        debugPrint('NotificationService: could not cancel daily reminder: $e');
      }
    }
  }

  /// Displays an immediate notification for daily collection reminder.
  /// Skips if dueCount <= 0.
  @override
  Future<void> showCollectionNotification({
    required int dueCount,
    required int totalPiasters,
  }) async {
    if (dueCount <= 0) return;

    final notificationDetails = NotificationDetails(
      android: _collectionAndroidDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    final amountStr = MoneyUtils.formatMoney(totalPiasters);
    final body = L10n.t.notificationService3(dueCount, amountStr);

    await _notificationsPlugin.show(
      id: dailyReminderNotificationId,
      title: L10n.t.notificationService4,
      body: body,
      notificationDetails: notificationDetails,
      payload: '/collection',
    );
  }

  /// Displays an immediate notification for due and overdue installments.
  @override
  Future<void> showDueInstallmentsNotification({
    required int count,
    required int totalPiasters,
  }) async {
    if (count <= 0) return;

    final androidDetails = AndroidNotificationDetails(
      'due_installments_channel',
      L10n.t.notificationServiceInstallmentsChannelName,
      channelDescription: L10n.t.notificationServiceInstallmentsChannelDesc,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      showWhen: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    final amountStr = MoneyUtils.formatMoney(totalPiasters);
    final body = L10n.t.notificationServiceInstallmentsBody(count, amountStr);

    await _notificationsPlugin.show(
      id: 1002,
      title: L10n.t.notificationServiceInstallmentsTitle,
      body: body,
      notificationDetails: notificationDetails,
      payload: '/collection',
    );
  }

  /// Displays a notification reminding the user to take a backup.
  @override
  Future<void> showBackupReminderNotification({
    required int daysSinceBackup,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'backup_reminder_channel',
      L10n.t.notificationServiceBackupChannelName,
      channelDescription: L10n.t.notificationServiceBackupChannelDesc,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      showWhen: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notificationsPlugin.show(
      id: 1003,
      title: L10n.t.notificationServiceBackupTitle,
      body: L10n.t.notificationServiceBackupBody(daysSinceBackup),
      notificationDetails: notificationDetails,
      payload: '/settings',
    );
  }

  /// Displays an immediate notification for a single item that reached low stock.
  @override
  Future<void> showLowStockNotification({
    required String productName,
    required String remainingStock,
    String? supplierName,
    String? supplierPhone,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'low_stock_channel',
      'تنبيهات نواقص البضاعة',
      channelDescription: 'تنبيه فوري عند وصول أي صنف للحد الأدنى من المخزون',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      showWhen: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    String body = 'المتبقي بالمخزن: $remainingStock.';
    if (supplierName != null && supplierName.isNotEmpty) {
      body += ' المورد: $supplierName — اضغط لطلب البضاعة عبر واتساب';
    } else {
      body += ' اضغط لتفقد المخزون وتحديث النواقص';
    }

    final notifId = 2000 + (productName.hashCode.abs() % 900);
    await _notificationsPlugin.show(
      id: notifId,
      title: '⚠️ بضاعة وصلت للنواقص: $productName',
      body: body,
      notificationDetails: notificationDetails,
      payload: '/inventory',
    );
  }

  /// Displays a notification when multiple items need restocking.
  @override
  Future<void> showMultipleLowStockNotification({
    required int count,
  }) async {
    if (count <= 0) return;

    const androidDetails = AndroidNotificationDetails(
      'low_stock_channel',
      'تنبيهات نواقص البضاعة',
      channelDescription: 'تنبيه فوري عند وصول أي صنف للحد الأدنى من المخزون',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      showWhen: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notificationsPlugin.show(
      id: 2999,
      title: '⚠️ تنبيه: يوجد $count أصناف وصلت لحد النواقص!',
      body: 'افحص قائمة النواقص في المخزون لطلبها من الموردين فوراً.',
      notificationDetails: notificationDetails,
      payload: '/inventory',
    );
  }

  /// Displays a test notification to verify delivery and permissions immediately.
  Future<void> showTestNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'kashkool_general_channel',
      'إشعارات كشكول',
      channelDescription: 'إشعارات عامة وتجريبية',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      showWhen: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notificationsPlugin.show(
      id: 9999,
      title: L10n.t.notificationServiceTestTitle,
      body: L10n.t.notificationServiceTestBody,
      notificationDetails: notificationDetails,
      payload: '/settings',
    );
  }
}

/// Provider for NotificationService instance.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});
