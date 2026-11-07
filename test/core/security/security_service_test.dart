import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/security/security_service.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository settingsRepo;
  late SecurityService securityService;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    settingsRepo = SettingsRepository(db);
    securityService = SecurityService(settingsRepo: settingsRepo);
  });

  tearDown(() async {
    await db.close();
  });

  group('SecurityService PIN Hashing & Validation', () {
    test('hashPin generates consistent salted SHA-256 hash', () {
      final hash1 = SecurityService.hashPin('1234', 'testsalt');
      final hash2 = SecurityService.hashPin('1234', 'testsalt');
      final hashDiffSalt = SecurityService.hashPin('1234', 'differentsalt');
      final hashDiffPin = SecurityService.hashPin('5678', 'testsalt');

      expect(hash1, equals(hash2));
      expect(hash1, isNot(equals(hashDiffSalt)));
      expect(hash1, isNot(equals(hashDiffPin)));
      expect(hash1.length, equals(64)); // SHA-256 hex length
    });

    test('generateSalt generates random non-empty salts', () {
      final salt1 = SecurityService.generateSalt();
      final salt2 = SecurityService.generateSalt();

      expect(salt1, isNotEmpty);
      expect(salt2, isNotEmpty);
      expect(salt1, isNot(equals(salt2)));
    });

    test('enforces 4 numeric digits in setPin', () async {
      expect(() => securityService.setPin('123'), throwsArgumentError);
      expect(() => securityService.setPin('12345'), throwsArgumentError);
      expect(() => securityService.setPin('abcd'), throwsArgumentError);

      await securityService.setPin('4321');
      expect(await securityService.hasPin(), isTrue);
    });

    test('verifies correct PIN and rejects wrong PIN', () async {
      // When no PIN is set, verify returns true
      expect(await securityService.verifyPin('1234'), isTrue);

      await securityService.setPin('9876');

      expect(await securityService.verifyPin('9876'), isTrue);
      expect(await securityService.verifyPin('1234'), isFalse);
      expect(await securityService.verifyPin('9870'), isFalse);

      await securityService.removePin();
      expect(await securityService.hasPin(), isFalse);
    });
  });

  group('AppLockNotifier State Lifecycle', () {
    test('initializes unlocked when no PIN exists', () async {
      final notifier = AppLockNotifier(securityService, settingsRepo);
      expect(notifier.state, isFalse);
    });

    test('initializes locked when PIN is set', () async {
      await securityService.setPin('1111');
      final notifier = AppLockNotifier(securityService, settingsRepo);
      // Wait for async initialization
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(notifier.state, isTrue);

      notifier.unlock();
      expect(notifier.state, isFalse);

      notifier.lock();
      expect(notifier.state, isTrue);
    });

    test('locks on app resumed if timeout exceeded', () async {
      await securityService.setPin('1111');
      await settingsRepo.setLockTimeoutMinutes(0); // immediate

      final notifier = AppLockNotifier(securityService, settingsRepo);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      notifier.unlock();
      expect(notifier.state, isFalse);

      notifier.onAppPaused();
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await notifier.onAppResumed();

      expect(notifier.state, isTrue);
    });
  });
}
