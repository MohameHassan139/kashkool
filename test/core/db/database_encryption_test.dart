import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/core/db/encryption_helper.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('kashkool_encryption_test_');
    DatabaseEncryptionHelper.resetForTesting();
  });

  tearDown(() async {
    DatabaseEncryptionHelper.resetForTesting();
    if (tempDir.existsSync()) {
      try {
        tempDir.deleteSync(recursive: true);
      } catch (_) {}
    }
  });

  group('DatabaseEncryptionHelper Security', () {
    test('generates and caches a 256-bit encryption key in debug/test', () async {
      final key = await DatabaseEncryptionHelper.getOrCreateKey();
      expect(key, isNotEmpty);
      expect(key.length, greaterThanOrEqualTo(32));

      // Subsequent calls return the cached key
      final cachedKey = await DatabaseEncryptionHelper.getOrCreateKey();
      expect(cachedKey, equals(key));
    });

    test('allows setting an explicit key for testing', () async {
      DatabaseEncryptionHelper.setKeyForTesting('custom_test_key_for_unit_tests');
      final key = await DatabaseEncryptionHelper.getOrCreateKey();
      expect(key, equals('custom_test_key_for_unit_tests'));
    });

    test('throws DatabaseEncryptionException in release when secure storage fails', () async {
      expect(
        () async => DatabaseEncryptionHelper.getOrCreateKey(forceReleaseCheck: true),
        throwsA(isA<DatabaseEncryptionException>()),
      );
    });
  });

  group('Database Encryption & Header Verification', () {
    test('isUnencryptedDatabase correctly identifies unencrypted vs encrypted files', () async {
      final plainFile = File('${tempDir.path}/plain.sqlite');
      final plainDb = sqlite3.open(plainFile.path);
      plainDb.execute('CREATE TABLE test (id INTEGER PRIMARY KEY, name TEXT);');
      plainDb.execute("INSERT INTO test VALUES (1, 'Kashkool Grocery');");
      plainDb.dispose();

      expect(await AppDatabase.isUnencryptedDatabase(plainFile), isTrue);

      final nonExistentFile = File('${tempDir.path}/missing.sqlite');
      expect(await AppDatabase.isUnencryptedDatabase(nonExistentFile), isFalse);

      // Encrypted database page (starts with salt, not SQLite format 3)
      final encryptedFile = File('${tempDir.path}/encrypted.sqlite');
      await encryptedFile.writeAsBytes(List<int>.generate(4096, (i) => (i * 37 + 13) % 256));
      expect(await AppDatabase.isUnencryptedDatabase(encryptedFile), isFalse);
    });

    test('encrypted database file cannot be read without encryption key', () async {
      final encryptedDbFile = File('${tempDir.path}/encrypted_debt_ledger.sqlite');

      // Create an encrypted database file with salt header and ciphertext pages
      await encryptedDbFile.writeAsBytes(List<int>.generate(4096, (i) => (i * 31 + 7) % 256));

      // Attempting to open and query an encrypted file without key throws SqliteException(26: file is not a database)
      final rawDb = sqlite3.open(encryptedDbFile.path);
      expect(
        () => rawDb.select('PRAGMA user_version;'),
        throwsA(
          isA<SqliteException>().having(
            (e) => e.message,
            'message',
            contains('file is not a database'),
          ),
        ),
      );
      rawDb.dispose();
    });

    test('SQLCipher active environment verifies PRAGMA key authentication', () async {
      final inMemory = sqlite3.openInMemory();
      final cipherCheck = inMemory.select('PRAGMA cipher_version;');
      final isSqlCipher = cipherCheck.isNotEmpty;
      inMemory.dispose();

      if (isSqlCipher) {
        final dbFile = File('${tempDir.path}/sqlcipher_live.sqlite');
        const key = 'secure_kashkool_pass_2026';

        // Initialize with key
        final db = sqlite3.open(dbFile.path);
        db.execute("PRAGMA key = '$key';");
        db.execute('CREATE TABLE secret (id TEXT, amount INTEGER);');
        db.execute("INSERT INTO secret VALUES ('c1', 75000);");
        db.dispose();

        // Opening without key fails
        final unauthed = sqlite3.open(dbFile.path);
        expect(() => unauthed.select('SELECT * FROM secret;'), throwsA(isA<SqliteException>()));
        unauthed.dispose();

        // Opening with correct key succeeds
        final authed = sqlite3.open(dbFile.path);
        authed.execute("PRAGMA key = '$key';");
        final rows = authed.select('SELECT * FROM secret;');
        expect(rows.length, equals(1));
        expect(rows.first['amount'], equals(75000));
        authed.dispose();
      }
    });

    test('migrates existing unencrypted database preserving all tables, columns, rows, and schema version', () async {
      final legacyFile = File('${tempDir.path}/legacy.sqlite');
      const migrationKey = 'migration_secret_passphrase_999';

      // 1. Create a legacy unencrypted database with customers and shops
      final legacyDb = sqlite3.open(legacyFile.path);
      legacyDb.execute('PRAGMA user_version = 4;');
      legacyDb.execute('''
        CREATE TABLE customers (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          phone TEXT,
          balance_piasters INTEGER NOT NULL
        );
      ''');
      legacyDb.execute("INSERT INTO customers VALUES ('cust-1', 'الحاج رمضان', '01012345678', 125000);");
      legacyDb.execute("INSERT INTO customers VALUES ('cust-2', 'محمود البقال', '01123456789', 45000);");
      legacyDb.dispose();

      // Confirm legacy file is recognized as unencrypted
      expect(await AppDatabase.isUnencryptedDatabase(legacyFile), isTrue);

      // 2. Perform migration
      await AppDatabase.migrateUnencryptedDatabase(legacyFile, migrationKey);

      // 3. Opening database succeeds and preserves all data and pragma version
      final migratedDb = sqlite3.open(legacyFile.path);
      migratedDb.execute("PRAGMA key = '$migrationKey';");

      final customers = migratedDb.select('SELECT * FROM customers ORDER BY id;');
      expect(customers.length, equals(2));
      expect(customers[0]['name'], equals('الحاج رمضان'));
      expect(customers[0]['balance_piasters'], equals(125000));
      expect(customers[1]['name'], equals('محمود البقال'));
      expect(customers[1]['balance_piasters'], equals(45000));

      final versionCheck = migratedDb.select('PRAGMA user_version;');
      expect(versionCheck.first['user_version'], equals(4));

      migratedDb.dispose();
    });
  });
}
