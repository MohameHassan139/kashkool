import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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
          return const BrandBatteryGuide(
            family: DeviceBrandFamily.transsion,
            brandName: 'Infinix / Tecno',
            osName: 'نظام XOS / HiOS',
            steps: [
              'افتح تطبيق Phone Master (مدير الهاتف) الموجود على جهازك.',
              'ادخل على "إدارة التشغيل التلقائي (Auto-start)" وفعّل تطبيق كشكول.',
              'في إعدادات التطبيق، ادخل على "البطارية" واختر "بلا قيود (Unrestricted)".',
              'في شاشة التطبيقات المفتوحة، اسحب التطبيق لأسفل لتثبيته بالقفل 🔒.',
            ],
          );
        }

        if (combined.contains('xiaomi') ||
            combined.contains('redmi') ||
            combined.contains('poco')) {
          return const BrandBatteryGuide(
            family: DeviceBrandFamily.xiaomi,
            brandName: 'Xiaomi / Redmi',
            osName: 'نظام MIUI / HyperOS',
            steps: [
              'ادخل على إعدادات التطبيق وفعّل "التشغيل التلقائي (Autostart)".',
              'من "موفر البطارية (Battery Saver)"، اختر "بلا قيود (No Restrictions)".',
              'من شاشة التطبيقات الحديثة، اضغط ضغطة مطولة على كشكول واختر أيقونة القفل 🔒.',
            ],
          );
        }

        if (combined.contains('oppo') ||
            combined.contains('realme') ||
            combined.contains('oneplus')) {
          return const BrandBatteryGuide(
            family: DeviceBrandFamily.oppo,
            brandName: 'Oppo / Realme',
            osName: 'نظام ColorOS / Realme UI',
            steps: [
              'من إعدادات التطبيق -> استخدام البطارية، فعّل "السماح بالنشاط في الخلفية".',
              'فعّل خيار "التشغيل التلقائي (Auto-launch)".',
              'في قائمة التطبيقات المفتوحة، اضغط على النقاط الثلاث واختر "تثبيت (Lock)".',
            ],
          );
        }

        if (combined.contains('samsung')) {
          return const BrandBatteryGuide(
            family: DeviceBrandFamily.samsung,
            brandName: 'Samsung Galaxy',
            osName: 'نظام One UI',
            steps: [
              'ادخل على الإعدادات -> العناية بالجهاز (Device Care) -> البطارية.',
              'ادخل على "حدود استخدام الخلفية (Background usage limits)".',
              'أضف كشكول إلى قائمة "التطبيقات التي لا تنام أبداً (Never sleeping apps)".',
            ],
          );
        }

        if (combined.contains('huawei') || combined.contains('honor')) {
          return const BrandBatteryGuide(
            family: DeviceBrandFamily.huawei,
            brandName: 'Huawei / Honor',
            osName: 'نظام EMUI / MagicOS',
            steps: [
              'ادخل على الإعدادات -> البطارية -> بدء تشغيل التطبيقات (App Launch).',
              'ابحث عن "كشكول"، حوّل الإدارة إلى يدوية، وفعّل (التشغيل التلقائي + العمل في الخلفية).',
            ],
          );
        }
      } catch (e) {
        debugPrint('Error inspecting device info: $e');
      }
    }

    // Default / iOS / Desktop / Other Android
    return const BrandBatteryGuide(
      family: DeviceBrandFamily.generic,
      brandName: 'إعدادات النظام',
      osName: 'حماية إشعارات النظام',
      steps: [
        'ادخل على معلومات التطبيق في إعدادات الهاتف.',
        'ادخل على قسم "البطارية (Battery)" واختر "غير مقيد (Unrestricted)".',
        'تأكد من عدم تفعيل وضع توفير الطاقة الفائق على الهاتف لضمان وصول تنبيهات التحصيل.',
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
