import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import '../utils/money.dart';
import '../../l10n/l10n.dart';

/// Service responsible for updating native Home Screen widgets (Android 2x1 and 4x2)
/// and handling widget deep links.
class HomeWidgetService {
  static const String smallWidgetProvider = 'KashkoolSmallWidgetProvider';
  static const String mediumWidgetProvider = 'KashkoolMediumWidgetProvider';

  static const String keyTotalReceivables = 'total_receivables';
  static const String keyCollectedToday = 'collected_today';
  static const String keyDueCount = 'due_count';

  /// Calendar day of the last update (`yyyy-MM-dd`). The native widget uses it to
  /// reset "collected today" when the day changes while the app is closed.
  static const String keyUpdatedDate = 'updated_date';

  /// Clock time of the last update (`HH:mm`), shown as "آخر تحديث" on the medium widget.
  static const String keyUpdatedTime = 'updated_time';

  /// `"true"` / `"false"`. Lets the native widget keep amounts hidden after a day change.
  static const String keyPrivacyMode = 'privacy_mode';

  /// `"true"` / `"false"`. When false the native widget shows "متوقفة" instead of numbers.
  static const String keyWidgetEnabled = 'widget_enabled';

  static const String maskedAmount = '••••••';

  /// Initializes deep linking callbacks when the app is launched from a home widget tap.
  Future<void> init({required void Function(Uri uri) onDeepLink}) async {
    try {
      final initialUri = await HomeWidget.initiallyLaunchedFromHomeWidget();
      if (initialUri != null) {
        onDeepLink(initialUri);
      }

      HomeWidget.widgetClicked.listen((uri) {
        if (uri != null) {
          onDeepLink(uri);
        }
      });
    } catch (e) {
      debugPrint('HomeWidget initialization notice: $e');
    }
  }

  /// Egyptian-Arabic count of customers with correct grammar.
  ///
  /// 0 → "مفيش", 1 → "عميل واحد", 2 → "عميلين", 3–10 → "N عملاء", 11+ → "N عميل".
  static String formatCustomerCount(int count) {
    if (count <= 0) return L10n.t.homeWidgetService1;
    if (count == 1) return L10n.t.homeWidgetService2;
    if (count == 2) return L10n.t.homeWidgetService3;
    if (count <= 10) return L10n.t.homeWidgetService4(count);
    return L10n.t.notebookImportScreen16(count);
  }

  static String _two(int n) => n.toString().padLeft(2, '0');

  /// `yyyy-MM-dd` using Western digits, matching the Kotlin side.
  static String formatDateKey(DateTime d) => '${d.year}-${_two(d.month)}-${_two(d.day)}';

  /// `HH:mm` using Western digits.
  static String formatTime(DateTime d) => '${_two(d.hour)}:${_two(d.minute)}';

  /// Pushes updated metrics to native Android widgets.
  /// Respects privacy mode by masking amounts with `••••••`.
  Future<void> updateWidgetData({
    required int totalReceivablesPiasters,
    required int collectedTodayPiasters,
    required int dueCount,
    bool privacyMode = false,
    bool enabled = true,
    DateTime? now,
  }) async {
    try {
      final current = now ?? DateTime.now();

      final String formattedReceivables = privacyMode
          ? maskedAmount
          : MoneyUtils.formatMoney(totalReceivablesPiasters);

      final String formattedCollected = privacyMode
          ? maskedAmount
          : MoneyUtils.formatMoney(collectedTodayPiasters);

      await HomeWidget.saveWidgetData<String>(keyTotalReceivables, formattedReceivables);
      await HomeWidget.saveWidgetData<String>(keyCollectedToday, formattedCollected);
      await HomeWidget.saveWidgetData<String>(keyDueCount, formatCustomerCount(dueCount));
      await HomeWidget.saveWidgetData<String>(keyUpdatedDate, formatDateKey(current));
      await HomeWidget.saveWidgetData<String>(keyUpdatedTime, formatTime(current));
      await HomeWidget.saveWidgetData<String>(keyPrivacyMode, privacyMode ? 'true' : 'false');
      await HomeWidget.saveWidgetData<String>(keyWidgetEnabled, enabled ? 'true' : 'false');

      await HomeWidget.updateWidget(
        name: smallWidgetProvider,
        androidName: smallWidgetProvider,
      );

      await HomeWidget.updateWidget(
        name: mediumWidgetProvider,
        androidName: mediumWidgetProvider,
      );
    } catch (e) {
      debugPrint('HomeWidget update notice: $e');
    }
  }

  /// Whether the launcher supports adding a widget from inside the app (Android 8+ on most launchers).
  Future<bool> isPinSupported() async {
    try {
      return await HomeWidget.isRequestPinWidgetSupported() ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Asks the launcher to add the given widget to the home screen.
  /// Android shows its own confirmation dialog; returns false if the request could not be sent.
  Future<bool> requestPinWidget({required bool medium}) async {
    try {
      await HomeWidget.requestPinWidget(
        name: medium ? mediumWidgetProvider : smallWidgetProvider,
        androidName: medium ? mediumWidgetProvider : smallWidgetProvider,
      );
      return true;
    } catch (e) {
      debugPrint('HomeWidget pin request notice: $e');
      return false;
    }
  }
}

/// Provider for HomeWidgetService singleton.
final homeWidgetServiceProvider = Provider<HomeWidgetService>((ref) {
  return HomeWidgetService();
});
