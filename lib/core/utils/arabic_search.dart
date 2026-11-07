/// Utilities for Arabic search and normalization.
///
/// Ensures search matches regardless of common Arabic orthographic variations:
/// - Alef variants: أ, إ, آ, ٱ -> ا
/// - Taa Marbouta / Haa: ة -> ه
/// - Yaa / Alef Maksoura: ى -> ي
/// - Removes diacritics (tashkeel) and tatweel (kashida).
abstract final class ArabicSearchUtils {
  static final RegExp _tashkeelRegex = RegExp(r'[\u064B-\u0652\u0670]');
  static final RegExp _tatweelRegex = RegExp(r'\u0640');

  /// Normalizes Arabic text for uniform, tolerant search matching.
  static String normalize(String text) {
    var result = text.trim();

    // Remove tashkeel (diacritics)
    result = result.replaceAll(_tashkeelRegex, '');

    // Remove tatweel
    result = result.replaceAll(_tatweelRegex, '');

    // Normalize Alef forms
    result = result
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ٱ', 'ا');

    // Normalize Taa Marbouta
    result = result.replaceAll('ة', 'ه');

    // Normalize Yaa / Alef Maksoura
    result = result.replaceAll('ى', 'ي');

    return result.toLowerCase();
  }

  /// Returns true if [source] contains [searchQuery] after Arabic normalization.
  static bool matches(String source, String searchQuery) {
    if (searchQuery.trim().isEmpty) return true;
    final normalizedSource = normalize(source);
    final normalizedQuery = normalize(searchQuery);
    return normalizedSource.contains(normalizedQuery);
  }
}
