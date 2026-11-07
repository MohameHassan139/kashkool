import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import '../utils/money.dart';

/// Service responsible for updating native Home Screen widgets (Android 2x1 and 4x2)
/// and handling widget deep links.
class HomeWidgetService {
  static const String smallWidgetProvider = 'KashkoolSmallWidgetProvider';
  static const String mediumWidgetProvider = 'KashkoolMediumWidgetProvider';

  static const String keyTotalReceivables = 'total_receivables';
  static const String keyCollectedToday = 'collected_today';
  static const String keyDueCount = 'due_count';

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

  /// Pushes updated metrics to native Android widgets.
  /// Respects privacy mode by masking amounts with `••••••`.
  Future<void> updateWidgetData({
    required int totalReceivablesPiasters,
    required int collectedTodayPiasters,
    required int dueCount,
    bool privacyMode = false,
  }) async {
    try {
      final String formattedReceivables = privacyMode
          ? '••••••'
          : MoneyUtils.formatMoney(totalReceivablesPiasters);

      final String formattedCollected = privacyMode
          ? '••••••'
          : MoneyUtils.formatMoney(collectedTodayPiasters);

      final String formattedDueCount = '$dueCount عملاء';

      await HomeWidget.saveWidgetData<String>(keyTotalReceivables, formattedReceivables);
      await HomeWidget.saveWidgetData<String>(keyCollectedToday, formattedCollected);
      await HomeWidget.saveWidgetData<String>(keyDueCount, formattedDueCount);

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
}

/// Provider for HomeWidgetService singleton.
final homeWidgetServiceProvider = Provider<HomeWidgetService>((ref) {
  return HomeWidgetService();
});
