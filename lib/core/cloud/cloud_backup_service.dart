import 'package:drift/drift.dart';
import '../db/app_database.dart';
import 'cloud_api.dart';
import 'cloud_session_store.dart';
import 'google_auth_service.dart';
import '../../l10n/l10n.dart';

typedef CloudProgress = void Function(String message, double? fraction);

class BackupResult {
  final int uploaded;
  final int unchanged;
  final int rejected;
  final List<String> rejectReasons;
  const BackupResult(this.uploaded, this.unchanged, this.rejected, this.rejectReasons);
}

class RestoreResult {
  /// Rows written to the phone.
  final int records;

  /// Rows skipped because the copy on the phone was newer.
  final int keptLocal;
  const RestoreResult(this.records, [this.keptLocal = 0]);
}

/// Cloud backup on the Kashkool backend: Google sign-in, upload local rows, restore on a phone.
///
/// Uploads use the sync API (`/sync/push`), so later this becomes full multi-device sync
/// without changing the data format.
class CloudBackupService {
  final AppDatabase _db;
  final CloudApi _api;
  final CloudSessionStore _store;
  final GoogleAuthService? _google;

  CloudBackupService(this._db, this._api, this._store, [this._google]);

  static const int _pushBatchSize = 400;

  /// Dates as ISO-8601 strings, which the server requires.
  static const ValueSerializer serializer = ValueSerializer.defaults(serializeDateTimeValuesAsString: true);

  /// Settings that must never leave the phone, or are device-specific.
  static bool isPrivateSetting(String key) =>
      key.startsWith('security_') ||
      const {'active_shop_id', 'data_last_backup_at', 'shop_logo_path', 'onboarding_completed'}.contains(key);

  // ---------- account ----------

  Future<CloudSession> signIn() async {
    final google = _google;
    if (google == null) throw CloudApiException('not_configured', L10n.t.cloudBackupService1);
    final idToken = await google.getIdToken();
    return _api.loginWithGoogle(idToken, deviceLabel: 'android');
  }

  Future<void> signOut() async {
    await _api.logout();
    await _google?.signOut();
  }

  Future<void> deleteAccount() async {
    await _api.deleteAccount();
    await _google?.signOut();
  }

  // ---------- backup ----------

  Future<Shop> _activeShop() async {
    final setting = await (_db.select(_db.appSettings)..where((s) => s.key.equals('active_shop_id'))).getSingleOrNull();
    if (setting != null && setting.value.isNotEmpty) {
      final shop = await (_db.select(_db.shops)..where((s) => s.id.equals(setting.value) & s.deletedAt.isNull())).getSingleOrNull();
      if (shop != null) return shop;
    }
    final first = await (_db.select(_db.shops)..where((s) => s.deletedAt.isNull())..limit(1)).getSingleOrNull();
    if (first == null) throw CloudApiException('no_shop', L10n.t.cloudBackupService2);
    return first;
  }

  /// Migrates local SQLite database tables to use the account's single cloud shopId.
  Future<Shop> adoptCloudShopId(Shop localShop, String cloudShopId) async {
    if (localShop.id == cloudShopId) return localShop;
    final now = DateTime.now();
    await _db.transaction(() async {
      await _db.into(_db.shops).insertOnConflictUpdate(ShopsCompanion(
            id: Value(cloudShopId),
            shopId: Value(cloudShopId),
            deviceId: Value(localShop.deviceId),
            createdBy: Value(localShop.createdBy),
            name: Value(localShop.name),
            shopType: Value(localShop.shopType),
            phone: Value(localShop.phone),
            address: Value(localShop.address),
            currency: const Value('EGP'),
            enableInstallments: Value(localShop.enableInstallments),
            createdAt: Value(localShop.createdAt),
            updatedAt: Value(now),
          ));

      await (_db.delete(_db.appSettings)..where((s) => s.key.equals('active_shop_id'))).go();
      await _db.into(_db.appSettings).insert(AppSettingsCompanion(
            id: const Value('setting-active_shop_id'),
            key: const Value('active_shop_id'),
            value: Value(cloudShopId),
            createdAt: Value(now),
            updatedAt: Value(now),
          ));

      await (_db.update(_db.customers)..where((c) => c.shopId.equals(localShop.id)))
          .write(CustomersCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.suppliers)..where((s) => s.shopId.equals(localShop.id)))
          .write(SuppliersCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.transactions)..where((t) => t.shopId.equals(localShop.id)))
          .write(TransactionsCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.installmentPlans)..where((p) => p.shopId.equals(localShop.id)))
          .write(InstallmentPlansCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.installments)..where((i) => i.shopId.equals(localShop.id)))
          .write(InstallmentsCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.cashDays)..where((c) => c.shopId.equals(localShop.id)))
          .write(CashDaysCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.expenses)..where((e) => e.shopId.equals(localShop.id)))
          .write(ExpensesCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.products)..where((p) => p.shopId.equals(localShop.id)))
          .write(ProductsCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.inventoryMovements)..where((m) => m.shopId.equals(localShop.id)))
          .write(InventoryMovementsCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.purchaseInvoices)..where((i) => i.shopId.equals(localShop.id)))
          .write(PurchaseInvoicesCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.purchaseItems)..where((i) => i.shopId.equals(localShop.id)))
          .write(PurchaseItemsCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.supplierReturns)..where((r) => r.shopId.equals(localShop.id)))
          .write(SupplierReturnsCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.supplierReturnItems)..where((r) => r.shopId.equals(localShop.id)))
          .write(SupplierReturnItemsCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.sales)..where((s) => s.shopId.equals(localShop.id)))
          .write(SalesCompanion(shopId: Value(cloudShopId)));
      await (_db.update(_db.saleItems)..where((s) => s.shopId.equals(localShop.id)))
          .write(SaleItemsCompanion(shopId: Value(cloudShopId)));
      await (_db.delete(_db.shops)..where((s) => s.id.equals(localShop.id))).go();
    });

    return await _activeShop();
  }

  Future<String?> _setting(String key) async {
    final row = await (_db.select(_db.appSettings)..where((s) => s.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  /// Rows changed since [since] (all rows when null), as `{collection, record}` changes.
  Future<List<Map<String, dynamic>>> collectChanges(DateTime? since) async {
    final changes = <Map<String, dynamic>>[];

    Future<void> add<T extends Table, D extends DataClass>(
      String collection,
      TableInfo<T, D> table,
      GeneratedColumn<DateTime> updatedAt, {
      bool Function(D row)? include,
    }) async {
      final query = _db.select(table);
      final from = since;
      if (from != null) query.where((_) => updatedAt.isBiggerOrEqualValue(from));
      for (final row in await query.get()) {
        if (include != null && !include(row)) continue;
        changes.add({'collection': collection, 'record': row.toJson(serializer: serializer)});
      }
    }

    // Parents first, then the rows that point at them.
    await add('customers', _db.customers, _db.customers.updatedAt);
    await add('suppliers', _db.suppliers, _db.suppliers.updatedAt);
    await add('installment_plans', _db.installmentPlans, _db.installmentPlans.updatedAt);
    await add('installments', _db.installments, _db.installments.updatedAt);
    await add('transactions', _db.transactions, _db.transactions.updatedAt);
    await add('cash_days', _db.cashDays, _db.cashDays.updatedAt);
    await add('expenses', _db.expenses, _db.expenses.updatedAt);
    await add('products', _db.products, _db.products.updatedAt);
    await add('inventory_movements', _db.inventoryMovements, _db.inventoryMovements.updatedAt);
    await add('purchase_invoices', _db.purchaseInvoices, _db.purchaseInvoices.updatedAt);
    await add('purchase_items', _db.purchaseItems, _db.purchaseItems.updatedAt);
    await add('supplier_returns', _db.supplierReturns, _db.supplierReturns.updatedAt);
    await add('supplier_return_items', _db.supplierReturnItems, _db.supplierReturnItems.updatedAt);
    await add('sales', _db.sales, _db.sales.updatedAt);
    await add('sale_items', _db.saleItems, _db.saleItems.updatedAt);
    await add('settings', _db.appSettings, _db.appSettings.updatedAt, include: (AppSetting s) => !isPrivateSetting(s.key));
    return changes;
  }

  /// Uploads everything that changed since the last backup (the first backup uploads everything).
  Future<BackupResult> backupNow({CloudProgress? onProgress, bool full = false}) async {
    final session = await _store.read();
    if (session == null) throw CloudApiException('signed_out', L10n.t.cloudApi2, statusCode: 401);

    onProgress?.call(L10n.t.cloudBackupService3, null);
    var shop = await _activeShop();
    final registered = await _api.registerShop(
      id: shop.id,
      name: shop.name,
      type: shop.shopType,
      phone: shop.phone,
      address: shop.address,
      shopCode: await _setting('growth_shop_referral_code'),
    );

    final cloudShopId = registered['id'] as String?;
    if (cloudShopId != null && cloudShopId.isNotEmpty && shop.id != cloudShopId) {
      shop = await adoptCloudShopId(shop, cloudShopId);
    }

    final startedAt = DateTime.now();
    final incremental = !full && session.linkedShopId == shop.id && session.lastBackupStartedAt != null;
    // Small overlap so nothing is missed; re-sending a row is harmless (server answers "unchanged").
    final since = incremental ? session.lastBackupStartedAt!.subtract(const Duration(minutes: 2)) : null;
    final changes = await collectChanges(since);

    var uploaded = 0, unchanged = 0, rejected = 0;
    final reasons = <String>[];
    for (var i = 0; i < changes.length; i += _pushBatchSize) {
      final batch = changes.sublist(i, i + _pushBatchSize > changes.length ? changes.length : i + _pushBatchSize);
      onProgress?.call(L10n.t.cloudBackupService4(i + batch.length, changes.length), changes.isEmpty ? null : (i + batch.length) / changes.length);
      final results = await _api.push(shop.id, shop.deviceId, batch);
      for (final r in results) {
        switch (r['status']) {
          case 'inserted':
          case 'updated':
            uploaded++;
          case 'unchanged':
            unchanged++;
          default:
            rejected++;
            if (reasons.length < 5) reasons.add('${r['collection']}: ${r['reason']}');
        }
      }
    }

    final latest = await _store.read() ?? session;
    await _store.write(latest.copyWith(linkedShopId: shop.id, lastBackupAt: DateTime.now(), lastBackupStartedAt: startedAt));
    onProgress?.call(L10n.t.cloudBackupService5, 1);
    return BackupResult(uploaded, unchanged, rejected, reasons);
  }

  /// Full two-way synchronization:
  /// 1. PUSH: uploads local changes via POST /v1/shops/:shopId/sync/push
  /// 2. PULL: downloads server updates via GET /v1/shops/:shopId/sync/pull and saves them to local Drift DB.
  Future<BackupResult> syncWithCloud({CloudProgress? onProgress}) async {
    final pushResult = await backupNow(onProgress: onProgress);
    try {
      final shop = await _activeShop();
      await restore({'id': shop.id, 'name': shop.name, 'type': shop.shopType}, onProgress: onProgress);
    } catch (_) {
      // Pull failed (e.g. offline or timeout), keep local changes.
    }
    return pushResult;
  }

  // ---------- restore ----------

  /// Shops on this Google account (to choose what to restore).
  Future<List<Map<String, dynamic>>> listCloudShops() => _api.listShops();

  /// Brings the cloud copy of a shop to this phone **without deleting anything**:
  /// cloud rows are added or updated; rows that exist only on the phone are kept, and a row
  /// that was edited on the phone more recently than in the cloud is kept as it is.
  Future<RestoreResult> restore(Map<String, dynamic> shop, {CloudProgress? onProgress}) async {
    final shopId = shop['id'] as String;
    final changes = <Map<String, dynamic>>[];
    var cursor = 0;
    while (true) {
      onProgress?.call(L10n.t.cloudBackupService6(changes.length), null);
      final page = await _api.pull(shopId, since: cursor, limit: 1000);
      changes.addAll(page.changes);
      cursor = page.cursor;
      if (!page.hasMore) break;
    }

    onProgress?.call(L10n.t.cloudBackupService7(changes.length), null);
    final now = DateTime.now();
    final currentShop = await (_db.select(_db.shops)..where((s) => s.deletedAt.isNull())..limit(1)).getSingleOrNull();
    var written = 0, keptLocal = 0;

    await _db.transaction(() async {
      final stamps = {
        'customers': await _stamps(_db.customers, _db.customers.id, _db.customers.updatedAt),
        'suppliers': await _stamps(_db.suppliers, _db.suppliers.id, _db.suppliers.updatedAt),
        'transactions': await _stamps(_db.transactions, _db.transactions.id, _db.transactions.updatedAt),
        'installment_plans': await _stamps(_db.installmentPlans, _db.installmentPlans.id, _db.installmentPlans.updatedAt),
        'installments': await _stamps(_db.installments, _db.installments.id, _db.installments.updatedAt),
        'cash_days': await _stamps(_db.cashDays, _db.cashDays.id, _db.cashDays.updatedAt),
        'expenses': await _stamps(_db.expenses, _db.expenses.id, _db.expenses.updatedAt),
        'settings': await _stamps(_db.appSettings, _db.appSettings.id, _db.appSettings.updatedAt),
        'products': await _stamps(_db.products, _db.products.id, _db.products.updatedAt),
        'inventory_movements': await _stamps(_db.inventoryMovements, _db.inventoryMovements.id, _db.inventoryMovements.updatedAt),
        'purchase_invoices': await _stamps(_db.purchaseInvoices, _db.purchaseInvoices.id, _db.purchaseInvoices.updatedAt),
        'purchase_items': await _stamps(_db.purchaseItems, _db.purchaseItems.id, _db.purchaseItems.updatedAt),
        'supplier_returns': await _stamps(_db.supplierReturns, _db.supplierReturns.id, _db.supplierReturns.updatedAt),
        'supplier_return_items': await _stamps(_db.supplierReturnItems, _db.supplierReturnItems.id, _db.supplierReturnItems.updatedAt),
        'sales': await _stamps(_db.sales, _db.sales.id, _db.sales.updatedAt),
        'sale_items': await _stamps(_db.saleItems, _db.saleItems.id, _db.saleItems.updatedAt),
      };

      // Keep the phone's newer copy of a row; otherwise take the cloud copy.
      bool phoneIsNewer(String collection, String id, DateTime cloudUpdatedAt) {
        final local = stamps[collection]?[id];
        return local != null && local.isAfter(cloudUpdatedAt);
      }

      final existingShop = await (_db.select(_db.shops)..where((s) => s.id.equals(shopId))).getSingleOrNull();
      if (existingShop == null) {
        final type = (shop['type'] as String?) ?? 'other';
        await _db.into(_db.shops).insert(ShopsCompanion.insert(
              id: shopId,
              name: (shop['name'] as String?) ?? L10n.t.cloudBackupService8,
              shopId: Value(shopId),
              deviceId: Value(currentShop?.deviceId ?? 'local_device'),
              shopType: Value(type),
              phone: Value(shop['phone'] as String?),
              address: Value(shop['address'] as String?),
              enableInstallments: Value(const {'mobile', 'electronics', 'furniture'}.contains(type)),
              createdAt: Value(now),
              updatedAt: Value(now),
            ));
      }

      for (final change in changes) {
        final collection = change['collection'] as String?;
        final json = Map<String, dynamic>.from(change['record'] as Map);
        if (collection == 'installments') {
          json['paidPiasters'] ??= 0;
          json['status'] ??= 'pending';
        }
        if (collection == 'settings' && isPrivateSetting(json['key'] as String? ?? '')) continue;

        Object? row;
        DateTime? cloudUpdatedAt;
        switch (collection) {
          case 'customers':
            final r = Customer.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'suppliers':
            final r = Supplier.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'transactions':
            final r = Transaction.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'installment_plans':
            final r = InstallmentPlan.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'installments':
            final r = Installment.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'cash_days':
            final r = CashDay.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'expenses':
            final r = Expense.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'settings':
            final r = AppSetting.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'products':
            final r = Product.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'inventory_movements':
            final r = InventoryMovement.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'purchase_invoices':
            final r = PurchaseInvoice.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'purchase_items':
            final r = PurchaseItem.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'supplier_returns':
            final r = SupplierReturn.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'supplier_return_items':
            final r = SupplierReturnItem.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'sales':
            final r = Sale.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          case 'sale_items':
            final r = SaleItem.fromJson(json, serializer: serializer);
            row = r;
            cloudUpdatedAt = r.updatedAt;
          default:
            break; // collections this app version doesn't store yet
        }
        if (row == null || cloudUpdatedAt == null) continue;
        if (phoneIsNewer(collection!, json['id'] as String, cloudUpdatedAt)) {
          keptLocal++;
          continue;
        }
        try {
          switch (collection) {
            case 'customers':
              await _db.into(_db.customers).insertOnConflictUpdate(row as Customer);
            case 'suppliers':
              await _db.into(_db.suppliers).insertOnConflictUpdate(row as Supplier);
            case 'transactions':
              await _db.into(_db.transactions).insertOnConflictUpdate(row as Transaction);
            case 'installment_plans':
              await _db.into(_db.installmentPlans).insertOnConflictUpdate(row as InstallmentPlan);
            case 'installments':
              await _db.into(_db.installments).insertOnConflictUpdate(row as Installment);
            case 'cash_days':
              final cashDay = row as CashDay;
              await (_db.delete(_db.cashDays)
                    ..where((c) => c.date.equals(cashDay.date) & c.id.equals(cashDay.id).not()))
                  .go();
              await _db.into(_db.cashDays).insertOnConflictUpdate(cashDay);
            case 'expenses':
              await _db.into(_db.expenses).insertOnConflictUpdate(row as Expense);
            case 'settings':
              final setting = row as AppSetting;
              await (_db.delete(_db.appSettings)
                    ..where((s) => s.key.equals(setting.key) & s.id.equals(setting.id).not()))
                  .go();
              await _db.into(_db.appSettings).insertOnConflictUpdate(setting);
            case 'products':
              await _db.into(_db.products).insertOnConflictUpdate(row as Product);
            case 'inventory_movements':
              await _db.into(_db.inventoryMovements).insertOnConflictUpdate(row as InventoryMovement);
            case 'purchase_invoices':
              await _db.into(_db.purchaseInvoices).insertOnConflictUpdate(row as PurchaseInvoice);
            case 'purchase_items':
              await _db.into(_db.purchaseItems).insertOnConflictUpdate(row as PurchaseItem);
            case 'supplier_returns':
              await _db.into(_db.supplierReturns).insertOnConflictUpdate(row as SupplierReturn);
            case 'supplier_return_items':
              await _db.into(_db.supplierReturnItems).insertOnConflictUpdate(row as SupplierReturnItem);
            case 'sales':
              await _db.into(_db.sales).insertOnConflictUpdate(row as Sale);
            case 'sale_items':
              await _db.into(_db.saleItems).insertOnConflictUpdate(row as SaleItem);
          }
          written++;
        } catch (e) {
          // If a single row fails due to corrupted data, keep processing the rest
        }
      }

      for (final entry in {'active_shop_id': shopId, 'onboarding_completed': 'true'}.entries) {
        await (_db.delete(_db.appSettings)..where((s) => s.key.equals(entry.key))).go();
        await _db.into(_db.appSettings).insert(AppSettingsCompanion(
              id: Value('setting-${entry.key}'),
              key: Value(entry.key),
              value: Value(entry.value),
              createdAt: Value(now),
              updatedAt: Value(now),
            ));
      }
    });

    final session = await _store.read();
    if (session != null) {
      await _store.write(session.copyWith(linkedShopId: shopId, lastBackupAt: now, lastBackupStartedAt: now));
    }
    return RestoreResult(written, keptLocal);
  }

  /// `id → updatedAt` for every row of a table (deleted rows included).
  Future<Map<String, DateTime>> _stamps<T extends Table, D>(
    TableInfo<T, D> table,
    GeneratedColumn<String> id,
    GeneratedColumn<DateTime> updatedAt,
  ) async {
    final query = _db.selectOnly(table)..addColumns([id, updatedAt]);
    final rows = await query.get();
    return {for (final r in rows) r.read(id)!: r.read(updatedAt)!};
  }

  /// Checks if there are local rows created or updated after the last cloud backup.
  Future<bool> hasUnbackedChanges() async {
    final session = await _store.read();
    if (session == null) return false;
    final lastTime = session.lastBackupAt ?? session.lastBackupStartedAt;
    if (lastTime == null) {
      final hasCust = (await (_db.select(_db.customers)..limit(1)).get()).isNotEmpty;
      final hasTx = (await (_db.select(_db.transactions)..limit(1)).get()).isNotEmpty;
      return hasCust || hasTx;
    }

    Future<bool> tableChanged<T extends Table, D extends DataClass>(
      TableInfo<T, D> table,
      GeneratedColumn<DateTime> updatedAt,
    ) async {
      final changed = await (_db.select(table)..where((_) => updatedAt.isBiggerThanValue(lastTime))..limit(1)).get();
      return changed.isNotEmpty;
    }

    if (await tableChanged(_db.customers, _db.customers.updatedAt)) return true;
    if (await tableChanged(_db.suppliers, _db.suppliers.updatedAt)) return true;
    if (await tableChanged(_db.transactions, _db.transactions.updatedAt)) return true;
    if (await tableChanged(_db.installmentPlans, _db.installmentPlans.updatedAt)) return true;
    if (await tableChanged(_db.installments, _db.installments.updatedAt)) return true;
    if (await tableChanged(_db.cashDays, _db.cashDays.updatedAt)) return true;
    if (await tableChanged(_db.expenses, _db.expenses.updatedAt)) return true;
    return false;
  }

  /// Restores the user's shop from the cloud after login.
  /// If cloud shops exist, it restores the shop and returns the result.
  Future<RestoreResult?> restoreUserShopOnLogin({CloudProgress? onProgress}) async {
    try {
      final shops = await listCloudShops();
      if (shops.isEmpty) return null;
      final session = await _store.read();
      final shop = shops.firstWhere(
        (s) => s['id'] == session?.linkedShopId,
        orElse: () => shops.first,
      );
      return await restore(shop, onProgress: onProgress);
    } catch (_) {
      return null;
    }
  }
}
