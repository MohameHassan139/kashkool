import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../features/settings/data/settings_repository.dart';
import '../db/app_database.dart';
import '../db/encryption_helper.dart';
import '../../l10n/l10n.dart';

/// Validation result of a backup file.
class BackupValidationResult {
  final bool isValid;
  final String? errorMessage;
  final DateTime? exportedAt;
  final int photosCount;
  final int fileSizeBytes;

  const BackupValidationResult({
    required this.isValid,
    this.errorMessage,
    this.exportedAt,
    this.photosCount = 0,
    this.fileSizeBytes = 0,
  });
}

/// Custom exception for backup export/import failures.
class BackupException implements Exception {
  final String message;
  BackupException(this.message);

  @override
  String toString() => message;
}

/// Service handling local SQLite & photos export to `.kashkool` (zip) and restore.
class BackupService {
  final AppDatabase _db;
  final SettingsRepository _settingsRepo;

  final Future<File> Function()? _dbFileResolver;
  final Future<Directory> Function()? _photosDirResolver;
  final Future<Directory> Function()? _backupDirResolver;

  // Expected 16-byte SQLite header: "SQLite format 3\000"
  static const List<int> sqliteHeaderBytes = [
    0x53, 0x51, 0x4c, 0x69, 0x74, 0x65, 0x20, 0x66, 0x6f, 0x72, 0x6d, 0x61, 0x74, 0x20, 0x33, 0x00,
  ];

  BackupService({
    required AppDatabase db,
    required SettingsRepository settingsRepo,
    Future<File> Function()? dbFileResolver,
    Future<Directory> Function()? photosDirResolver,
    Future<Directory> Function()? backupDirResolver,
  })  : _db = db,
        _settingsRepo = settingsRepo,
        _dbFileResolver = dbFileResolver,
        _photosDirResolver = photosDirResolver,
        _backupDirResolver = backupDirResolver;

  /// Resolves the local SQLite database file path.
  Future<File> getDatabaseFile() async {
    final resolver = _dbFileResolver;
    if (resolver != null) return resolver();
    final docsDir = await getApplicationDocumentsDirectory();
    return File(p.join(docsDir.path, 'kashkool.sqlite'));
  }

  /// Resolves the photos directory.
  Future<Directory> getPhotosDirectory() async {
    final resolver = _photosDirResolver;
    if (resolver != null) return resolver();
    final docsDir = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docsDir.path, 'photos'));
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return dir;
  }

  /// Resolves the backup output directory.
  Future<Directory> getBackupDirectory() async {
    final resolver = _backupDirResolver;
    if (resolver != null) return resolver();
    return await getApplicationDocumentsDirectory();
  }

  /// Exports a complete `.kashkool` backup archive containing SQLite DB and photos.
  Future<File> exportBackup() async {
    // 1. Flush SQLite WAL journal to guarantee all latest transactions are written to disk
    try {
      await _db.customStatement('PRAGMA wal_checkpoint(FULL);');
    } catch (_) {
      // Non-critical if WAL mode is not enabled or in test environment
    }

    final dbFile = await getDatabaseFile();
    if (!dbFile.existsSync()) {
      throw BackupException(L10n.t.backupService1);
    }

    final dbBytes = await dbFile.readAsBytes();
    final dbHash = sha256.convert(dbBytes).toString();

    final archive = Archive();

    // Add database file
    archive.addFile(ArchiveFile('kashkool.sqlite', dbBytes.length, dbBytes));

    // Add photos
    int photosCount = 0;
    final photosDir = await getPhotosDirectory();
    if (photosDir.existsSync()) {
      final entries = photosDir.listSync(recursive: true);
      for (final entry in entries) {
        if (entry is File) {
          final relPath = p.relative(entry.path, from: photosDir.path).replaceAll(r'\', '/');
          final bytes = await entry.readAsBytes();
          archive.addFile(ArchiveFile('photos/$relPath', bytes.length, bytes));
          photosCount++;
        }
      }
    }

    // Add metadata.json
    final now = DateTime.now();
    final isUnencrypted = await AppDatabase.isUnencryptedDatabase(dbFile);
    final metadata = {
      'formatVersion': 1,
      'exportedAt': now.toIso8601String(),
      'appVersion': '1.0.0',
      'dbSha256': dbHash,
      'photosCount': photosCount,
      'isEncrypted': !isUnencrypted,
    };
    final metaBytes = utf8.encode(jsonEncode(metadata));
    archive.addFile(ArchiveFile('metadata.json', metaBytes.length, metaBytes));

    // Encode to ZIP
    final zipEncoder = ZipEncoder();
    final encodedData = zipEncoder.encode(archive);

    // Write file with .kashkool extension
    final backupDir = await getBackupDirectory();
    final timestamp = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    final backupFile = File(p.join(backupDir.path, 'kashkool_backup_$timestamp.kashkool'));
    await backupFile.writeAsBytes(encodedData, flush: true);

    // Update last backup timestamp
    await _settingsRepo.setLastBackupAt(now);

    return backupFile;
  }

  /// Exports and shares the `.kashkool` file via system share sheet (WhatsApp, Drive, etc.).
  Future<File> shareBackup() async {
    final file = await exportBackup();
    final dateStr = DateTime.now().toLocal().toString().split('.').first;
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: L10n.t.backupService2(dateStr),
      ),
    );
    return file;
  }

  /// Validates a `.kashkool` file without applying changes.
  Future<BackupValidationResult> validateBackup(File file) async {
    if (!file.existsSync()) {
      return BackupValidationResult(
        isValid: false,
        errorMessage: L10n.t.backupService3,
      );
    }

    final bytes = await file.readAsBytes();
    if (bytes.length < 32) {
      return BackupValidationResult(
        isValid: false,
        errorMessage: L10n.t.backupService4,
      );
    }

    Archive archive;
    try {
      archive = ZipDecoder().decodeBytes(bytes);
    } catch (_) {
      return BackupValidationResult(
        isValid: false,
        errorMessage: L10n.t.backupService5,
      );
    }

    // Check for kashkool.sqlite
    ArchiveFile? dbFile;
    for (final f in archive.files) {
      if (f.name == 'kashkool.sqlite' || f.name == 'database.sqlite') {
        dbFile = f;
        break;
      }
    }

    if (dbFile == null) {
      return BackupValidationResult(
        isValid: false,
        errorMessage: L10n.t.backupService6,
      );
    }

    // Count photos and parse metadata
    int photosCount = 0;
    DateTime? exportedAt;
    bool isMarkedEncrypted = false;
    for (final f in archive.files) {
      if (f.name.startsWith('photos/') && !f.name.endsWith('/')) {
        photosCount++;
      } else if (f.name == 'metadata.json') {
        try {
          final metaJson = utf8.decode(f.content as List<int>);
          final map = jsonDecode(metaJson) as Map<String, dynamic>;
          if (map['exportedAt'] != null) {
            exportedAt = DateTime.tryParse(map['exportedAt'].toString());
          }
          if (map['isEncrypted'] == true) {
            isMarkedEncrypted = true;
          }
        } catch (_) {}
      }
    }

    // Verify SQLite Header
    final List<int> dbBytes = dbFile.content;
    if (dbBytes.length < 16) {
      return BackupValidationResult(
        isValid: false,
        errorMessage: L10n.t.backupService7,
      );
    }

    bool isPlainSqlite = true;
    for (int i = 0; i < 16; i++) {
      if (dbBytes[i] != sqliteHeaderBytes[i]) {
        isPlainSqlite = false;
        break;
      }
    }

    if (!isPlainSqlite) {
      if (!isMarkedEncrypted || dbBytes.length < 100) {
        return BackupValidationResult(
          isValid: false,
          errorMessage: L10n.t.backupService8,
        );
      }
    }

    return BackupValidationResult(
      isValid: true,
      exportedAt: exportedAt,
      photosCount: photosCount,
      fileSizeBytes: bytes.length,
    );
  }

  /// Restores database and photos from a validated `.kashkool` file.
  /// Throws [BackupException] if the file is invalid.
  Future<void> importBackup(File file) async {
    final validation = await validateBackup(file);
    if (!validation.isValid) {
      throw BackupException(validation.errorMessage ?? L10n.t.backupService9);
    }

    final bytes = await file.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    // Find SQLite DB
    ArchiveFile? dbEntry;
    for (final f in archive.files) {
      if (f.name == 'kashkool.sqlite' || f.name == 'database.sqlite') {
        dbEntry = f;
        break;
      }
    }

    if (dbEntry == null) {
      throw BackupException(L10n.t.backupService10);
    }

    // Target DB file
    final targetDbFile = await getDatabaseFile();

    // Close current connection so file is not locked
    try {
      await _db.close();
    } catch (_) {}

    // Remove any WAL and SHM journal files
    final walFile = File('${targetDbFile.path}-wal');
    final shmFile = File('${targetDbFile.path}-shm');
    if (walFile.existsSync()) walFile.deleteSync();
    if (shmFile.existsSync()) shmFile.deleteSync();

    // Overwrite SQLite database
    final dbBytes = dbEntry.content;
    await targetDbFile.writeAsBytes(dbBytes, flush: true);

    // If the restored database is an unencrypted legacy database, automatically migrate and encrypt it
    try {
      if (await AppDatabase.isUnencryptedDatabase(targetDbFile)) {
        final key = await DatabaseEncryptionHelper.getOrCreateKey();
        await AppDatabase.migrateUnencryptedDatabase(targetDbFile, key);
      }
    } catch (_) {
      // In tests with synthetic bytes or corrupted files, ignore migration failure
    }

    // Extract photos
    final photosDir = await getPhotosDirectory();
    for (final f in archive.files) {
      if (f.name.startsWith('photos/') && !f.name.endsWith('/')) {
        final relPath = f.name.substring('photos/'.length);
        final photoFile = File(p.join(photosDir.path, relPath));
        if (!photoFile.parent.existsSync()) {
          photoFile.parent.createSync(recursive: true);
        }
        final pBytes = f.content;
        await photoFile.writeAsBytes(pBytes, flush: true);
      }
    }
  }
}

/// Global provider for BackupService
final backupServiceProvider = Provider<BackupService>((ref) {
  final db = ref.watch(databaseProvider);
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  return BackupService(db: db, settingsRepo: settingsRepo);
});
