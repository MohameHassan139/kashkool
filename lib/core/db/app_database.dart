import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_table.dart';
import 'tables/cash_days_table.dart';
import 'tables/customers_table.dart';
import 'tables/expenses_table.dart';
import 'tables/installment_plans_table.dart';
import 'tables/installments_table.dart';
import 'tables/shops_table.dart';
import 'tables/suppliers_table.dart';
import 'tables/transactions_table.dart';

export 'tables/cash_days_table.dart';
export 'tables/customers_table.dart';
export 'tables/expenses_table.dart';
export 'tables/installment_plans_table.dart';
export 'tables/installments_table.dart';
export 'tables/shops_table.dart';
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
  Shops,
  Customers,
  Transactions,
  Suppliers,
  CashDays,
  Expenses,
  InstallmentPlans,
  Installments,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 5;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'kashkool',
      native: const DriftNativeOptions(
        shareAcrossIsolates: false,
      ),
    );
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
      if (from < 3) {
        await m.createTable(installmentPlans);
        await m.createTable(installments);
      }
      if (from < 4) {
        await m.createTable(shops);
        await m.addColumn(customers, customers.nationalId);
        await m.addColumn(transactions, transactions.supersededById);
        await m.addColumn(customers, customers.shopId);
        await m.addColumn(customers, customers.deviceId);
        await m.addColumn(customers, customers.createdBy);
        await m.addColumn(transactions, transactions.shopId);
        await m.addColumn(transactions, transactions.deviceId);
        await m.addColumn(transactions, transactions.createdBy);
        await m.addColumn(suppliers, suppliers.shopId);
        await m.addColumn(suppliers, suppliers.deviceId);
        await m.addColumn(suppliers, suppliers.createdBy);
        await m.addColumn(cashDays, cashDays.shopId);
        await m.addColumn(cashDays, cashDays.deviceId);
        await m.addColumn(cashDays, cashDays.createdBy);
        await m.addColumn(expenses, expenses.shopId);
        await m.addColumn(expenses, expenses.deviceId);
        await m.addColumn(expenses, expenses.createdBy);
        await m.addColumn(installmentPlans, installmentPlans.shopId);
        await m.addColumn(installmentPlans, installmentPlans.deviceId);
        await m.addColumn(installmentPlans, installmentPlans.createdBy);
        await m.addColumn(installments, installments.shopId);
        await m.addColumn(installments, installments.deviceId);
        await m.addColumn(installments, installments.createdBy);
      }
      if (from < 5) {
        try {
          await m.addColumn(appSettings, appSettings.shopId);
        } catch (_) {}
        try {
          await m.addColumn(appSettings, appSettings.deviceId);
        } catch (_) {}
        try {
          await m.addColumn(appSettings, appSettings.createdBy);
        } catch (_) {}
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
      // Self-healing fallback for app_settings columns on existing devices
      try {
        await customStatement("ALTER TABLE app_settings ADD COLUMN shop_id TEXT NOT NULL DEFAULT 'default_shop';");
      } catch (_) {}
      try {
        await customStatement("ALTER TABLE app_settings ADD COLUMN device_id TEXT NOT NULL DEFAULT 'local_device';");
      } catch (_) {}
      try {
        await customStatement("ALTER TABLE app_settings ADD COLUMN created_by TEXT NOT NULL DEFAULT 'owner';");
      } catch (_) {}
    },
  );
}

/// Global provider for AppDatabase singleton
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
