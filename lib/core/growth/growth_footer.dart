import 'dart:math';

/// Growth footer & referral link utilities (Feature 11).
///
/// Every outgoing message / PDF advertises the app with a referral link
/// carrying the shop's stable referral code.
abstract final class GrowthFooter {
  static const String playStoreBase =
      'https://play.google.com/store/apps/details?id=com.kashkool';

  /// Characters used for referral codes (no ambiguous 0/O/1/I).
  static const String _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  static const int codeLength = 6;

  /// Generates a random 6-char shop referral code.
  static String generateShopCode([Random? random]) {
    final rnd = random ?? Random.secure();
    return List.generate(codeLength, (_) => _alphabet[rnd.nextInt(_alphabet.length)]).join();
  }

  /// Validates a referral code format.
  static bool isValidCode(String? code) =>
      code != null && RegExp('^[$_alphabet]{$codeLength}\$').hasMatch(code);

  /// Play Store link with referral param: `referrer=ref%3D{shopCode}`.
  static String buildLink(String? shopCode) {
    if (shopCode == null || shopCode.isEmpty) return playStoreBase;
    return '$playStoreBase&referrer=ref%3D$shopCode';
  }

  /// Footer text appended to messages and PDFs.
  static String footerText(String? shopCode) =>
      '—\nاتعمل بكشكول 📒 جرّبه ببلاش: ${buildLink(shopCode)}';

  /// Ready-made invite message for "شارك التطبيق".
  static String shareMessage(String? shopCode) =>
      'أنا بستخدم كشكول 📒 عشان أتابع حسابات الزباين والموردين والدرج من غير دفتر ورق.\n'
      'سهل جداً وشغال من غير نت. جرّبه ببلاش:\n${buildLink(shopCode)}';
}
