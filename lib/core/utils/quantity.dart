/// Fixed-point quantity helpers. One unit is represented by 1,000 milli-units.
abstract final class QuantityUtils {
  static int? parseMilliUnits(String input) {
    var value = input.trim();
    const digits = {
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
    digits.forEach((arabic, western) {
      value = value.replaceAll(arabic, western);
    });
    value = value.replaceAll('٫', '.').replaceAll(',', '');
    if (!RegExp(r'^\d+(\.\d{1,3})?$').hasMatch(value)) return null;

    final parts = value.split('.');
    final whole = int.tryParse(parts.first);
    if (whole == null) return null;
    final fraction = parts.length == 1 ? '' : parts[1].padRight(3, '0');
    final fractional = fraction.isEmpty ? 0 : int.parse(fraction);
    return whole * 1000 + fractional;
  }

  static String formatMilliUnits(int milliUnits) {
    final isNegative = milliUnits < 0;
    final absolute = milliUnits.abs();
    final whole = absolute ~/ 1000;
    final remainder = absolute % 1000;
    if (remainder == 0) return '${isNegative ? '-' : ''}$whole';
    final fraction = remainder
        .toString()
        .padLeft(3, '0')
        .replaceFirst(RegExp(r'0+$'), '');
    return '${isNegative ? '-' : ''}$whole.$fraction';
  }
}
