import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_table.dart';
import 'tables/cash_days_table.dart';
import 'tables/customers_table.dart';
import 'tables/expenses_table.dart';
import 'tables/suppliers_table.dart';
import 'tables/transactions_table.dart';

export 'tables/cash_days_table.dart';
export 'tables/customers_table.dart';
export 'tables/expenses_table.dart';
export 'tables/suppliers_table.dart';
export 'tables/transactions_table.dart';

part 'app_database.g.dart';

/// App Settings / Metadata table
class AppSettings extends Table with BaseTable {
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
}

@DriftDatabase(tables: [
  AppSettings,
  Customers,
  Transactions,
  Suppliers,
  CashDays,
  Expenses,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'kashkool');
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(cashDays);
        await m.createTable(expenses);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

/// Global provider for AppDatabase singleton
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
