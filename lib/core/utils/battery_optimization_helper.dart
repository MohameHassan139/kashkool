import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../../l10n/l10n.dart';

enum DeviceBrandFamily {
  transsion, // Infinix, Tecno, Itel
  xiaomi, // Xiaomi, Redmi, Poco
  oppo, // Oppo, Realme, OnePlus
  samsung,
  huawei, // Huawei, Honor
  generic,
}

class BrandBatteryGuide {
  final DeviceBrandFamily family;
  final String brandName;
  final String osName;
  final List<String> steps;

  const BrandBatteryGuide({
    required this.family,
    required this.brandName,
    required this.osName,
    required this.steps,
  });
}

class BatteryOptimizationHelper {
  static const MethodChannel _channel =
      MethodChannel('app.kashkool/device_settings');

  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Detects the device manufacturer and returns the brand family.
  static Future<BrandBatteryGuide> getDeviceGuide() async {
    if (!kIsWeb && Platform.isAndroid) {
      try {
        final android = await _deviceInfo.androidInfo;
        final manufacturer = android.manufacturer.toLowerCase();
        final brand = android.brand.toLowerCase();
        final combined = '$manufacturer $brand';

        if (combined.contains('infinix') ||
            combined.contains('tecno') ||
            combined.contains('itel') ||
            combined.contains('transsion')) {
          return BrandBatteryGuide(
            family: DeviceBrandFamily.transsion,
            brandName: 'Infinix / Tecno',
            osName: L10n.t.batteryOptimizationHelper1,
            steps: [
              L10n.t.batteryOptimizationHelper2,
              L10n.t.batteryOptimizationHelper3,
              L10n.t.batteryOptimizationHelper4,
              L10n.t.batteryOptimizationHelper5,
            ],
          );
        }

        if (combined.contains('xiaomi') ||
            combined.contains('redmi') ||
            combined.contains('poco')) {
          return BrandBatteryGuide(
            family: DeviceBrandFamily.xiaomi,
            brandName: 'Xiaomi / Redmi',
            osName: L10n.t.batteryOptimizationHelper6,
            steps: [
              L10n.t.batteryOptimizationHelper7,
              L10n.t.batteryOptimizationHelper8,
              L10n.t.batteryOptimizationHelper9,
            ],
          );
        }

        if (combined.contains('oppo') ||
            combined.contains('realme') ||
            combined.contains('oneplus')) {
          return BrandBatteryGuide(
            family: DeviceBrandFamily.oppo,
            brandName: 'Oppo / Realme',
            osName: L10n.t.batteryOptimizationHelper10,
            steps: [
              L10n.t.batteryOptimizationHelper11,
              L10n.t.batteryOptimizationHelper12,
              L10n.t.batteryOptimizationHelper13,
            ],
          );
        }

        if (combined.contains('samsung')) {
          return BrandBatteryGuide(
            family: DeviceBrandFamily.samsung,
            brandName: 'Samsung Galaxy',
            osName: L10n.t.batteryOptimizationHelper14,
            steps: [
              L10n.t.batteryOptimizationHelper15,
              L10n.t.batteryOptimizationHelper16,
              L10n.t.batteryOptimizationHelper17,
            ],
          );
        }

        if (combined.contains('huawei') || combined.contains('honor')) {
          return BrandBatteryGuide(
            family: DeviceBrandFamily.huawei,
            brandName: 'Huawei / Honor',
            osName: L10n.t.batteryOptimizationHelper18,
            steps: [
              L10n.t.batteryOptimizationHelper19,
              L10n.t.batteryOptimizationHelper20,
            ],
          );
        }
      } catch (e) {
        debugPrint('Error inspecting device info: $e');
      }
    }

    // Default / iOS / Desktop / Other Android
    return BrandBatteryGuide(
      family: DeviceBrandFamily.generic,
      brandName: L10n.t.batteryOptimizationHelper21,
      osName: L10n.t.batteryOptimizationHelper22,
      steps: [
        L10n.t.batteryOptimizationHelper23,
        L10n.t.batteryOptimizationHelper24,
        L10n.t.batteryOptimizationHelper25,
      ],
    );
  }

  /// Opens the device battery optimization settings.
  static Future<bool> openBatterySettings() async {
    if (kIsWeb || !Platform.isAndroid) return false;
    try {
      final res = await _channel.invokeMethod<bool>('openBatteryOptimizationSettings');
      return res ?? false;
    } catch (e) {
      debugPrint('Failed to open battery settings: $e');
      return false;
    }
  }

  /// Opens application details settings.
  static Future<bool> openAppSettings() async {
    if (kIsWeb || !Platform.isAndroid) return false;
    try {
      final res = await _channel.invokeMethod<bool>('openAppSettings');
      return res ?? false;
    } catch (e) {
      debugPrint('Failed to open app settings: $e');
      return false;
    }
  }
}
