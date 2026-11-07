import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/cash_drawer/data/cash_drawer_repository.dart';
import '../../features/collection/data/collection_repository.dart';
import '../../features/customers/data/customer_repository.dart';
import '../../features/settings/data/settings_repository.dart';
import 'home_widget_service.dart';

/// Provider watching the total receivables across all active customers.
final totalReceivablesProvider = StreamProvider<int>((ref) {
  return ref.watch(customerRepositoryProvider).watchTotalReceivables();
});

/// Provider watching the count and sum of customers due for collection today.
final dueSummaryProvider = StreamProvider<({int count, int totalPiasters})>((ref) {
  return ref.watch(collectionRepositoryProvider).watchDueSummary();
});

/// Coordinator that synchronizes app data reactively with native Home Screen Widgets.
class HomeWidgetSyncCoordinator {
  final Ref _ref;
  bool _isDisposed = false;

  AppLifecycleListener? _lifecycleListener;

  HomeWidgetSyncCoordinator(this._ref) {
    _ref.onDispose(() {
      _isDisposed = true;
      _lifecycleListener?.dispose();
    });
    _initListeners();
    _listenToAppResume();
  }

  /// Re-syncs whenever the app returns to the foreground, so the widget picks up
  /// a new day (collected today = 0, fresh due list) as soon as the owner opens the app.
  void _listenToAppResume() {
    try {
      _lifecycleListener = AppLifecycleListener(onResume: _sync);
    } catch (_) {
      // No WidgetsBinding (e.g. pure Dart tests) — resume sync is not needed there.
    }
  }

  void _initListeners() {
    _ref.listen(totalReceivablesProvider, (_, _) => _sync());
    _ref.listen(todayDrawerSummaryProvider, (_, _) => _sync());
    _ref.listen(dueSummaryProvider, (_, _) => _sync());
    _ref.listen(privacyModeProvider, (_, _) => _sync());
    _ref.listen(homeWidgetEnabledProvider, (_, _) => _sync());
  }

  Future<void> _sync() async {
    if (_isDisposed) return;
    try {
      final customerRepo = _ref.read(customerRepositoryProvider);
      final drawerRepo = _ref.read(cashDrawerRepositoryProvider);
      final collectionRepo = _ref.read(collectionRepositoryProvider);
      final settingsRepo = _ref.read(settingsRepositoryProvider);
      final service = _ref.read(homeWidgetServiceProvider);

      final receivables = await customerRepo.watchTotalReceivables().first;
      if (_isDisposed) return;

      final drawerSummary = await drawerRepo.getDaySummary(DateTime.now());
      if (_isDisposed) return;

      final dueSummary = await collectionRepo.watchDueSummary().first;
      if (_isDisposed) return;

      final privacyMode = await settingsRepo.getPrivacyMode();
      if (_isDisposed) return;

      final widgetEnabled = await settingsRepo.getHomeWidgetEnabled();
      if (_isDisposed) return;

      final collectedToday = drawerSummary.customerCashPaymentsPiasters +
          drawerSummary.customerDigitalPaymentsPiasters;
      final dueCount = dueSummary.count;

      await service.updateWidgetData(
        totalReceivablesPiasters: receivables,
        collectedTodayPiasters: collectedToday,
        dueCount: dueCount,
        privacyMode: privacyMode,
        enabled: widgetEnabled,
      );
    } catch (_) {
      // Disposed container or uninitialized test channel
    }
  }

  /// Triggers a manual sync.
  Future<void> syncNow() => _sync();
}

/// Provider for HomeWidgetSyncCoordinator.
final homeWidgetSyncCoordinatorProvider = Provider<HomeWidgetSyncCoordinator>((ref) {
  return HomeWidgetSyncCoordinator(ref);
});
