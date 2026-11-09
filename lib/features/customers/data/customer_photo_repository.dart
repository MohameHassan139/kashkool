import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';

/// Many photos per customer, kept on this phone only.
///
/// Files are copied into `<documents>/customer_photos/`. One file can be linked to several
/// customers (e.g. one notebook page that has 10 customers on it) without copying it again.
class CustomerPhotoRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  CustomerPhotoRepository(this._db);

  /// Copies a picked image (camera/gallery temp file) into the app folder and returns the new path.
  Future<String> persistFile(String tempPath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final dir = Directory('${appDir.path}/customer_photos');
    if (!await dir.exists()) await dir.create(recursive: true);
    final dot = tempPath.lastIndexOf('.');
    final ext = dot == -1 ? 'jpg' : tempPath.substring(dot + 1);
    final target = '${dir.path}/${_uuid.v4()}.$ext';
    await File(tempPath).copy(target);
    return target;
  }

  /// Links already-saved files to a customer. Duplicate paths for the same customer are skipped.
  /// Safe to call inside another database transaction.
  Future<void> addPhotos(String customerId, List<String> filePaths, {String? note}) async {
    if (filePaths.isEmpty) return;
    final existing = await (_db.select(_db.customerPhotos)
          ..where((p) => p.customerId.equals(customerId) & p.deletedAt.isNull()))
        .map((p) => p.filePath)
        .get();
    final known = existing.toSet();
    final now = DateTime.now();
    await _db.batch((b) {
      for (final path in filePaths) {
        if (!known.add(path)) continue;
        b.insert(
          _db.customerPhotos,
          CustomerPhotosCompanion.insert(
            id: _uuid.v4(),
            customerId: customerId,
            filePath: path,
            note: Value(note),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
      }
    });
  }

  /// Newest first.
  Stream<List<CustomerPhoto>> watchForCustomer(String customerId) {
    return (_db.select(_db.customerPhotos)
          ..where((p) => p.customerId.equals(customerId) & p.deletedAt.isNull())
          ..orderBy([(p) => OrderingTerm.desc(p.createdAt)]))
        .watch();
  }

  /// Hides a photo (soft delete). The file stays on the phone so it can be restored.
  Future<void> moveToTrash(String photoId) {
    final now = DateTime.now();
    return (_db.update(_db.customerPhotos)..where((p) => p.id.equals(photoId)))
        .write(CustomerPhotosCompanion(deletedAt: Value(now), updatedAt: Value(now)));
  }

  Future<void> restore(String photoId) {
    return (_db.update(_db.customerPhotos)..where((p) => p.id.equals(photoId)))
        .write(CustomerPhotosCompanion(deletedAt: const Value(null), updatedAt: Value(DateTime.now())));
  }
}

final customerPhotoRepositoryProvider = Provider<CustomerPhotoRepository>((ref) {
  return CustomerPhotoRepository(ref.watch(databaseProvider));
});

final customerPhotosProvider = StreamProvider.autoDispose.family<List<CustomerPhoto>, String>((ref, customerId) {
  return ref.watch(customerPhotoRepositoryProvider).watchForCustomer(customerId);
});
