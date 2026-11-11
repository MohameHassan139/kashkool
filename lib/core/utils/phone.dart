import 'package:phone_numbers_parser/phone_numbers_parser.dart';

/// Utilities for phone numbers parsing, validation, normalization, and WhatsApp formatting.
/// Supports both Egyptian local numbers (entered with or without country code) and
/// international numbers.
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

  /// Parses a phone string into a [PhoneNumber] object.
  ///
  /// - Supports Arabic numerals (`٠١٠...`).
  /// - Automatically interprets local numbers without country code as Egyptian numbers (`IsoCode.EG`).
  /// - Handles numbers with international prefixes (`+20`, `0020`, `+966`, `00966`, etc.).
  /// - Handles Egyptian mobile numbers entered as 10 digits (`1012345678`) by prepending `0`.
  /// - Handles international numbers entered without `+` (e.g. `966501234567`).
  ///
  /// Returns `null` if the input is empty or cannot be parsed.
  static PhoneNumber? parse(String? input) {
    if (input == null || input.trim().isEmpty) return null;

    var cleaned = input.trim();
    _arabicDigits.forEach((ar, en) {
      cleaned = cleaned.replaceAll(ar, en);
    });

    final hasPlus = cleaned.startsWith('+');
    cleaned = cleaned.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) return null;
    if (hasPlus) cleaned = '+$cleaned';

    if (cleaned.startsWith('00')) {
      cleaned = '+${cleaned.substring(2)}';
    }

    try {
      if (cleaned.startsWith('+')) {
        final p = PhoneNumber.parse(cleaned);
        if (p.isValid()) return p;
      }

      // Handle Egyptian mobile without leading 0 (e.g. 1012345678)
      if (cleaned.length == 10 &&
          (cleaned.startsWith('10') ||
              cleaned.startsWith('11') ||
              cleaned.startsWith('12') ||
              cleaned.startsWith('15'))) {
        cleaned = '0$cleaned';
      }

      // Handle Egyptian number starting with 20 (e.g. 201012345678)
      if (cleaned.length == 12 && cleaned.startsWith('201')) {
        cleaned = '0${cleaned.substring(2)}';
      }

      // Parse with Egypt as destination country
      final egPhone = PhoneNumber.parse(cleaned, destinationCountry: IsoCode.EG);
      if (egPhone.isValid()) return egPhone;

      // If not valid as Egyptian and does not start with 0, try parsing as international (+...)
      if (!cleaned.startsWith('0')) {
        final intlPhone = PhoneNumber.parse('+$cleaned');
        if (intlPhone.isValid()) return intlPhone;
      }

      return egPhone;
    } catch (_) {
      return null;
    }
  }

  /// Checks whether the given phone string is a valid real phone number
  /// (Egyptian or international).
  static bool isValid(String? input) {
    final p = parse(input);
    return p != null && p.isValid();
  }

  /// Alias for backward compatibility: checks whether the input is a valid phone number.
  static bool isValidEgyptianMobile(String? input) {
    return isValid(input);
  }

  /// Normalizes a valid phone number for database storage.
  ///
  /// - For Egyptian numbers: returns standard Egyptian format (`01XXXXXXXXX` for mobile, `0XXXXXXXX` for landlines).
  /// - For International numbers: returns standard E.164 format (`+<countryCode><nsn>`, e.g. `+966501234567`).
  ///
  /// Returns `null` if the input is not a valid phone number.
  static String? normalize(String? input) {
    final p = parse(input);
    if (p == null || !p.isValid()) return null;

    if (p.isoCode == IsoCode.EG) {
      return '0${p.nsn}';
    }

    return '+${p.countryCode}${p.nsn}';
  }

  /// Backward-compatible alias for [normalize].
  static String? normalizeEgyptianMobile(String? input) {
    return normalize(input);
  }

  /// Converts a phone number to WhatsApp format for `wa.me/<digits>` links
  /// (country code + national number without `+`, spaces, or leading zeros).
  ///
  /// - Egyptian `01012345678` -> `201012345678`
  /// - Saudi `+966501234567` -> `966501234567`
  ///
  /// Returns `null` if the number is not a valid phone number.
  static String? toWhatsAppFormat(String? input) {
    final p = parse(input);
    if (p == null || !p.isValid()) return null;
    return '${p.countryCode}${p.nsn}';
  }

  /// Formats the phone number for readable display in the UI.
  ///
  /// - Egyptian mobile: `010 1234 5678`
  /// - International: `+966 50 123 4567`
  static String formatDisplay(String? input) {
    if (input == null || input.trim().isEmpty) return '';
    final p = parse(input);
    if (p == null || !p.isValid()) return input.trim();

    if (p.isoCode == IsoCode.EG &&
        p.nsn.length == 10 &&
        (p.nsn.startsWith('10') ||
            p.nsn.startsWith('11') ||
            p.nsn.startsWith('12') ||
            p.nsn.startsWith('15'))) {
      final local = '0${p.nsn}';
      return '${local.substring(0, 3)} ${local.substring(3, 7)} ${local.substring(7)}';
    }

    return p.international;
  }
}
