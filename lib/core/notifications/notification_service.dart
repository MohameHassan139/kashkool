import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../utils/money.dart';

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
  }

  /// Displays an immediate notification for daily collection reminder.
  /// Skips if dueCount <= 0.
  Future<void> showCollectionNotification({
    required int dueCount,
    required int totalPiasters,
  }) async {
    if (dueCount <= 0) return;

    const androidDetails = AndroidNotificationDetails(
      'daily_collection_channel',
      'التحصيل اليومي',
      channelDescription: 'تذكير بالعملاء المستحقين للتحصيل ومواعيد دفعهم',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    final amountStr = MoneyUtils.formatMoney(totalPiasters);
    final body = 'عندك $dueCount عملاء عليهم $amountStr — اضغط للتحصيل';

    await _notificationsPlugin.show(
      id: 1001,
      title: 'تذكير التحصيل اليومي 📒',
      body: body,
      notificationDetails: notificationDetails,
      payload: '/collection',
    );
  }
}
