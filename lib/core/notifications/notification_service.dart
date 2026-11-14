import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/money.dart';
import '../../l10n/l10n.dart';

/// Service managing local push notifications for daily collections.
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

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

  /// Displays an immediate notification for daily collection reminder.
  /// Skips if dueCount <= 0.
  Future<void> showCollectionNotification({
    required int dueCount,
    required int totalPiasters,
  }) async {
    if (dueCount <= 0) return;

    final androidDetails = AndroidNotificationDetails(
      'daily_collection_channel',
      L10n.t.notificationService1,
      channelDescription: L10n.t.notificationService2,
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
    final body = L10n.t.notificationService3(dueCount, amountStr);

    await _notificationsPlugin.show(
      id: 1001,
      title: L10n.t.notificationService4,
      body: body,
      notificationDetails: notificationDetails,
      payload: '/collection',
    );
  }

  /// Displays an immediate notification for due and overdue installments.
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

  /// Displays a test notification to verify delivery and permissions immediately.
  Future<void> showTestNotification() async {
    final androidDetails = AndroidNotificationDetails(
      'kashkool_general_channel',
      'إشعارات كشكول',
      channelDescription: 'إشعارات عامة وتجريبية',
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
