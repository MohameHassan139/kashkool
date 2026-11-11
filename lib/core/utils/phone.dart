/// Utilities for phone validation, Egyptian normalization, and WhatsApp formatting.
abstract final class PhoneUtils {
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
  };

  /// Allowed Egyptian mobile network prefixes (after the leading 0).
  static const List<String> validPrefixes = ['010', '011', '012', '015'];

  /// Normalizes an input string by converting Arabic numerals and stripping non-digit characters
  /// (except preserving a single leading `+` if present during raw parsing).
  static String cleanDigits(String input) {
    var cleaned = input.trim();
    _arabicDigits.forEach((ar, en) {
      cleaned = cleaned.replaceAll(ar, en);
    });
    // Remove non-digit characters
    return cleaned.replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// Normalizes any valid Egyptian mobile phone number into the standard 11-digit local format: `01XXXXXXXXX`.
  ///
  /// Handles formats like:
  /// - `01012345678` -> `01012345678`
  /// - `+201012345678` -> `01012345678`
  /// - `00201012345678` -> `01012345678`
  /// - `201012345678` -> `01012345678`
  /// - `010 1234 5678` -> `01012345678`
  /// - `٠١٠١٢٣٤٥٦٧٨` -> `01012345678`
  ///
  /// Returns `null` if the input is not a valid Egyptian mobile number.
  static String? normalizeEgyptianMobile(String? input) {
    if (input == null) return null;
    var digits = cleanDigits(input);

    if (digits.isEmpty) return null;

    // Handle international prefixes
    if (digits.startsWith('0020')) {
      digits = digits.substring(4);
    } else if (digits.startsWith('20') && digits.length == 12) {
      digits = digits.substring(2);
    }

    // Ensure leading 0 if 10 digits starting with 10, 11, 12, 15
    if (digits.length == 10 &&
        (digits.startsWith('10') ||
            digits.startsWith('11') ||
            digits.startsWith('12') ||
            digits.startsWith('15'))) {
      digits = '0$digits';
    }

    if (digits.length != 11) {
      return null;
    }

    final prefix = digits.substring(0, 3);
    if (!validPrefixes.contains(prefix)) {
      return null;
    }

    return digits;
  }

  /// Checks whether the given phone string is a valid Egyptian mobile number.
  static bool isValidEgyptianMobile(String? input) {
    return normalizeEgyptianMobile(input) != null;
  }

  /// Accepts valid international numbers and local numbers with 7-15 digits.
  static bool isValidPhone(String? input) => normalizePhone(input) != null;

  /// Normalizes Egyptian mobiles to the existing local format and preserves
  /// other numbers as digits or an international `+`-prefixed number.
  static String? normalizePhone(String? input) {
    if (input == null || input.trim().isEmpty) return null;
    final value = _normalizeDigits(input.trim());
    if (!RegExp(r'^\+?[0-9\s().-]+$').hasMatch(value)) return null;
    final egyptian = normalizeEgyptianMobile(value);
    if (egyptian != null) return egyptian;

    final digits = cleanDigits(value);
    final internationalDigits = value.startsWith('00')
        ? digits.substring(2)
        : digits;
    if (internationalDigits.length < 7 || internationalDigits.length > 15) {
      return null;
    }
    if (value.startsWith('+')) return '+$digits';
    if (value.startsWith('00')) return '+$internationalDigits';
    return digits;
  }

  /// Converts a phone number to WhatsApp international format (`201XXXXXXXXX` without `+`).
  ///
  /// Non-Egyptian numbers must include an international prefix.
  static String? toWhatsAppFormat(String? input) {
    final local = normalizeEgyptianMobile(input);
    if (local == null) {
      final normalized = normalizePhone(input);
      if (normalized == null || !normalized.startsWith('+')) return null;
      return normalized.substring(1);
    }
    // Strip leading '0' and prepend Egypt country code '20'
    return '20${local.substring(1)}';
  }

  /// Formats the phone number for readable display in the UI: `010 1234 5678`.
  static String formatDisplay(String? input) {
    final normalized = normalizeEgyptianMobile(input);
    if (normalized == null) return input?.trim() ?? '';
    return '${normalized.substring(0, 3)} ${normalized.substring(3, 7)} ${normalized.substring(7)}';
  }

  static String _normalizeDigits(String input) {
    var normalized = input;
    _arabicDigits.forEach((ar, en) {
      normalized = normalized.replaceAll(ar, en);
    });
    return normalized;
  }
}
