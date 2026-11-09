import 'package:drift/drift.dart';
import '../db/app_database.dart';
import 'cloud_api.dart';
import 'cloud_session_store.dart';
import 'google_auth_service.dart';

typedef CloudProgress = void Function(String message, double? fraction);

class BackupResult {
  final int uploaded;
  final int unchanged;
  final int rejected;
  final List<String> rejectReasons;
  const BackupResult(this.uploaded, this.unchanged, this.rejected, this.rejectReasons);
}

class RestoreResult {
  final int records;
  const RestoreResult(this.records);
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
  static final ValueSerializer serializer = ValueSerializer.defaults(serializeDateTimeValuesAsString: true);

  /// Settings that must never leave the phone, or are device-specific.
  static bool isPrivateSetting(String key) =>
      key.startsWith('security_') ||
      const {'active_shop_id', 'data_last_backup_at', 'shop_logo_path', 'onboarding_completed'}.contains(key);

  // ---------- account ----------

  Future<CloudSession> signIn() async {
    final google = _google;
    if (google == null) throw const CloudApiException('not_configured', 'تسجيل الدخول بجوجل مش متاح');
    final idToken = await google.getIdToken();
    return _api.loginWithGoogle(idToken, deviceLabel: 'android');
  }

  Future<void> signOut() async {
    await _api.logout();
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
    if (first == null) throw const CloudApiException('no_shop', 'كمّل بيانات المحل الأول من الإعدادات');
    return first;
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
    await add('settings', _db.appSettings, _db.appSettings.updatedAt, include: (AppSetting s) => !isPrivateSetting(s.key));
    return changes;
  }

  /// Uploads everything that changed since the last backup (the first backup uploads everything).
  Future<BackupResult> backupNow({CloudProgress? onProgress, bool full = false}) async {
    final session = await _store.read();
    if (session == null) throw const CloudApiException('signed_out', 'سجّل دخول بحساب جوجل الأول', statusCode: 401);

    onProgress?.call('بنجهّز بيانات المحل…', null);
    final shop = await _activeShop();
    await _api.registerShop(
      id: shop.id,
      name: shop.name,
      type: shop.shopType,
      phone: shop.phone,
      address: shop.address,
      shopCode: await _setting('growth_shop_referral_code'),
    );

    final startedAt = DateTime.now();
    final incremental = !full && session.linkedShopId == shop.id && session.lastBackupStartedAt != null;
    // Small overlap so nothing is missed; re-sending a row is harmless (server answers "unchanged").
    final since = incremental ? session.lastBackupStartedAt!.subtract(const Duration(minutes: 2)) : null;
    final changes = await collectChanges(since);

    var uploaded = 0, unchanged = 0, rejected = 0;
    final reasons = <String>[];
    for (var i = 0; i < changes.length; i += _pushBatchSize) {
      final batch = changes.sublist(i, i + _pushBatchSize > changes.length ? changes.length : i + _pushBatchSize);
      onProgress?.call('بنرفع ${i + batch.length} من ${changes.length}…', changes.isEmpty ? null : (i + batch.length) / changes.length);
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
    onProgress?.call('خلصنا ✓', 1);
    return BackupResult(uploaded, unchanged, rejected, reasons);
  }

  // ---------- restore ----------

  /// Shops on this Google account (to choose what to restore).
  Future<List<Map<String, dynamic>>> listCloudShops() => _api.listShops();

  /// Replaces ALL data on this phone with the cloud copy of [shopId].
  /// Security settings (PIN, fingerprint) on this phone are kept.
  Future<RestoreResult> restore(Map<String, dynamic> shop, {CloudProgress? onProgress}) async {
    final shopId = shop['id'] as String;
    final changes = <Map<String, dynamic>>[];
    var cursor = 0;
    while (true) {
      onProgress?.call('بننزّل البيانات… (${changes.length})', null);
      final page = await _api.pull(shopId, since: cursor, limit: 1000);
      changes.addAll(page.changes);
      cursor = page.cursor;
      if (!page.hasMore) break;
    }

    onProgress?.call('بنحفظ ${changes.length} سجل على الموبايل…', null);
    final now = DateTime.now();
    final deviceId = (await (_db.select(_db.shops)..limit(1)).getSingleOrNull())?.deviceId;

    await _db.transaction(() async {
      await _db.delete(_db.transactions).go();
      await _db.delete(_db.installments).go();
      await _db.delete(_db.installmentPlans).go();
      await _db.delete(_db.customers).go();
      await _db.delete(_db.suppliers).go();
      await _db.delete(_db.cashDays).go();
      await _db.delete(_db.expenses).go();
      await _db.delete(_db.shops).go();
      await (_db.delete(_db.appSettings)..where((s) => s.key.like('security_%').not())).go();

      final type = (shop['type'] as String?) ?? 'other';
      await _db.into(_db.shops).insertOnConflictUpdate(ShopsCompanion.insert(
            id: shopId,
            name: (shop['name'] as String?) ?? 'المحل',
            shopId: Value(shopId),
            deviceId: Value(deviceId ?? 'local_device'),
            shopType: Value(type),
            phone: Value(shop['phone'] as String?),
            address: Value(shop['address'] as String?),
            enableInstallments: Value(const {'mobile', 'electronics', 'furniture'}.contains(type)),
            createdAt: Value(now),
            updatedAt: Value(now),
          ));

      for (final change in changes) {
        final json = Map<String, dynamic>.from(change['record'] as Map);
        switch (change['collection']) {
          case 'customers':
            await _db.into(_db.customers).insertOnConflictUpdate(Customer.fromJson(json, serializer: serializer));
          case 'suppliers':
            await _db.into(_db.suppliers).insertOnConflictUpdate(Supplier.fromJson(json, serializer: serializer));
          case 'transactions':
            await _db.into(_db.transactions).insertOnConflictUpdate(Transaction.fromJson(json, serializer: serializer));
          case 'installment_plans':
            await _db.into(_db.installmentPlans).insertOnConflictUpdate(InstallmentPlan.fromJson(json, serializer: serializer));
          case 'installments':
            json['paidPiasters'] ??= 0;
            json['status'] ??= 'pending';
            await _db.into(_db.installments).insertOnConflictUpdate(Installment.fromJson(json, serializer: serializer));
          case 'cash_days':
            await _db.into(_db.cashDays).insertOnConflictUpdate(CashDay.fromJson(json, serializer: serializer));
          case 'expenses':
            await _db.into(_db.expenses).insertOnConflictUpdate(Expense.fromJson(json, serializer: serializer));
          case 'settings':
            if (!isPrivateSetting(json['key'] as String? ?? '')) {
              await _db.into(_db.appSettings).insertOnConflictUpdate(AppSetting.fromJson(json, serializer: serializer));
            }
          default:
            break; // collections this app version doesn't store yet
        }
      }

      for (final entry in {'active_shop_id': shopId, 'onboarding_completed': 'true'}.entries) {
        await _db.into(_db.appSettings).insertOnConflictUpdate(AppSettingsCompanion(
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
    return RestoreResult(changes.length);
  }
}
