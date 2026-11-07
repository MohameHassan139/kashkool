import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/backup/backup_service.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/settings/data/settings_repository.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository settingsRepo;
  late Directory tempDir;
  late File mockDbFile;
  late Directory mockPhotosDir;
  late Directory mockBackupDir;
  late BackupService backupService;

  // Valid SQLite header 16 bytes: "SQLite format 3\000"
  final validSqliteBytes = [
    0x53, 0x51, 0x4c, 0x69, 0x74, 0x65, 0x20, 0x66, 0x6f, 0x72, 0x6d, 0x61, 0x74, 0x20, 0x33, 0x00,
    ...List<int>.filled(84, 0), // pad to 100 bytes
  ];

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    settingsRepo = SettingsRepository(db);

    tempDir = await Directory.systemTemp.createTemp('kashkool_backup_test_');
    mockDbFile = File('${tempDir.path}/kashkool.sqlite');
    await mockDbFile.writeAsBytes(validSqliteBytes);

    mockPhotosDir = Directory('${tempDir.path}/photos');
    await mockPhotosDir.create();

    // Create 2 test photos
    final photo1 = File('${mockPhotosDir.path}/receipt1.jpg');
    final photo2 = File('${mockPhotosDir.path}/sub/receipt2.png');
    await photo1.parent.create(recursive: true);
    await photo2.parent.create(recursive: true);
    await photo1.writeAsString('photo1_data');
    await photo2.writeAsString('photo2_data');

    mockBackupDir = Directory('${tempDir.path}/backups');
    await mockBackupDir.create();

    backupService = BackupService(
      db: db,
      settingsRepo: settingsRepo,
      dbFileResolver: () async => mockDbFile,
      photosDirResolver: () async => mockPhotosDir,
      backupDirResolver: () async => mockBackupDir,
    );
  });

  tearDown(() async {
    await db.close();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('BackupService Export', () {
    test('exports database, photos, and metadata into a valid .kashkool zip archive', () async {
      expect(await settingsRepo.getLastBackupAt(), isNull);

      final backupFile = await backupService.exportBackup();

      expect(backupFile.existsSync(), isTrue);
      expect(backupFile.path.endsWith('.kashkool'), isTrue);

      // Verify last backup setting is saved
      expect(await settingsRepo.getLastBackupAt(), isNotNull);

      // Verify ZIP contents
      final bytes = await backupFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      expect(archive.findFile('kashkool.sqlite'), isNotNull);
      expect(archive.findFile('metadata.json'), isNotNull);
      expect(archive.findFile('photos/receipt1.jpg'), isNotNull);
      expect(archive.findFile('photos/sub/receipt2.png'), isNotNull);

      // Parse metadata
      final metaFile = archive.findFile('metadata.json')!;
      final metaJson = utf8.decode(metaFile.content as List<int>);
      final metaMap = jsonDecode(metaJson) as Map<String, dynamic>;

      expect(metaMap['formatVersion'], equals(1));
      expect(metaMap['appVersion'], equals('1.0.0'));
      expect(metaMap['photosCount'], equals(2));
      expect(metaMap['dbSha256'], isNotEmpty);
    });
  });

  group('BackupService Validation', () {
    test('validates an intact .kashkool backup successfully', () async {
      final backupFile = await backupService.exportBackup();
      final validation = await backupService.validateBackup(backupFile);

      expect(validation.isValid, isTrue);
      expect(validation.photosCount, equals(2));
      expect(validation.fileSizeBytes, greaterThan(0));
      expect(validation.errorMessage, isNull);
    });

    test('rejects non-existent file', () async {
      final nonExistent = File('${tempDir.path}/ghost.kashkool');
      final validation = await backupService.validateBackup(nonExistent);

      expect(validation.isValid, isFalse);
      expect(validation.errorMessage, contains('غير موجود'));
    });

    test('rejects corrupted file with random garbage bytes', () async {
      final corruptFile = File('${tempDir.path}/corrupt.kashkool');
      await corruptFile.writeAsBytes(List<int>.filled(100, 42));

      final validation = await backupService.validateBackup(corruptFile);
      expect(validation.isValid, isFalse);
      expect(validation.errorMessage, isNotNull);
    });

    test('rejects zip archive missing kashkool.sqlite', () async {
      final archive = Archive();
      archive.addFile(ArchiveFile('other.txt', 5, utf8.encode('hello')));
      final zipBytes = ZipEncoder().encode(archive);

      final file = File('${tempDir.path}/no_db.kashkool');
      await file.writeAsBytes(zipBytes);

      final validation = await backupService.validateBackup(file);
      expect(validation.isValid, isFalse);
      expect(validation.errorMessage, contains('لا يحتوي على قاعدة بيانات'));
    });

    test('rejects zip archive with invalid SQLite header', () async {
      final archive = Archive();
      archive.addFile(ArchiveFile('kashkool.sqlite', 20, List<int>.filled(20, 0xFF)));
      final zipBytes = ZipEncoder().encode(archive);

      final file = File('${tempDir.path}/bad_header.kashkool');
      await file.writeAsBytes(zipBytes);

      final validation = await backupService.validateBackup(file);
      expect(validation.isValid, isFalse);
      expect(validation.errorMessage, contains('ليس قاعدة بيانات SQLite صالحة'));
    });
  });

  group('BackupService Import & Restore', () {
    test('restores database file and photo assets successfully', () async {
      // 1. Export backup with current state
      final backupFile = await backupService.exportBackup();

      // 2. Modify local database and delete photos to simulate data loss
      await mockDbFile.writeAsBytes([
        ...validSqliteBytes.sublist(0, 16),
        ...List<int>.filled(84, 99),
      ]);
      mockPhotosDir.deleteSync(recursive: true);
      expect(mockPhotosDir.existsSync(), isFalse);

      // 3. Import backup
      await backupService.importBackup(backupFile);

      // 4. Verify database and photos are restored
      expect(mockDbFile.readAsBytesSync(), equals(validSqliteBytes));
      expect(mockPhotosDir.existsSync(), isTrue);
      expect(File('${mockPhotosDir.path}/receipt1.jpg').existsSync(), isTrue);
      expect(File('${mockPhotosDir.path}/sub/receipt2.png').existsSync(), isTrue);
      expect(File('${mockPhotosDir.path}/receipt1.jpg').readAsStringSync(), equals('photo1_data'));
    });

    test('fails safely on corrupt backup without corrupting existing database', () async {
      final corruptFile = File('${tempDir.path}/bad.kashkool');
      await corruptFile.writeAsBytes(List<int>.filled(50, 0));

      expect(() => backupService.importBackup(corruptFile), throwsA(isA<BackupException>()));

      // Existing DB remains unchanged
      expect(mockDbFile.readAsBytesSync(), equals(validSqliteBytes));
    });
  });
}
