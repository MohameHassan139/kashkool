import 'dart:math';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/growth/growth_footer.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';

void main() {
  group('GrowthFooter', () {
    test('generates valid 6-char codes without ambiguous characters', () {
      final rnd = Random(42);
      for (var i = 0; i < 200; i++) {
        final code = GrowthFooter.generateShopCode(rnd);
        expect(code.length, 6);
        expect(GrowthFooter.isValidCode(code), isTrue);
        expect(code, isNot(matches(RegExp('[01OI]'))));
      }
    });

    test('builds Play Store link with URL-encoded referral param', () {
      expect(
        GrowthFooter.buildLink('ABC234'),
        'https://play.google.com/store/apps/details?id=com.kashkool&referrer=ref%3DABC234',
      );
      expect(GrowthFooter.buildLink(null), GrowthFooter.playStoreBase);
    });

    test('footer text matches spec format', () {
      final text = GrowthFooter.footerText('ABC234');
      expect(text, startsWith('—\nاتعمل بكشكول 📒 جرّبه ببلاش: https://'));
      expect(text, endsWith('ref%3DABC234'));
    });

    test('share message contains the referral link', () {
      expect(GrowthFooter.shareMessage('ABC234'), contains('ref%3DABC234'));
    });
  });

  group('SettingsRepository shop code', () {
    late AppDatabase db;
    late SettingsRepository repo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repo = SettingsRepository(db);
    });

    tearDown(() async => db.close());

    test('referral code is stable across repeated calls / restarts', () async {
      final first = await repo.getOrCreateShopCode();
      final second = await repo.getOrCreateShopCode();
      // Simulate app restart: new repository instance over the same DB.
      final third = await SettingsRepository(db).getOrCreateShopCode();

      expect(GrowthFooter.isValidCode(first), isTrue);
      expect(second, first);
      expect(third, first);
    });

    test('growth footer cannot be disabled in the Free tier', () async {
      await repo.setGrowthFooterEnabled(false);
      expect(await repo.isGrowthFooterEnabled(), isTrue);

      await repo.setGrowthFooterEnabled(false, isPaidTier: true);
      expect(await repo.isGrowthFooterEnabled(isPaidTier: true), isFalse);
      // Free tier still forces the footer on.
      expect(await repo.isGrowthFooterEnabled(), isTrue);
    });
  });
}
