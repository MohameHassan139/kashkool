import 'package:flutter/widgets.dart';
import 'app_localizations.dart';

/// A language the user can pick in Settings → Language.
class AppLanguage {
  /// Stored in settings, e.g. `ar_EG`, `ar`, `en`.
  final String code;

  /// The language's name written in that language (never translated).
  final String nativeName;
  final Locale locale;

  const AppLanguage(this.code, this.nativeName, this.locale);
}

/// Context-free access to the current translations.
///
/// Widgets can use `L10n.t.<key>` (or `AppLocalizations.of(context)`); services, notifications,
/// the home widget and PDF code use `L10n.t` because they have no BuildContext.
/// `KashkoolApp` calls [setLocale] whenever the language changes and rebuilds the whole tree.
abstract final class L10n {
  /// Egyptian Arabic is the app's main language (and the fallback in tests).
  static const Locale fallback = Locale('ar', 'EG');

  /// Value saved in settings when the app follows the phone's language.
  static const String systemCode = 'system';

  static const List<AppLanguage> languages = [
    AppLanguage('ar_EG', 'مصري', Locale('ar', 'EG')),
    AppLanguage('ar', 'العربية الفصحى', Locale('ar')),
    AppLanguage('en', 'English', Locale('en')),
    AppLanguage('fr', 'Français', Locale('fr')),
    AppLanguage('tr', 'Türkçe', Locale('tr')),
    AppLanguage('ur', 'اردو', Locale('ur')),
    AppLanguage('hi', 'हिन्दी', Locale('hi')),
    AppLanguage('id', 'Bahasa Indonesia', Locale('id')),
    AppLanguage('fa', 'فارسی', Locale('fa')),
  ];

  static const Set<String> _rtlLanguages = {'ar', 'fa', 'ur'};

  static Locale _locale = fallback;
  static AppLocalizations _t = lookupAppLocalizations(fallback);

  /// Translations for the current app language.
  static AppLocalizations get t => _t;

  static Locale get locale => _locale;

  static bool get isRtl => _rtlLanguages.contains(_locale.languageCode);

  /// The PDF statement's font (Cairo) has Arabic and Latin letters only, so Hindi statements use English.
  static AppLocalizations get pdf => _locale.languageCode == 'hi' ? lookupAppLocalizations(const Locale('en')) : _t;

  static bool get pdfIsRtl => _locale.languageCode != 'hi' && isRtl;

  static void setLocale(Locale locale) {
    if (locale == _locale) return;
    _locale = locale;
    _t = lookupAppLocalizations(locale);
  }

  /// The saved setting (`system`, `ar_EG`, `en`, …) → a locale, or null to follow the phone.
  static Locale? localeForCode(String? code) {
    if (code == null || code == systemCode) return null;
    for (final l in languages) {
      if (l.code == code) return l.locale;
    }
    return null;
  }

  /// Picks the best supported language for the phone's languages.
  /// Arabic phones get Egyptian Arabic in Egypt (or when no country is set) and Modern Standard Arabic elsewhere.
  static Locale resolve(List<Locale>? deviceLocales) {
    for (final device in deviceLocales ?? const <Locale>[]) {
      if (device.languageCode == 'ar') {
        final country = device.countryCode;
        return (country == null || country.isEmpty || country == 'EG') ? fallback : const Locale('ar');
      }
      for (final l in languages) {
        if (l.locale.languageCode == device.languageCode && l.locale.countryCode == null) return l.locale;
      }
      // Some phones report Indonesian with the old code "in".
      if (device.languageCode == 'in') return const Locale('id');
    }
    return const Locale('en');
  }
}
