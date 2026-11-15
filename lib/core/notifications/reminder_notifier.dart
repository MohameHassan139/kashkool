/// The notification operations the reminder logic needs.
///
/// Kept as an interface so [ReminderEvaluator] can run both in the app isolate
/// (through [NotificationService]) and in the WorkManager background isolate,
/// and so reminder decisions can be unit tested without platform channels.
abstract interface class ReminderNotifier {
  /// Whether the OS currently allows this app to post notifications.
  Future<bool> hasPermission();

  /// Posts the daily collection reminder with the real due count and amount.
  Future<void> showCollectionNotification({
    required int dueCount,
    required int totalPiasters,
  });

  /// Posts the reminder for due and overdue installments.
  Future<void> showDueInstallmentsNotification({
    required int count,
    required int totalPiasters,
  });

  /// Posts the "time to back up" reminder.
  Future<void> showBackupReminderNotification({required int daysSinceBackup});

  /// Posts a reminder for a single product that reached its minimum stock.
  Future<void> showLowStockNotification({
    required String productName,
    required String remainingStock,
    String? supplierName,
    String? supplierPhone,
  });

  /// Posts a single reminder when several products reached their minimum stock.
  Future<void> showMultipleLowStockNotification({required int count});

  /// Schedules the daily OS-level reminder (fires even when the app is closed).
  Future<void> scheduleDailyReminder({required int hour, required int minute});

  /// Cancels the daily OS-level reminder.
  Future<void> cancelDailyReminder();
}
