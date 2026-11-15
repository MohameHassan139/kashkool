import 'dart:async';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/app_database.dart';
import '../router/app_router.dart';
import '../../features/collection/data/collection_repository.dart';
import '../../features/installments/data/installment_repository.dart';
import '../../features/settings/data/settings_repository.dart';
import 'notification_service.dart';

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
/// 2. Listens to app lifecycle (onResume) to immediately evaluate due reminders
///    (guarantees delivery even if OEM background killers kill background tasks).
/// 3. Periodically checks if the daily reminder time has arrived.
/// 4. Handles:
///    - Daily collection reminder (Feature 07)
///    - Due installments reminder (Feature 14)
///    - Weekly backup reminder (Feature 12)
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
      },
    );

    // Recompute on app resume (defends against aggressive OEM battery killers)
    try {
      _lifecycle = AppLifecycleListener(
        onResume: () => checkAndTriggerReminders(isResume: true),
      );
    } catch (_) {
      // No WidgetsBinding in headless environments
    }

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
      final settingsRepo = _ref.read(settingsRepositoryProvider);

      // 1. Check if notifications are enabled in settings
      final notificationsEnabled = await settingsRepo.getNotificationsEnabled();
      if (!notificationsEnabled) return;

      // 2. Check if OS permissions are granted
      final hasPermission = await _service.isPermissionGranted();
      if (!hasPermission) return;

      final now = DateTime.now();
      final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      final reminderHour = await settingsRepo.getReminderTimeHour();
      final reminderMinute = await settingsRepo.getReminderTimeMinute();
      final isTimeDue = now.hour > reminderHour || (now.hour == reminderHour && now.minute >= reminderMinute);

      // --- Daily Collection Reminder (Feature 07) ---
      final lastCollectionDate = await settingsRepo.getLastCollectionReminderDate();
      if (lastCollectionDate != todayStr && isTimeDue) {
        final collectionRepo = _ref.read(collectionRepositoryProvider);
        final summary = await collectionRepo.watchDueSummary().first;
        if (summary.count > 0) {
          await _service.showCollectionNotification(
            dueCount: summary.count,
            totalPiasters: summary.totalPiasters,
          );
          await settingsRepo.setLastCollectionReminderDate(todayStr);
        }
      }

      // --- Due Installments Reminder (Feature 14) ---
      final lastInstallmentDate = await settingsRepo.getLastInstallmentReminderDate();
      if (lastInstallmentDate != todayStr && isTimeDue) {
        final installmentRepo = _ref.read(installmentRepositoryProvider);
        final dueInstallments = await installmentRepo.watchDueInstallments().first;
        if (dueInstallments.isNotEmpty) {
          var totalPiasters = 0;
          for (final item in dueInstallments) {
            totalPiasters += item.remainingForInstallmentPiasters;
          }
          await _service.showDueInstallmentsNotification(
            count: dueInstallments.length,
            totalPiasters: totalPiasters,
          );
          await settingsRepo.setLastInstallmentReminderDate(todayStr);
        }
      }

      // --- Weekly Backup Reminder (Feature 12) ---
      final lastBackupReminderDate = await settingsRepo.getLastBackupReminderDate();
      if (lastBackupReminderDate != todayStr) {
        final isBackupDue = await settingsRepo.isBackupDue();
        if (isBackupDue) {
          // Only alert if there is actual ledger data in the database
          final db = _ref.read(databaseProvider);
          final txCount = await (db.select(db.transactions)
                ..where((t) => t.deletedAt.isNull())
                ..limit(1))
              .get();

          if (txCount.isNotEmpty) {
            final days = await settingsRepo.getDaysSinceLastBackup() ?? 7;
            await _service.showBackupReminderNotification(daysSinceBackup: days);
            await settingsRepo.setLastBackupReminderDate(todayStr);
          }
        }
      }

      // --- Low Stock Items Reminder ---
      final lastLowStockDate = await settingsRepo.getLastLowStockReminderDate();
      if (lastLowStockDate != todayStr) {
        final db = _ref.read(databaseProvider);
        final lowStockProducts = await (db.select(db.products)
              ..where((p) =>
                  p.minimumStockMilliUnits.isBiggerThanValue(0) &
                  p.deletedAt.isNull()))
            .get();

        final itemsNeedingRestock = <Product>[];
        final stockLevels = <String, int>{};

        for (final p in lowStockProducts) {
          final movements = await (db.select(db.inventoryMovements)
                ..where((m) => m.productId.equals(p.id) & m.deletedAt.isNull()))
              .get();
          var currentStock = 0;
          for (final m in movements) {
            currentStock += m.quantityDeltaMilliUnits;
          }
          if (currentStock <= p.minimumStockMilliUnits) {
            itemsNeedingRestock.add(p);
            stockLevels[p.id] = currentStock;
          }
        }

        if (itemsNeedingRestock.isNotEmpty) {
          if (itemsNeedingRestock.length == 1) {
            final p = itemsNeedingRestock.first;
            String? supplierName;
            String? supplierPhone;
            if (p.supplierId != null) {
              final s = await (db.select(db.suppliers)
                    ..where((s) => s.id.equals(p.supplierId!) & s.deletedAt.isNull()))
                  .getSingleOrNull();
              supplierName = s?.name;
              supplierPhone = s?.phone;
            }
            final currentStock = stockLevels[p.id] ?? 0;
            final qtyStr = '${(currentStock / 1000).toStringAsFixed(1)} ${p.unitLabel}';

            await _service.showLowStockNotification(
              productName: p.name,
              remainingStock: qtyStr,
              supplierName: supplierName,
              supplierPhone: supplierPhone,
            );
          } else {
            await _service.showMultipleLowStockNotification(
              count: itemsNeedingRestock.length,
            );
          }
          await settingsRepo.setLastLowStockReminderDate(todayStr);
        }
      }
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
    return await _service.requestPermissions();
  }
}
