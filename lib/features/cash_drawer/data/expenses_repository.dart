import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';

/// Repository handling shop expense records.
class ExpensesRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  ExpensesRepository(this._db);

  /// Adds a new expense record.
  Future<Expense> addExpense({
    required DateTime date,
    required ExpenseCategory category,
    required int amountPiasters,
    PaymentMethod method = PaymentMethod.cash,
    String? note,
  }) async {
    if (amountPiasters <= 0) {
      throw ArgumentError('Expense amount must be positive');
    }

    final now = DateTime.now();
    final companion = ExpensesCompanion(
      id: Value(_uuid.v4()),
      date: Value(date),
      category: Value(category),
      amountPiasters: Value(amountPiasters),
      method: Value(method),
      note: Value(note?.trim()),
      createdAt: Value(now),
      updatedAt: Value(now),
    );

    await _db.into(_db.expenses).insert(companion);
    return (await (_db.select(_db.expenses)..where((tbl) => tbl.id.equals(companion.id.value))).getSingle());
  }

  /// Updates an existing expense.
  Future<void> updateExpense({
    required String id,
    ExpenseCategory? category,
    int? amountPiasters,
    PaymentMethod? method,
    String? note,
  }) async {
    if (amountPiasters != null && amountPiasters <= 0) {
      throw ArgumentError('Expense amount must be positive');
    }

    final companion = ExpensesCompanion(
      category: category != null ? Value(category) : const Value.absent(),
      amountPiasters: amountPiasters != null ? Value(amountPiasters) : const Value.absent(),
      method: method != null ? Value(method) : const Value.absent(),
      note: note != null ? Value(note.trim()) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );

    await (_db.update(_db.expenses)..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  /// Soft deletes an expense.
  Future<void> deleteExpense(String id) async {
    final now = DateTime.now();
    await (_db.update(_db.expenses)..where((tbl) => tbl.id.equals(id))).write(
      ExpensesCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  /// Watches all active expenses for a specific calendar day.
  Stream<List<Expense>> watchExpensesForDay(DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final dayEnd = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

    final query = _db.select(_db.expenses)
      ..where((tbl) =>
          tbl.date.isBiggerOrEqualValue(dayStart) &
          tbl.date.isSmallerOrEqualValue(dayEnd) &
          tbl.deletedAt.isNull())
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]);

    return query.watch();
  }

  /// Gets all active expenses for a specific calendar day.
  Future<List<Expense>> getExpensesForDay(DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final dayEnd = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

    final query = _db.select(_db.expenses)
      ..where((tbl) =>
          tbl.date.isBiggerOrEqualValue(dayStart) &
          tbl.date.isSmallerOrEqualValue(dayEnd) &
          tbl.deletedAt.isNull())
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]);

    return query.get();
  }

  /// Watches all active expenses for a specific month.
  Stream<List<Expense>> watchExpensesForMonth(DateTime monthDate) {
    final monthStart = DateTime(monthDate.year, monthDate.month, 1, 0, 0, 0);
    final monthEnd = DateTime(monthDate.year, monthDate.month + 1, 0, 23, 59, 59, 999);

    final query = _db.select(_db.expenses)
      ..where((tbl) =>
          tbl.date.isBiggerOrEqualValue(monthStart) &
          tbl.date.isSmallerOrEqualValue(monthEnd) &
          tbl.deletedAt.isNull())
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]);

    return query.watch();
  }
}

/// Provider for ExpensesRepository singleton.
final expensesRepositoryProvider = Provider<ExpensesRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ExpensesRepository(db);
});
