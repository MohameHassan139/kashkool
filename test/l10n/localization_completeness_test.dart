import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:kashkool/core/utils/money.dart';
import 'package:kashkool/l10n/l10n.dart';

Map<String, dynamic> _readArb(String code) {
  final file = File('lib/l10n/app_$code.arb');
  if (!file.existsSync()) {
    throw StateError('Missing ARB file for $code at ${file.path}');
  }
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

Set<String> _messages(Map<String, dynamic> arb) =>
    arb.keys.where((key) => !key.startsWith('@')).toSet();

List<String> _placeholders(String value) {
  final result = RegExp(r'\{([^{}]+)\}')
      .allMatches(value)
      .map((match) => match.group(1)!)
      .toList()
    ..sort();
  return result;
}

void main() {
  final template = _readArb('ar_EG');
  final templateKeys = _messages(template);

  test('all supported languages have every message translated', () {
    for (final language in L10n.languages) {
      final arb = _readArb(language.code);
      final keys = _messages(arb);
      expect(
        keys.difference(templateKeys),
        isEmpty,
        reason: '${language.code} has unknown keys: ${keys.difference(templateKeys)}',
      );
      expect(
        templateKeys.difference(keys),
        isEmpty,
        reason: '${language.code} is missing: ${templateKeys.difference(keys)}',
      );
      for (final key in templateKeys) {
        final value = arb[key] as String?;
        expect(value, isNotNull, reason: '${language.code}.$key is null');
        expect(value!.trim(), isNotEmpty, reason: '${language.code}.$key is empty');
        expect(
          _placeholders(value),
          equals(_placeholders(template[key] as String)),
          reason: '${language.code}.$key changed placeholders',
        );
      }
    }
  });

  test('gen-l10n reports no untranslated messages', () {
    final file = File('lib/l10n/untranslated.json');
    expect(file.existsSync(), isTrue);
    final report = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    for (final entry in report.entries) {
      expect(entry.value, isEmpty, reason: '${entry.key} still has missing keys');
    }
  });

  test('language selection, direction and Intl locale follow the chosen language', () {
    for (final language in L10n.languages) {
      L10n.setLocale(language.locale);
      expect(L10n.t.localeName, language.locale.toString());
      expect(Intl.defaultLocale, language.locale.toString());
    }

    L10n.setLocale(const Locale('ar'));
    expect(L10n.isRtl, isTrue);
    L10n.setLocale(const Locale('fa'));
    expect(L10n.isRtl, isTrue);
    L10n.setLocale(const Locale('ur'));
    expect(L10n.isRtl, isTrue);
    L10n.setLocale(const Locale('en'));
    expect(L10n.isRtl, isFalse);

    // The Cairo PDF font has no Devanagari glyphs, so Hindi PDFs use English.
    L10n.setLocale(const Locale('hi'));
    expect(L10n.pdf.localeName, 'en');
    expect(L10n.pdfIsRtl, isFalse);

    expect(L10n.localeForCode(L10n.systemCode), isNull);
    expect(L10n.localeForCode('ar_EG'), const Locale('ar', 'EG'));
    expect(L10n.resolve(const [Locale('ar', 'SA')]), const Locale('ar'));
    expect(L10n.resolve(const [Locale('ar', 'EG')]), L10n.fallback);
    expect(L10n.resolve(const [Locale('in')]), const Locale('id'));
    expect(L10n.resolve(const []), const Locale('en'));
  });

  test('currency and MoneyUtils.formatMoney dynamically follow active language', () {
    final expectedCurrencies = {
      'ar_EG': 'جنيه',
      'ar': 'جنيه',
      'en': 'EGP',
      'tr': 'TL',
      'fr': '€',
      'ur': 'روپے',
      'hi': '₹',
      'id': 'Rp',
      'fa': 'تومان',
    };

    for (final entry in expectedCurrencies.entries) {
      final locale = L10n.localeForCode(entry.key)!;
      L10n.setLocale(locale);
      expect(L10n.t.currency, equals(entry.value), reason: 'currency mismatch for ${entry.key}');
      expect(L10n.t.money1, equals(entry.value), reason: 'money1 mismatch for ${entry.key}');
      expect(MoneyUtils.formatMoney(5000), equals('50 ${entry.value}'), reason: 'formatMoney mismatch for ${entry.key}');
    }
  });
}
