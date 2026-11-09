import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/app_database.dart';
import 'cloud_api.dart';
import 'cloud_config.dart';
import 'cloud_providers.dart';
import '../../l10n/l10n.dart';

enum AutoBackupState { idle, waitingForInternet, uploading, upToDate, failed }

class AutoBackupStatus {
  final AutoBackupState state;
  final String? message;
  const AutoBackupStatus(this.state, [this.message]);
}

/// What the automatic backup is doing right now (shown in the cloud card).
final autoBackupStatusProvider = StateProvider<AutoBackupStatus>((ref) => const AutoBackupStatus(AutoBackupState.idle));

/// Start once from main(): `ref.read(autoBackupCoordinatorProvider)`.
final autoBackupCoordinatorProvider = Provider<AutoBackupCoordinator>((ref) {
  final coordinator = AutoBackupCoordinator(ref);
  ref.onDispose(coordinator.dispose);
  coordinator.start();
  return coordinator;
});

/// Uploads changes to the cloud automatically, without the user pressing anything:
/// - when the internet comes back (changes made offline are uploaded then),
/// - 30 seconds after any change in the database,
/// - when the app is opened or brought back to the front,
/// - every 30 minutes while the app is open.
/// Only runs when the user is signed in with Google.
class AutoBackupCoordinator {
  final Ref _ref;
  AutoBackupCoordinator(this._ref);

  static const _afterChange = Duration(seconds: 30);
  static const _afterReconnect = Duration(seconds: 5);
  static const _afterResume = Duration(seconds: 3);
  static const _retryAfterFailure = Duration(minutes: 5);
  static const _periodic = Duration(minutes: 30);

  final List<StreamSubscription<dynamic>> _subs = [];
  AppLifecycleListener? _lifecycle;
  Timer? _debounce;
  Timer? _periodicTimer;
  bool _online = true;
  bool _running = false;
  bool _runAgain = false;
  bool _disposed = false;

  void start() {
    if (!CloudConfig.isConfigured) return; // cloud not set up in this build
    try {
      final connectivity = Connectivity();
      connectivity.checkConnectivity().then((r) => _online = _isOnline(r)).catchError((_) => true);
      _subs.add(connectivity.onConnectivityChanged.listen((results) {
        final wasOnline = _online;
        _online = _isOnline(results);
        if (_online && !wasOnline) {
          schedule(_afterReconnect);
        } else if (!_online) {
          _setStatus(const AutoBackupStatus(AutoBackupState.waitingForInternet));
        }
      }));
    } catch (e) {
      debugPrint('AutoBackup: connectivity unavailable ($e)');
    }

    _subs.add(_ref.read(databaseProvider).tableUpdates().listen((_) => schedule(_afterChange)));

    try {
      _lifecycle = AppLifecycleListener(onResume: () => schedule(_afterResume));
    } catch (_) {
      // No WidgetsBinding (pure Dart tests).
    }
    _periodicTimer = Timer.periodic(_periodic, (_) => schedule(Duration.zero));
    schedule(const Duration(seconds: 10)); // shortly after the app starts
  }

  static bool _isOnline(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);

  /// Runs a backup after [delay]; a newer call replaces an older pending one.
  void schedule(Duration delay) {
    if (_disposed) return;
    _debounce?.cancel();
    _debounce = Timer(delay, () => unawaited(_run()));
  }

  /// Runs now (used by tests and the "ارفع دلوقتي" button flow).
  Future<void> runNow() => _run();

  Future<void> _run() async {
    if (_disposed) return;
    if (_running) {
      _runAgain = true;
      return;
    }
    final session = await _ref.read(cloudSessionStoreProvider).read();
    if (session == null) return; // not signed in: nothing to do
    if (!_online) {
      _setStatus(const AutoBackupStatus(AutoBackupState.waitingForInternet));
      return;
    }

    _running = true;
    _setStatus(const AutoBackupStatus(AutoBackupState.uploading));
    try {
      final result = await _ref.read(cloudBackupServiceProvider).backupNow();
      _setStatus(AutoBackupStatus(
        AutoBackupState.upToDate,
        result.rejected > 0 ? L10n.t.autoBackupCoordinator1(result.rejected) : null,
      ));
      _ref.invalidate(cloudSessionProvider);
    } on CloudApiException catch (e) {
      final offline = e.code == 'network' || e.code == 'timeout';
      _setStatus(AutoBackupStatus(offline ? AutoBackupState.waitingForInternet : AutoBackupState.failed, e.message));
      if (e.code == 'signed_out') {
        _ref.invalidate(cloudSessionProvider);
      } else {
        schedule(_retryAfterFailure);
      }
    } catch (e) {
      debugPrint('AutoBackup failed: $e');
      _setStatus(AutoBackupStatus(AutoBackupState.failed, L10n.t.autoBackupCoordinator2));
      schedule(_retryAfterFailure);
    } finally {
      _running = false;
      if (_runAgain) {
        _runAgain = false;
        schedule(_afterChange);
      }
    }
  }

  void _setStatus(AutoBackupStatus status) {
    if (_disposed) return;
    try {
      _ref.read(autoBackupStatusProvider.notifier).state = status;
    } catch (_) {}
  }

  void dispose() {
    _disposed = true;
    _debounce?.cancel();
    _periodicTimer?.cancel();
    _lifecycle?.dispose();
    for (final s in _subs) {
      s.cancel();
    }
  }
}
