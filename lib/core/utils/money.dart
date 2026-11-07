import 'package:intl/intl.dart';

/// Utilities for financial amounts in Kashkool.
///
/// CRITICAL ARCHITECTURAL RULE:
/// All money in Kashkool is stored internally as integer piasters (قروش), NEVER as double.
/// 1 Egyptian Pound (جنيه) = 100 Piasters (قرش).
abstract final class MoneyUtils {
  static const int piastersPerPound = 100;

  /// Arabic-Indic digits to standard ASCII digits mapping.
  static const Map<String, String> _arabicDigits = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
    '٫': '.', // Arabic decimal separator
    '٬': '',  // Arabic thousands separator
  };

  /// Normalizes an input string containing Arabic or English digits, commas, and spaces.
  static String normalizeNumberString(String input) {
    var cleaned = input.trim();
    _arabicDigits.forEach((ar, en) {
      cleaned = cleaned.replaceAll(ar, en);
    });
    // Remove standard thousands commas and any whitespace
    cleaned = cleaned.replaceAll(',', '').replaceAll(' ', '');
    return cleaned;
  }

  /// Converts a user input string (in Egyptian Pounds) into integer piasters.
  ///
  /// Examples:
  /// - `"50"` -> `5000`
  /// - `"12.5"` -> `1250`
  /// - `"12.50"` -> `1250`
  /// - `"1,000"` -> `100000`
  /// - `"١٢.٥"` -> `1250`
  /// - `"-10"` -> `-1000`
  /// - `""` or invalid -> returns `0` (or `fallback` if specified)
  static int toPiasters(String input, {int fallback = 0}) {
    final cleaned = normalizeNumberString(input);
    if (cleaned.isEmpty) return fallback;

    // Check if input is a valid decimal number
    final isNegative = cleaned.startsWith('-');
    final absCleaned = isNegative ? cleaned.substring(1) : cleaned;

    if (absCleaned.isEmpty) return fallback;

    final parts = absCleaned.split('.');
    if (parts.length > 2) {
      // More than one dot: invalid number
      return fallback;
    }

    final poundsPart = int.tryParse(parts[0]);
    if (poundsPart == null && parts[0].isNotEmpty) {
      return fallback;
    }

    final pounds = poundsPart ?? 0;
    var piasters = 0;

    if (parts.length == 2) {
      final decimalStr = parts[1];
      if (decimalStr.isEmpty) {
        piasters = 0;
      } else if (decimalStr.length == 1) {
        final d = int.tryParse(decimalStr);
        if (d == null) return fallback;
        piasters = d * 10;
      } else if (decimalStr.length == 2) {
        final d = int.tryParse(decimalStr);
        if (d == null) return fallback;
        piasters = d;
      } else {
        // More than 2 decimal places: round to nearest piaster
        final firstTwo = int.tryParse(decimalStr.substring(0, 2));
        final thirdDigit = int.tryParse(decimalStr[2]);
        if (firstTwo == null || thirdDigit == null) return fallback;
        piasters = thirdDigit >= 5 ? firstTwo + 1 : firstTwo;
      }
    }

    final total = (pounds * piastersPerPound) + piasters;
    return isNegative ? -total : total;
  }

  /// Converts integer piasters to Egyptian Pounds as double (use only for display or charts).
  static double toPounds(int piasters) => piasters / piastersPerPound;

  /// Formats an integer amount in piasters into a clean, human-readable Egyptian currency string.
  ///
  /// Examples:
  /// - `formatMoney(5000)` -> `"50 جنيه"`
  /// - `formatMoney(1250)` -> `"12.50 جنيه"`
  /// - `formatMoney(100000)` -> `"1,000 جنيه"`
  /// - `formatMoney(5000, includeCurrency: false)` -> `"50"`
  /// - `formatMoney(-2500)` -> `"-25 جنيه"`
  static String formatMoney(
    int piasters, {
    bool includeCurrency = true,
    String currency = 'جنيه',
  }) {
    final isNegative = piasters < 0;
    final absPiasters = piasters.abs();

    final pounds = absPiasters ~/ piastersPerPound;
    final remainingPiasters = absPiasters % piastersPerPound;

    final formatter = NumberFormat('#,##0', 'en_US');
    final formattedPounds = formatter.format(pounds);

    final String amountStr;
    if (remainingPiasters == 0) {
      amountStr = formattedPounds;
    } else {
      amountStr = '$formattedPounds.${remainingPiasters.toString().padLeft(2, '0')}';
    }

    final signedStr = isNegative ? '-$amountStr' : amountStr;
    return includeCurrency ? '$signedStr $currency' : signedStr;
  }
}
