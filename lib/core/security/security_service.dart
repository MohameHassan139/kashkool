import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import '../../features/settings/data/settings_repository.dart';
import '../../l10n/l10n.dart';

/// Service managing PIN hashing, biometric checks, and authentication.
class SecurityService {
  final SettingsRepository _settingsRepo;
  final LocalAuthentication _localAuth;

  SecurityService({
    required SettingsRepository settingsRepo,
    LocalAuthentication? localAuth,
  })  : _settingsRepo = settingsRepo,
        _localAuth = localAuth ?? LocalAuthentication();

  /// Hashes a 4-digit PIN with a salt using SHA-256.
  static String hashPin(String pin, String salt) {
    final bytes = utf8.encode('$salt:$pin');
    return sha256.convert(bytes).toString();
  }

  /// Generates a random cryptographic salt.
  static String generateSalt() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  /// Whether a PIN code is configured in the app.
  Future<bool> hasPin() async {
    return await _settingsRepo.hasPin();
  }

  /// Verifies if the entered PIN matches the saved PIN hash.
  Future<bool> verifyPin(String enteredPin) async {
    final hash = await _settingsRepo.getPinHash();
    final salt = await _settingsRepo.getPinSalt();
    if (hash == null || salt == null) {
      // No PIN configured
      return true;
    }
    final enteredHash = hashPin(enteredPin, salt);
    return enteredHash == hash;
  }

  /// Sets a new 4-digit PIN.
  Future<void> setPin(String pin) async {
    if (pin.length != 4 || !RegExp(r'^\d{4}$').hasMatch(pin)) {
      throw ArgumentError('PIN must be exactly 4 digits');
    }
    final salt = generateSalt();
    final hash = hashPin(pin, salt);
    await _settingsRepo.setPin(hash: hash, salt: salt);
  }

  /// Removes the existing PIN and disables biometric lock.
  Future<void> removePin() async {
    await _settingsRepo.removePin();
  }

  /// Flag indicating if biometric authentication prompt is actively in progress.
  bool isAuthenticatingBiometrics = false;

  /// Checks if hardware and device support biometric authentication.
  Future<bool> isBiometricsAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isSupported = await _localAuth.isDeviceSupported();
      final available = await _localAuth.getAvailableBiometrics();
      return (canCheck || isSupported) && (available.isNotEmpty || canCheck);
    } catch (_) {
      return false;
    }
  }

  /// Prompts the user with biometric authentication (Fingerprint / Face ID).
  Future<bool> authenticateWithBiometrics({String? reason}) async {
    reason ??= L10n.t.securityService1;
    if (isAuthenticatingBiometrics) return false;
    try {
      final isAvailable = await isBiometricsAvailable();
      if (!isAvailable) return false;

      isAuthenticatingBiometrics = true;
      try {
        final result = await _localAuth.authenticate(
          localizedReason: reason,
          biometricOnly: true,
          persistAcrossBackgrounding: false,
        );
        return result;
      } catch (_) {
        return false;
      } finally {
        // Keep flag briefly true so resume lifecycle event from dialog dismiss doesn't re-lock
        await Future.delayed(const Duration(milliseconds: 600));
        isAuthenticatingBiometrics = false;
      }
    } catch (_) {
      isAuthenticatingBiometrics = false;
      return false;
    }
  }

  /// Whether biometric authentication is enabled in settings.
  Future<bool> isBiometricEnabled() async {
    return await _settingsRepo.isBiometricEnabled();
  }

  /// Enables or disables biometric authentication.
  Future<void> setBiometricEnabled(bool enabled) async {
    await _settingsRepo.setBiometricEnabled(enabled);
  }
}

/// Global provider for SecurityService
final securityServiceProvider = Provider<SecurityService>((ref) {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  return SecurityService(settingsRepo: settingsRepo);
});

/// StateNotifier tracking whether the app is currently locked.
class AppLockNotifier extends StateNotifier<bool> {
  final SecurityService _securityService;
  final SettingsRepository _settingsRepo;
  DateTime? _pausedAt;
  DateTime? _unlockedAt;

  AppLockNotifier(this._securityService, this._settingsRepo) : super(false) {
    _initLockState();
  }

  Future<void> _initLockState() async {
    final hasPin = await _securityService.hasPin();
    if (hasPin) {
      state = true;
    }
  }

  /// Manually unlock the app.
  void unlock() {
    _pausedAt = null;
    _unlockedAt = DateTime.now();
    state = false;
  }

  /// Manually lock the app.
  void lock() {
    state = true;
  }

  /// Called when the app transitions to background.
  void onAppPaused() {
    if (_securityService.isAuthenticatingBiometrics) return;
    _unlockedAt = null;
    _pausedAt = DateTime.now();
  }

  /// Called when the app returns to foreground.
  Future<void> onAppResumed() async {
    if (_securityService.isAuthenticatingBiometrics) return;

    // Grace period right after unlocking prevents transient lifecycle events from re-locking
    if (_unlockedAt != null && DateTime.now().difference(_unlockedAt!).inMilliseconds < 1500) {
      return;
    }

    final hasPin = await _securityService.hasPin();
    if (!hasPin) {
      state = false;
      return;
    }

    if (_pausedAt != null) {
      final timeoutMinutes = await _settingsRepo.getLockTimeoutMinutes();
      final difference = DateTime.now().difference(_pausedAt!);
      if (difference.inMinutes >= timeoutMinutes) {
        state = true;
      }
    }
  }
}

/// Global provider for app locked state
final appLockNotifierProvider = StateNotifierProvider<AppLockNotifier, bool>((ref) {
  final securityService = ref.watch(securityServiceProvider);
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  return AppLockNotifier(securityService, settingsRepo);
});
