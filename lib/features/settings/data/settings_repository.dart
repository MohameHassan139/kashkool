import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../../core/growth/growth_footer.dart';
import '../../../core/utils/whatsapp_template.dart';

/// Repository managing application settings and defaults stored locally in Drift SQLite.
class SettingsRepository {
  final AppDatabase _db;

  static const String keyDefaultCreditLimit = 'default_credit_limit_piasters';
  static const String keyMinDebtAgeDays = 'collection_min_debt_age_days';
  static const String keyReminderIntervalDays = 'collection_reminder_interval_days';
  static const String keyReminderTimeHour = 'collection_reminder_time_hour';
  static const String keyReminderTimeMinute = 'collection_reminder_time_minute';
  static const String keyShopName = 'shop_name';
  static const String keyShopPhone = 'shop_phone';
  static const String keyShopAddress = 'shop_address';
  static const String keyShopLogoPath = 'shop_logo_path';
  static const String keyShopInstaPay = 'shop_instapay_handle';
  static const String keyShopWallet = 'shop_wallet_number';
  static const String keyPaymentInfo = 'payment_info';
  static const String keyMessageTemplate = 'collection_message_template';
  static const String keyPrivacyMode = 'privacy_mode_enabled';
  static const String keyHomeWidgetEnabled = 'home_widget_enabled';
  static const String keyShopCode = 'growth_shop_referral_code';
  static const String keyGrowthFooterEnabled = 'growth_footer_enabled';

  // Security
  static const String keyPinHash = 'security_pin_hash';
  static const String keyPinSalt = 'security_pin_salt';
  static const String keyBiometricEnabled = 'security_biometric_enabled';
  static const String keyLockTimeoutMinutes = 'security_lock_timeout_minutes';

  // Data & Backup
  static const String keyLastBackupAt = 'data_last_backup_at';

  // General
  static const String keyThemeMode = 'general_theme_mode';

  SettingsRepository(this._db);

  /// Retrieves a setting value by key.
  Future<String?> getString(String key) async {
    final entry = await (_db.select(_db.appSettings)..where((s) => s.key.equals(key))).getSingleOrNull();
    return entry?.value;
  }

  /// Sets or updates a setting value.
  Future<void> setString(String key, String value) async {
    final now = DateTime.now();
    await _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion(
            id: Value('setting-$key'),
            key: Value(key),
            value: Value(value),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
  }

  /// Deletes a setting.
  Future<void> remove(String key) async {
    await (_db.delete(_db.appSettings)..where((s) => s.key.equals(key))).go();
  }

  /// Watches a setting string value.
  Stream<String?> watchString(String key) {
    return (_db.select(_db.appSettings)..where((s) => s.key.equals(key)))
        .watchSingleOrNull()
        .map((entry) => entry?.value);
  }

  // --- Credit Limit ---

  /// Gets the default credit limit in piasters for newly created customers.
  Future<int?> getDefaultCreditLimitPiasters() async {
    final val = await getString(keyDefaultCreditLimit);
    return val != null ? int.tryParse(val) : null;
  }

  /// Sets the default credit limit in piasters.
  Future<void> setDefaultCreditLimitPiasters(int? piasters) async {
    if (piasters == null || piasters <= 0) {
      await remove(keyDefaultCreditLimit);
    } else {
      await setString(keyDefaultCreditLimit, piasters.toString());
    }
  }

  /// Watches the default credit limit setting.
  Stream<int?> watchDefaultCreditLimitPiasters() {
    return watchString(keyDefaultCreditLimit)
        .map((val) => val != null ? int.tryParse(val) : null);
  }

  // --- Collection Settings ---

  /// Minimum debt age in days before a customer is considered due for reminder (default: 3).
  Future<int> getMinDebtAgeDays() async {
    final val = await getString(keyMinDebtAgeDays);
    return val != null ? (int.tryParse(val) ?? 3) : 3;
  }

  Future<void> setMinDebtAgeDays(int days) async {
    await setString(keyMinDebtAgeDays, days.toString());
  }

  Stream<int> watchMinDebtAgeDays() {
    return watchString(keyMinDebtAgeDays)
        .map((val) => val != null ? (int.tryParse(val) ?? 3) : 3);
  }

  /// Days between reminders for the same customer (default: 7).
  Future<int> getReminderIntervalDays() async {
    final val = await getString(keyReminderIntervalDays);
    return val != null ? (int.tryParse(val) ?? 7) : 7;
  }

  Future<void> setReminderIntervalDays(int days) async {
    await setString(keyReminderIntervalDays, days.toString());
  }

  Stream<int> watchReminderIntervalDays() {
    return watchString(keyReminderIntervalDays)
        .map((val) => val != null ? (int.tryParse(val) ?? 7) : 7);
  }

  /// Shop name for reminder message header (default: 'كشكول').
  Future<String> getShopName() async {
    final val = await getString(keyShopName);
    return (val != null && val.trim().isNotEmpty) ? val.trim() : 'كشكول';
  }

  Future<void> setShopName(String name) async {
    await setString(keyShopName, name.trim());
  }

  Stream<String> watchShopName() {
    return watchString(keyShopName)
        .map((val) => (val != null && val.trim().isNotEmpty) ? val.trim() : 'كشكول');
  }

  /// Payment info details (Vodafone Cash, InstaPay, etc.).
  Future<String> getPaymentInfo() async {
    final val = await getString(keyPaymentInfo);
    return val ?? '';
  }

  Future<void> setPaymentInfo(String info) async {
    await setString(keyPaymentInfo, info.trim());
  }

  Stream<String> watchPaymentInfo() {
    return watchString(keyPaymentInfo).map((val) => val ?? '');
  }

  /// Message template for reminders.
  Future<String> getMessageTemplate() async {
    final val = await getString(keyMessageTemplate);
    return (val != null && val.trim().isNotEmpty)
        ? val
        : WhatsAppTemplateUtils.defaultFriendlyTemplate;
  }

  Future<void> setMessageTemplate(String template) async {
    await setString(keyMessageTemplate, template);
  }

  Stream<String> watchMessageTemplate() {
    return watchString(keyMessageTemplate).map((val) =>
        (val != null && val.trim().isNotEmpty)
            ? val
            : WhatsAppTemplateUtils.defaultFriendlyTemplate);
  }

  // --- Privacy Mode ---

  /// Whether privacy mode is enabled (amounts hidden on widgets and home).
  Future<bool> getPrivacyMode() async {
    final val = await getString(keyPrivacyMode);
    return val == 'true';
  }

  Future<void> setPrivacyMode(bool enabled) async {
    await setString(keyPrivacyMode, enabled.toString());
  }

  Stream<bool> watchPrivacyMode() {
    return watchString(keyPrivacyMode).map((val) => val == 'true');
  }

  // --- Home Screen Widget (Feature 10) ---

  /// Whether the home screen widget shows the shop's numbers (default: on).
  Future<bool> getHomeWidgetEnabled() async {
    final val = await getString(keyHomeWidgetEnabled);
    return val != 'false';
  }

  Future<void> setHomeWidgetEnabled(bool enabled) async {
    await setString(keyHomeWidgetEnabled, enabled.toString());
  }

  Stream<bool> watchHomeWidgetEnabled() {
    return watchString(keyHomeWidgetEnabled).map((val) => val != 'false');
  }

  // --- Growth Footer & Referral (Feature 11) ---

  /// Returns the shop's stable referral code, generating and persisting it on first call.
  Future<String> getOrCreateShopCode() async {
    final existing = await getString(keyShopCode);
    if (GrowthFooter.isValidCode(existing)) return existing!;
    final code = GrowthFooter.generateShopCode();
    await setString(keyShopCode, code);
    return code;
  }

  /// Whether the growth footer is appended to outgoing messages/PDFs.
  /// In the Free tier this is always `true`; it becomes toggleable in the Paid tier (16).
  Future<bool> isGrowthFooterEnabled({bool isPaidTier = false}) async {
    if (!isPaidTier) return true;
    final val = await getString(keyGrowthFooterEnabled);
    return val != 'false';
  }

  /// Persists the growth footer toggle. Ignored unless [isPaidTier] is true.
  Future<void> setGrowthFooterEnabled(bool enabled, {bool isPaidTier = false}) async {
    if (!isPaidTier) return;
    await setString(keyGrowthFooterEnabled, enabled.toString());
  }

  // --- Shop Profile Details ---

  Future<String> getShopPhone() async {
    return (await getString(keyShopPhone)) ?? '';
  }

  Future<void> setShopPhone(String phone) async {
    await setString(keyShopPhone, phone.trim());
  }

  Stream<String> watchShopPhone() {
    return watchString(keyShopPhone).map((val) => val ?? '');
  }

  Future<String> getShopAddress() async {
    return (await getString(keyShopAddress)) ?? '';
  }

  Future<void> setShopAddress(String address) async {
    await setString(keyShopAddress, address.trim());
  }

  Stream<String> watchShopAddress() {
    return watchString(keyShopAddress).map((val) => val ?? '');
  }

  Future<String?> getShopLogoPath() async {
    return await getString(keyShopLogoPath);
  }

  Future<void> setShopLogoPath(String? path) async {
    if (path == null || path.isEmpty) {
      await remove(keyShopLogoPath);
    } else {
      await setString(keyShopLogoPath, path);
    }
  }

  Stream<String?> watchShopLogoPath() {
    return watchString(keyShopLogoPath);
  }

  Future<String> getShopInstaPay() async {
    return (await getString(keyShopInstaPay)) ?? '';
  }

  Future<void> setShopInstaPay(String handle) async {
    await setString(keyShopInstaPay, handle.trim());
  }

  Stream<String> watchShopInstaPay() {
    return watchString(keyShopInstaPay).map((val) => val ?? '');
  }

  Future<String> getShopWallet() async {
    return (await getString(keyShopWallet)) ?? '';
  }

  Future<void> setShopWallet(String wallet) async {
    await setString(keyShopWallet, wallet.trim());
  }

  Stream<String> watchShopWallet() {
    return watchString(keyShopWallet).map((val) => val ?? '');
  }

  // --- Security & PIN Lock ---

  Future<String?> getPinHash() async {
    return await getString(keyPinHash);
  }

  Future<String?> getPinSalt() async {
    return await getString(keyPinSalt);
  }

  Future<bool> hasPin() async {
    final hash = await getPinHash();
    return hash != null && hash.isNotEmpty;
  }

  Stream<bool> watchHasPin() {
    return watchString(keyPinHash).map((val) => val != null && val.isNotEmpty);
  }

  Future<void> setPin({required String hash, required String salt}) async {
    await setString(keyPinHash, hash);
    await setString(keyPinSalt, salt);
  }

  Future<void> removePin() async {
    await remove(keyPinHash);
    await remove(keyPinSalt);
    await remove(keyBiometricEnabled);
  }

  Future<bool> isBiometricEnabled() async {
    final val = await getString(keyBiometricEnabled);
    return val == 'true';
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await setString(keyBiometricEnabled, enabled.toString());
  }

  Stream<bool> watchBiometricEnabled() {
    return watchString(keyBiometricEnabled).map((val) => val == 'true');
  }

  /// Lock timeout in minutes (0 means immediately on leaving app).
  Future<int> getLockTimeoutMinutes() async {
    final val = await getString(keyLockTimeoutMinutes);
    return val != null ? (int.tryParse(val) ?? 0) : 0;
  }

  Future<void> setLockTimeoutMinutes(int minutes) async {
    await setString(keyLockTimeoutMinutes, minutes.toString());
  }

  Stream<int> watchLockTimeoutMinutes() {
    return watchString(keyLockTimeoutMinutes)
        .map((val) => val != null ? (int.tryParse(val) ?? 0) : 0);
  }

  // --- Backup & Data ---

  Future<DateTime?> getLastBackupAt() async {
    final val = await getString(keyLastBackupAt);
    return val != null ? DateTime.tryParse(val) : null;
  }

  Future<void> setLastBackupAt(DateTime date) async {
    await setString(keyLastBackupAt, date.toIso8601String());
  }

  Stream<DateTime?> watchLastBackupAt() {
    return watchString(keyLastBackupAt).map((val) => val != null ? DateTime.tryParse(val) : null);
  }

  /// Number of days since last backup, or null if never backed up.
  Future<int?> getDaysSinceLastBackup() async {
    final last = await getLastBackupAt();
    if (last == null) return null;
    return DateTime.now().difference(last).inDays;
  }

  /// Whether a backup warning banner should be displayed (if never backed up or >= 7 days).
  Future<bool> isBackupDue() async {
    final days = await getDaysSinceLastBackup();
    return days == null || days >= 7;
  }

  // --- Theme Mode ---

  Future<ThemeMode> getThemeMode() async {
    final val = await getString(keyThemeMode);
    switch (val) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await setString(keyThemeMode, mode.name);
  }

  Stream<ThemeMode> watchThemeMode() {
    return watchString(keyThemeMode).map((val) {
      switch (val) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        case 'system':
        default:
          return ThemeMode.system;
      }
    });
  }
}

/// Global provider for SettingsRepository
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return SettingsRepository(db);
});

/// Provider for default credit limit
final defaultCreditLimitProvider = StreamProvider<int?>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.watchDefaultCreditLimitPiasters();
});

/// Provider for privacy mode state
final privacyModeProvider = StreamProvider<bool>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.watchPrivacyMode();
});

/// Provider for the home screen widget on/off state
final homeWidgetEnabledProvider = StreamProvider<bool>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.watchHomeWidgetEnabled();
});

/// Provider for the stable shop referral code (generated on first access).
final shopCodeProvider = FutureProvider<String>((ref) {
  return ref.watch(settingsRepositoryProvider).getOrCreateShopCode();
});

/// Stream provider for ThemeMode
final themeModeProvider = StreamProvider<ThemeMode>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.watchThemeMode();
});

/// Stream provider for PIN setup status
final hasPinProvider = StreamProvider<bool>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.watchHasPin();
});

/// Stream provider for biometric enabled status
final biometricEnabledProvider = StreamProvider<bool>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.watchBiometricEnabled();
});

/// Stream provider for last backup timestamp
final lastBackupAtProvider = StreamProvider<DateTime?>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.watchLastBackupAt();
});

/// Future provider checking if backup is due (>= 7 days)
final isBackupDueProvider = FutureProvider<bool>((ref) async {
  final repo = ref.watch(settingsRepositoryProvider);
  // Re-evaluate whenever lastBackupAt changes
  ref.watch(lastBackupAtProvider);
  return repo.isBackupDue();
});
