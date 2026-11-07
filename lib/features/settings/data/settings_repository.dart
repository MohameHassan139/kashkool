import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
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
  static const String keyPaymentInfo = 'payment_info';
  static const String keyMessageTemplate = 'collection_message_template';
  static const String keyPrivacyMode = 'privacy_mode_enabled';

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
