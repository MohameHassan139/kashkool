import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';

/// Repository responsible for recording, updating, and undoing debts and payments.
class TransactionRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  TransactionRepository(this._db);

  /// Saves an image file from temporary camera/gallery path to permanent app storage.
  Future<String> persistPhoto(String tempPath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory('${appDir.path}/transaction_photos');
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }

    final ext = tempPath.split('.').last;
    final fileName = '${_uuid.v4()}.$ext';
    final targetPath = '${photosDir.path}/$fileName';

    final tempFile = File(tempPath);
    await tempFile.copy(targetPath);
    return targetPath;
  }

  /// Adds a new transaction (debt or payment).
  Future<String> addTransaction({
    required PartyType partyType,
    required String partyId,
    required TransactionType type,
    required int amountPiasters,
    PaymentMethod? method,
    String? note,
    String? photoPath,
    DateTime? occurredAt,
  }) async {
    if (amountPiasters <= 0) {
      throw ArgumentError(
        'Transaction amount must be strictly greater than zero',
      );
    }
    if (type == TransactionType.supplierCredit &&
        partyType != PartyType.supplier) {
      throw ArgumentError('Supplier credit notes require a supplier party');
    }

    final id = _uuid.v4();
    final now = DateTime.now();

    await _db
        .into(_db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: id,
            partyType: partyType,
            partyId: partyId,
            type: type,
            amountPiasters: amountPiasters,
            method: Value(method),
            note: Value(note?.trim().isEmpty == true ? null : note?.trim()),
            photoPath: Value(photoPath),
            occurredAt: Value(occurredAt ?? now),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

    return id;
  }

  /// Updates an existing transaction.
  Future<void> updateTransaction({
    required String id,
    required int amountPiasters,
    PaymentMethod? method,
    String? note,
    String? photoPath,
    required DateTime occurredAt,
  }) async {
    if (amountPiasters <= 0) {
      throw ArgumentError(
        'Transaction amount must be strictly greater than zero',
      );
    }

    final now = DateTime.now();

    await (_db.update(_db.transactions)..where((t) => t.id.equals(id))).write(
      TransactionsCompanion(
        amountPiasters: Value(amountPiasters),
        method: Value(method),
        note: Value(note?.trim().isEmpty == true ? null : note?.trim()),
        photoPath: Value(photoPath),
        occurredAt: Value(occurredAt),
        updatedAt: Value(now),
      ),
    );
  }

  /// Soft deletes a transaction.
  Future<void> deleteTransaction(String id) async {
    final now = DateTime.now();
    await (_db.update(_db.transactions)..where((t) => t.id.equals(id))).write(
      TransactionsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  /// Undoes a newly recorded transaction.
  /// Nothing is erased: the row is hidden (soft delete) and can be brought back from the trash.
  Future<void> undoTransaction(String id) => deleteTransaction(id);

  /// Retrieves a single transaction by ID.
  Future<Transaction?> getTransaction(String id) {
    return (_db.select(
      _db.transactions,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}

/// Global provider for TransactionRepository
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TransactionRepository(db);
});
