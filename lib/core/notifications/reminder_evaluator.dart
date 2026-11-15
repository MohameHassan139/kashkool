import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/app_database.dart';
import '../../features/collection/data/collection_repository.dart';
import '../../features/installments/data/installment_repository.dart';
import '../../features/settings/data/settings_repository.dart';
import 'notification_service.dart';
import 'reminder_notifier.dart';

/// Outcome of one reminder evaluation, so callers (and tests) can tell why
/// nothing was shown.
@immutable
class ReminderRunResult {
  /// False when notifications are turned off in settings or blocked by the OS.
  final bool notificationsEnabled;

  /// Number of customers with money due today.
  final int dueCustomerCount;

  /// Number of installments due or overdue.
  final int dueInstallmentCount;

  /// True when at least one notification was actually posted.
  final bool showedAny;

  const ReminderRunResult({
    required this.notificationsEnabled,
    required this.dueCustomerCount,
    required this.dueInstallmentCount,
    required this.showedAny,
  });

  static const ReminderRunResult disabled = ReminderRunResult(
    notificationsEnabled: false,
    dueCustomerCount: 0,
    dueInstallmentCount: 0,
    showedAny: false,
  );

  @override
  String toString() => 'ReminderRunResult(enabled: $notificationsEnabled, '
      'dueCustomers: $dueCustomerCount, dueInstallments: $dueInstallmentCount, '
      'showedAny: $showedAny)';
}

/// Evaluates every Kashkool reminder and posts the ones that are due.
///
/// This is the single source of truth used by both:
/// - [NotificationCoordinator] while the app is running, and
/// - the WorkManager background isolate (see `background_reminder_worker.dart`)
///   when the app is closed.
class ReminderEvaluator {
  final AppDatabase db;
  final SettingsRepository settings;
  final CollectionRepository collection;
  final InstallmentRepository installments;
  final ReminderNotifier notifier;
  final DateTime Function() _clock;

  ReminderEvaluator({
    required this.db,
    required this.settings,
    required this.collection,
    required this.installments,
    required this.notifier,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  /// Runs every check once. Never throws: a failing check must not stop the
  /// daily reminder schedule from being refreshed.
  Future<ReminderRunResult> run() async {
    var dueCustomerCount = 0;
    var dueInstallmentCount = 0;
    var showedAny = false;

    try {
      // 1. User setting
      if (!await settings.getNotificationsEnabled()) {
        await _cancelScheduleQuietly();
        return ReminderRunResult.disabled;
      }

      // 2. OS permission
      if (!await notifier.hasPermission()) {
        await _cancelScheduleQuietly();
        return ReminderRunResult.disabled;
      }

      final now = _clock();
      final todayStr = _dateKey(now);

      final reminderHour = await settings.getReminderTimeHour();
      final reminderMinute = await settings.getReminderTimeMinute();
      final isTimeDue = now.hour > reminderHour ||
          (now.hour == reminderHour && now.minute >= reminderMinute);

      // --- Daily collection reminder (Feature 07) ---
      final summary = await collection.watchDueSummary().first;
      dueCustomerCount = summary.count;

      final lastCollectionDate = await settings.getLastCollectionReminderDate();
      if (lastCollectionDate != todayStr && isTimeDue && summary.count > 0) {
        await notifier.showCollectionNotification(
          dueCount: summary.count,
          totalPiasters: summary.totalPiasters,
        );
        await settings.setLastCollectionReminderDate(todayStr);
        showedAny = true;
      }

      // --- Due installments reminder (Feature 14) ---
      final dueInstallments = await installments.watchDueInstallments().first;
      dueInstallmentCount = dueInstallments.length;

      final lastInstallmentDate = await settings.getLastInstallmentReminderDate();
      if (lastInstallmentDate != todayStr && isTimeDue && dueInstallments.isNotEmpty) {
        var totalPiasters = 0;
        for (final item in dueInstallments) {
          totalPiasters += item.remainingForInstallmentPiasters;
        }
        await notifier.showDueInstallmentsNotification(
          count: dueInstallments.length,
          totalPiasters: totalPiasters,
        );
        await settings.setLastInstallmentReminderDate(todayStr);
        showedAny = true;
      }

      // --- Weekly backup reminder (Feature 12) ---
      final lastBackupReminderDate = await settings.getLastBackupReminderDate();
      if (lastBackupReminderDate != todayStr) {
        final isBackupDue = await settings.isBackupDue();
        if (isBackupDue && await _hasLedgerData()) {
          final days = await settings.getDaysSinceLastBackup() ?? 7;
          await notifier.showBackupReminderNotification(daysSinceBackup: days);
          await settings.setLastBackupReminderDate(todayStr);
          showedAny = true;
        }
      }

      // --- Low stock reminder ---
      final lastLowStockDate = await settings.getLastLowStockReminderDate();
      if (lastLowStockDate != todayStr) {
        final restock = await _lowStockProducts();
        if (restock.isNotEmpty) {
          if (restock.length == 1) {
            final entry = restock.first;
            final product = entry.product;
            String? supplierName;
            String? supplierPhone;
            if (product.supplierId != null) {
              final supplier = await (db.select(db.suppliers)
                    ..where((s) =>
                        s.id.equals(product.supplierId!) & s.deletedAt.isNull()))
                  .getSingleOrNull();
              supplierName = supplier?.name;
              supplierPhone = supplier?.phone;
            }
            final qtyStr =
                '${(entry.currentStock / 1000).toStringAsFixed(1)} ${product.unitLabel}';

            await notifier.showLowStockNotification(
              productName: product.name,
              remainingStock: qtyStr,
              supplierName: supplierName,
              supplierPhone: supplierPhone,
            );
          } else {
            await notifier.showMultipleLowStockNotification(count: restock.length);
          }
          await settings.setLastLowStockReminderDate(todayStr);
          showedAny = true;
        }
      }

      // --- Keep the OS-level daily alarm in sync with reality ---
      // Only schedule it while there is actually money to collect; the app
      // (or the background worker) refreshes this on every evaluation.
      if (dueCustomerCount > 0) {
        await notifier.scheduleDailyReminder(
          hour: reminderHour,
          minute: reminderMinute,
        );
      } else {
        await _cancelScheduleQuietly();
      }

      return ReminderRunResult(
        notificationsEnabled: true,
        dueCustomerCount: dueCustomerCount,
        dueInstallmentCount: dueInstallmentCount,
        showedAny: showedAny,
      );
    } catch (e) {
      debugPrint('ReminderEvaluator error: $e');
      return ReminderRunResult(
        notificationsEnabled: false,
        dueCustomerCount: dueCustomerCount,
        dueInstallmentCount: dueInstallmentCount,
        showedAny: showedAny,
      );
    }
  }

  Future<void> _cancelScheduleQuietly() async {
    try {
      await notifier.cancelDailyReminder();
    } catch (e) {
      debugPrint('ReminderEvaluator: could not cancel daily reminder: $e');
    }
  }

  Future<bool> _hasLedgerData() async {
    final rows = await (db.select(db.transactions)
          ..where((t) => t.deletedAt.isNull())
          ..limit(1))
        .get();
    return rows.isNotEmpty;
  }

  /// Products whose current stock (sum of movements) is at or below their
  /// minimum level.
  Future<List<({Product product, int currentStock})>> _lowStockProducts() async {
    final tracked = await (db.select(db.products)
          ..where((p) =>
              p.minimumStockMilliUnits.isBiggerThanValue(0) & p.deletedAt.isNull()))
        .get();

    final result = <({Product product, int currentStock})>[];
    for (final product in tracked) {
      final movements = await (db.select(db.inventoryMovements)
            ..where((m) => m.productId.equals(product.id) & m.deletedAt.isNull()))
          .get();
      var currentStock = 0;
      for (final movement in movements) {
        currentStock += movement.quantityDeltaMilliUnits;
      }
      if (currentStock <= product.minimumStockMilliUnits) {
        result.add((product: product, currentStock: currentStock));
      }
    }
    return result;
  }

  static String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

/// Shared evaluator used by the app coordinator and the background worker.
final reminderEvaluatorProvider = Provider<ReminderEvaluator>((ref) {
  return ReminderEvaluator(
    db: ref.watch(databaseProvider),
    settings: ref.watch(settingsRepositoryProvider),
    collection: ref.watch(collectionRepositoryProvider),
    installments: ref.watch(installmentRepositoryProvider),
    notifier: ref.watch(notificationServiceProvider),
  );
});
