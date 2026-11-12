import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'base_table.dart';
import 'encryption_helper.dart';
import 'tables/cash_days_table.dart';
import 'tables/customer_photos_table.dart';
import 'tables/customers_table.dart';
import 'tables/expenses_table.dart';
import 'tables/inventory_movements_table.dart';
import 'tables/installment_plans_table.dart';
import 'tables/installments_table.dart';
import 'tables/purchase_invoices_table.dart';
import 'tables/purchase_items_table.dart';
import 'tables/products_table.dart';
import 'tables/sale_items_table.dart';
import 'tables/sales_table.dart';
import 'tables/shops_table.dart';
import 'tables/supplier_return_items_table.dart';
import 'tables/supplier_returns_table.dart';
import 'tables/suppliers_table.dart';
import 'tables/transactions_table.dart';

export 'tables/cash_days_table.dart';
export 'tables/customer_photos_table.dart';
export 'tables/customers_table.dart';
export 'tables/expenses_table.dart';
export 'tables/inventory_movements_table.dart';
export 'tables/installment_plans_table.dart';
export 'tables/installments_table.dart';
export 'tables/purchase_invoices_table.dart';
export 'tables/purchase_items_table.dart';
export 'tables/products_table.dart';
export 'tables/sale_items_table.dart';
export 'tables/sales_table.dart';
export 'tables/shops_table.dart';
export 'tables/supplier_return_items_table.dart';
export 'tables/supplier_returns_table.dart';
export 'tables/suppliers_table.dart';
export 'tables/transactions_table.dart';

part 'app_database.g.dart';

/// App Settings / Metadata table
class AppSettings extends Table with BaseTable {
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
}

/// Background isolate entry-point to configure SQLCipher library locator
@pragma('vm:entry-point')
void _setupSqlCipherInIsolate() {
  if (Platform.isAndroid) {
    open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
  }
}

@DriftDatabase(
  tables: [
    AppSettings,
    Shops,
    Customers,
    Transactions,
    Suppliers,
    CashDays,
    Expenses,
    InstallmentPlans,
    Installments,
    CustomerPhotos,
    Products,
    InventoryMovements,
    PurchaseInvoices,
    PurchaseItems,
    SupplierReturns,
    SupplierReturnItems,
    Sales,
    SaleItems,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 9;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final key = await DatabaseEncryptionHelper.getOrCreateKey();

      if (Platform.isAndroid) {
        try {
          await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
        } catch (_) {}
        open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
      }

      final docsDir = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(docsDir.path, 'kashkool.sqlite'));

      try {
        if (await isUnencryptedDatabase(dbFile)) {
          await migrateUnencryptedDatabase(dbFile, key);
        }
      } catch (_) {
        // Ignored if migration fails (e.g. during testing)
      }

      return NativeDatabase.createInBackground(
        dbFile,
        isolateSetup: _setupSqlCipherInIsolate,
        setup: (rawDb) {
          final escaped = key.replaceAll("'", "''");
          rawDb.execute("PRAGMA key = '$escaped';");
          rawDb.select('PRAGMA user_version;');
        },
      );
    });
  }

  /// Checks if a database file exists and starts with the standard unencrypted SQLite header.
  static Future<bool> isUnencryptedDatabase(File file) async {
    if (!await file.exists()) return false;
    final length = await file.length();
    if (length < 512) return false;

    RandomAccessFile? raf;
    try {
      raf = await file.open(mode: FileMode.read);
      final header = await raf.read(16);
      const expected = [
        0x53,
        0x51,
        0x4C,
        0x69,
        0x74,
        0x65,
        0x20,
        0x66,
        0x6F,
        0x72,
        0x6D,
        0x61,
        0x74,
        0x20,
        0x33,
        0x00,
      ];
      if (header.length < 16) return false;
      for (int i = 0; i < 16; i++) {
        if (header[i] != expected[i]) return false;
      }
      return true;
    } catch (_) {
      return false;
    } finally {
      await raf?.close();
    }
  }

  /// Migrates an existing unencrypted database file into an encrypted database file.
  static Future<void> migrateUnencryptedDatabase(
    File dbFile,
    String encryptionKey,
  ) async {
    final tempEncryptedFile = File('${dbFile.path}.encrypted_migration_temp');
    if (await tempEncryptedFile.exists()) {
      await tempEncryptedFile.delete();
    }

    final escapedKey = encryptionKey.replaceAll("'", "''");
    Database? unencryptedDb;
    bool exportSucceeded = false;
    try {
      unencryptedDb = sqlite3.open(dbFile.path);
      // Verify unencrypted file can be queried
      unencryptedDb.select('PRAGMA user_version;');

      final escapedTempPath = tempEncryptedFile.path.replaceAll("'", "''");
      unencryptedDb.execute(
        "ATTACH DATABASE '$escapedTempPath' AS encrypted KEY '$escapedKey';",
      );
      unencryptedDb.execute("SELECT sqlcipher_export('encrypted');");
      unencryptedDb.execute("DETACH DATABASE encrypted;");
      exportSucceeded = true;
    } catch (_) {
      exportSucceeded = false;
    } finally {
      unencryptedDb?.dispose();
    }

    if (exportSucceeded && await tempEncryptedFile.exists()) {
      final backupLegacyFile = File('${dbFile.path}.legacy_backup');
      if (await backupLegacyFile.exists()) {
        await backupLegacyFile.delete();
      }
      await dbFile.rename(backupLegacyFile.path);
      await tempEncryptedFile.rename(dbFile.path);
      if (await backupLegacyFile.exists()) {
        await backupLegacyFile.delete();
      }
    } else {
      // Fallback: Copy tables, indices, and rows to an encrypted database file
      final legacyFile = File('${dbFile.path}.legacy_migration');
      if (await legacyFile.exists()) {
        await legacyFile.delete();
      }
      await dbFile.rename(legacyFile.path);

      Database? legacyDb;
      Database? encryptedDb;
      try {
        legacyDb = sqlite3.open(legacyFile.path);
        legacyDb.select('PRAGMA user_version;');

        encryptedDb = sqlite3.open(dbFile.path);
        encryptedDb.execute("PRAGMA key = '$escapedKey';");

        final tablesResult = legacyDb.select(
          "SELECT sql FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
        );
        for (final row in tablesResult) {
          final createSql = row['sql'] as String?;
          if (createSql != null) {
            encryptedDb.execute(createSql);
          }
        }

        final tableNamesResult = legacyDb.select(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
        );
        for (final row in tableNamesResult) {
          final tableName = row['name'] as String;
          final tableData = legacyDb.select('SELECT * FROM "$tableName";');
          if (tableData.isNotEmpty) {
            final columns = tableData.columnNames;
            final placeholders = List.filled(columns.length, '?').join(', ');
            final insertSql =
                'INSERT INTO "$tableName" (${columns.map((c) => '"$c"').join(', ')}) VALUES ($placeholders);';
            final stmt = encryptedDb.prepare(insertSql);
            try {
              for (final dataRow in tableData) {
                stmt.execute(dataRow.values);
              }
            } finally {
              stmt.dispose();
            }
          }
        }

        final versionResult = legacyDb.select('PRAGMA user_version;');
        if (versionResult.isNotEmpty) {
          final userVersion = versionResult.first['user_version'];
          if (userVersion != null) {
            encryptedDb.execute('PRAGMA user_version = $userVersion;');
          }
        }
      } catch (err) {
        if (!await dbFile.exists() && await legacyFile.exists()) {
          await legacyFile.rename(dbFile.path);
        }
        rethrow;
      } finally {
        legacyDb?.dispose();
        encryptedDb?.dispose();
      }

      if (await legacyFile.exists()) {
        await legacyFile.delete();
      }
    }
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
      if (from < 6) {
        await m.createTable(customerPhotos);
      }
      if (from < 7) {
        await m.createTable(products);
        await m.createTable(inventoryMovements);
      }
      if (from < 8) {
        await m.createTable(purchaseInvoices);
        await m.createTable(purchaseItems);
        await m.createTable(supplierReturns);
        await m.createTable(supplierReturnItems);
      }
      if (from < 9) {
        await m.createTable(sales);
        await m.createTable(saleItems);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
      // Self-healing fallback for app_settings columns on existing devices
      try {
        await customStatement(
          "ALTER TABLE app_settings ADD COLUMN shop_id TEXT NOT NULL DEFAULT 'default_shop';",
        );
      } catch (_) {}
      try {
        await customStatement(
          "ALTER TABLE app_settings ADD COLUMN device_id TEXT NOT NULL DEFAULT 'local_device';",
        );
      } catch (_) {}
      try {
        await customStatement(
          "ALTER TABLE app_settings ADD COLUMN created_by TEXT NOT NULL DEFAULT 'owner';",
        );
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
