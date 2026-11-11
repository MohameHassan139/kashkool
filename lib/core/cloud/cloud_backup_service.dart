import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
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
  const BackupResult(
    this.uploaded,
    this.unchanged,
    this.rejected,
    this.rejectReasons,
  );
}

class RestoreResult {
  /// Rows written to the phone.
  final int records;

  /// Rows skipped because the copy on the phone was newer.
  final int keptLocal;

  /// Local attachment files that could not be removed.
  final int filesNotDeleted;
  const RestoreResult(
    this.records, [
    this.keptLocal = 0,
    this.filesNotDeleted = 0,
  ]);
}

/// Cloud backup on the Kashkool backend: Google or email sign-in, upload local rows, restore on a phone.
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
  static final ValueSerializer serializer = ValueSerializer.defaults(
    serializeDateTimeValuesAsString: true,
  );

  /// Settings that must never leave the phone, or are device-specific.
  static bool isPrivateSetting(String key) =>
      key.startsWith('security_') ||
      const {
        'active_shop_id',
        'data_last_backup_at',
        'shop_logo_path',
        'onboarding_completed',
        'cloud_account_user_id',
        'cloud_account_transition_pending',
      }.contains(key);

  // ---------- account ----------

  Future<CloudSession> signIn() async {
    final google = _google;
    if (google == null)
      throw CloudApiException('not_configured', L10n.t.cloudBackupService1);
    final idToken = await google.getIdToken();
    return _api.loginWithGoogle(idToken, deviceLabel: 'android');
  }

  Future<CloudSession> signInWithEmail(
    String email,
    String password, {
    bool register = false,
    String? name,
  }) async {
    return _api.loginWithEmail(email, password, register: register, name: name);
  }

  Future<CloudSession> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) {
    return signInWithEmail(email, password, register: true, name: name);
  }

  Future<void> rememberAccount(CloudSession session) async {
    final now = DateTime.now();
    await _db.transaction(() async {
      await _db
          .into(_db.appSettings)
          .insertOnConflictUpdate(
            AppSettingsCompanion(
              id: const Value('setting-cloud_account_user_id'),
              key: const Value('cloud_account_user_id'),
              value: Value(session.userId),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
      await endAccountTransition();
    });
  }

  Future<void> beginAccountTransition() async {
    final now = DateTime.now();
    await _db
        .into(_db.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion(
            id: const Value('setting-cloud_account_transition_pending'),
            key: const Value('cloud_account_transition_pending'),
            value: const Value('true'),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
  }

  Future<void> endAccountTransition() async {
    await (_db.delete(
      _db.appSettings,
    )..where((s) => s.key.equals('cloud_account_transition_pending'))).go();
  }

  Future<bool> accountTransitionPending() async {
    return await _setting('cloud_account_transition_pending') == 'true';
  }

  Future<bool> accountMatches(CloudSession session) async {
    final userId = await localAccountUserId();
    return userId == null || userId == session.userId;
  }

  Future<void> _ensureBackupAccount(CloudSession session) async {
    if (await accountTransitionPending() || !await accountMatches(session)) {
      throw CloudApiException('account_transition', L10n.t.cloudBackupService3);
    }
  }

  Future<String?> localAccountUserId() async {
    final setting = await (_db.select(
      _db.appSettings,
    )..where((s) => s.key.equals('cloud_account_user_id'))).getSingleOrNull();
    return setting?.value;
  }

  Future<bool> hasLocalShopData() async {
    final shopCount = await _db.select(_db.shops).get();
    return shopCount.isNotEmpty;
  }

  Future<bool> hasUnbackedChanges() async {
    final session = await _store.read();
    final localBackup = await _setting('data_last_backup_at');
    final since =
        session?.lastBackupStartedAt ?? DateTime.tryParse(localBackup ?? '');
    if (since == null) return true;
    return (await collectChanges(
      since.subtract(const Duration(minutes: 2)),
    )).isNotEmpty;
  }

  Future<void> signOut() async {
    await _api.logout();
    await _google?.signOut();
  }

  // ---------- backup ----------

  Future<Shop> _activeShop() async {
    final setting = await (_db.select(
      _db.appSettings,
    )..where((s) => s.key.equals('active_shop_id'))).getSingleOrNull();
    if (setting != null && setting.value.isNotEmpty) {
      final shop =
          await (_db.select(_db.shops)..where(
                (s) => s.id.equals(setting.value) & s.deletedAt.isNull(),
              ))
              .getSingleOrNull();
      if (shop != null) return shop;
    }
    final first =
        await (_db.select(_db.shops)
              ..where((s) => s.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    if (first == null)
      throw CloudApiException('no_shop', L10n.t.cloudBackupService2);
    return first;
  }

  Future<String?> _setting(String key) async {
    final row = await (_db.select(
      _db.appSettings,
    )..where((s) => s.key.equals(key))).getSingleOrNull();
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
      if (from != null)
        query.where((_) => updatedAt.isBiggerOrEqualValue(from));
      for (final row in await query.get()) {
        if (include != null && !include(row)) continue;
        changes.add({
          'collection': collection,
          'record': row.toJson(serializer: serializer),
        });
      }
    }

    // Parents first, then the rows that point at them.
    await add('customers', _db.customers, _db.customers.updatedAt);
    await add('suppliers', _db.suppliers, _db.suppliers.updatedAt);
    await add(
      'installment_plans',
      _db.installmentPlans,
      _db.installmentPlans.updatedAt,
    );
    await add('installments', _db.installments, _db.installments.updatedAt);
    await add('transactions', _db.transactions, _db.transactions.updatedAt);
    await add('cash_days', _db.cashDays, _db.cashDays.updatedAt);
    await add('expenses', _db.expenses, _db.expenses.updatedAt);
    await add(
      'settings',
      _db.appSettings,
      _db.appSettings.updatedAt,
      include: (AppSetting s) => !isPrivateSetting(s.key),
    );
    return changes;
  }

  /// Uploads everything that changed since the last backup (the first backup uploads everything).
  Future<BackupResult> backupNow({
    CloudProgress? onProgress,
    bool full = false,
  }) async {
    final session = await _store.read();
    if (session == null)
      throw CloudApiException('signed_out', L10n.t.cloudApi2, statusCode: 401);
    await _ensureBackupAccount(session);

    onProgress?.call(L10n.t.cloudBackupService3, null);
    final shop = await _activeShop();
    await _ensureBackupAccount(session);
    await _api.registerShop(
      id: shop.id,
      name: shop.name,
      type: shop.shopType,
      phone: shop.phone,
      address: shop.address,
      shopCode: await _setting('growth_shop_referral_code'),
    );

    final startedAt = DateTime.now();
    final incremental =
        !full &&
        session.linkedShopId == shop.id &&
        session.lastBackupStartedAt != null;
    // Small overlap so nothing is missed; re-sending a row is harmless (server answers "unchanged").
    final since = incremental
        ? session.lastBackupStartedAt!.subtract(const Duration(minutes: 2))
        : null;
    final changes = await collectChanges(since);

    var uploaded = 0, unchanged = 0, rejected = 0;
    final reasons = <String>[];
    for (var i = 0; i < changes.length; i += _pushBatchSize) {
      await _ensureBackupAccount(session);
      final batch = changes.sublist(
        i,
        i + _pushBatchSize > changes.length
            ? changes.length
            : i + _pushBatchSize,
      );
      onProgress?.call(
        L10n.t.cloudBackupService4(i + batch.length, changes.length),
        changes.isEmpty ? null : (i + batch.length) / changes.length,
      );
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
            if (reasons.length < 5)
              reasons.add('${r['collection']}: ${r['reason']}');
        }
      }
    }

    final latest = await _store.read() ?? session;
    await _store.write(
      latest.copyWith(
        linkedShopId: shop.id,
        lastBackupAt: DateTime.now(),
        lastBackupStartedAt: startedAt,
      ),
    );
    await _db
        .into(_db.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion(
            id: const Value('setting-data_last_backup_at'),
            key: const Value('data_last_backup_at'),
            value: Value(DateTime.now().toIso8601String()),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );
    onProgress?.call(L10n.t.cloudBackupService5, 1);
    return BackupResult(uploaded, unchanged, rejected, reasons);
  }

  // ---------- restore ----------

  /// Shops accessible to the signed-in account (to choose what to restore).
  Future<List<Map<String, dynamic>>> listCloudShops() => _api.listShops();

  /// Restores the previously linked shop, or the first available shop on a new device.
  Future<RestoreResult?> restoreAccountShop({
    CloudProgress? onProgress,
    bool replaceLocalData = false,
  }) async {
    final session = await _store.read();
    if (session == null) {
      throw CloudApiException('signed_out', L10n.t.cloudApi2, statusCode: 401);
    }
    final shops = await listCloudShops();
    if (shops.isEmpty) return null;
    final shop = shops.firstWhere(
      (candidate) => candidate['id'] == session.linkedShopId,
      orElse: () => shops.first,
    );
    return restore(
      shop,
      onProgress: onProgress,
      replaceLocalData: replaceLocalData,
    );
  }

  /// Brings a cloud shop to this phone. By default, cloud rows are merged without deleting
  /// phone-only rows; [replaceLocalData] clears the previous shop before importing.
  Future<RestoreResult> restore(
    Map<String, dynamic> shop, {
    CloudProgress? onProgress,
    bool replaceLocalData = false,
  }) async {
    final shopId = shop['id'] as String;
    final changes = <Map<String, dynamic>>[];
    final initialSession = await _store.read();
    var cursor = initialSession?.linkedShopId == shopId
        ? initialSession!.lastPullCursor
        : 0;
    while (true) {
      onProgress?.call(L10n.t.cloudBackupService6(changes.length), null);
      final page = await _api.pull(shopId, since: cursor, limit: 1000);
      changes.addAll(page.changes);
      cursor = page.cursor;
      if (!page.hasMore) break;
    }

    onProgress?.call(L10n.t.cloudBackupService7(changes.length), null);
    final now = DateTime.now();
    final currentShop =
        await (_db.select(_db.shops)
              ..where((s) => s.deletedAt.isNull())
              ..limit(1))
            .getSingleOrNull();
    var written = 0, keptLocal = 0;
    final localFiles = replaceLocalData
        ? await _localAttachmentPaths()
        : <String>[];
    final directory = localFiles.isEmpty
        ? null
        : await getApplicationDocumentsDirectory();

    await _db.transaction(() async {
      if (replaceLocalData) {
        await _clearLocalAccountData();
      }

      final stamps = {
        'customers': await _stamps(
          _db.customers,
          _db.customers.id,
          _db.customers.updatedAt,
        ),
        'suppliers': await _stamps(
          _db.suppliers,
          _db.suppliers.id,
          _db.suppliers.updatedAt,
        ),
        'transactions': await _stamps(
          _db.transactions,
          _db.transactions.id,
          _db.transactions.updatedAt,
        ),
        'installment_plans': await _stamps(
          _db.installmentPlans,
          _db.installmentPlans.id,
          _db.installmentPlans.updatedAt,
        ),
        'installments': await _stamps(
          _db.installments,
          _db.installments.id,
          _db.installments.updatedAt,
        ),
        'cash_days': await _stamps(
          _db.cashDays,
          _db.cashDays.id,
          _db.cashDays.updatedAt,
        ),
        'expenses': await _stamps(
          _db.expenses,
          _db.expenses.id,
          _db.expenses.updatedAt,
        ),
        'settings': await _stamps(
          _db.appSettings,
          _db.appSettings.id,
          _db.appSettings.updatedAt,
        ),
      };

      // Keep the phone's newer copy of a row; otherwise take the cloud copy.
      bool phoneIsNewer(String collection, String id, DateTime cloudUpdatedAt) {
        final local = stamps[collection]?[id];
        return local != null && local.isAfter(cloudUpdatedAt);
      }

      final existingShop = await (_db.select(
        _db.shops,
      )..where((s) => s.id.equals(shopId))).getSingleOrNull();
      if (existingShop == null) {
        final type = (shop['type'] as String?) ?? 'other';
        await _db
            .into(_db.shops)
            .insert(
              ShopsCompanion.insert(
                id: shopId,
                name: (shop['name'] as String?) ?? L10n.t.cloudBackupService8,
                shopId: Value(shopId),
                deviceId: Value(currentShop?.deviceId ?? 'local_device'),
                shopType: Value(type),
                phone: Value(shop['phone'] as String?),
                address: Value(shop['address'] as String?),
                enableInstallments: Value(
                  const {'mobile', 'electronics', 'furniture'}.contains(type),
                ),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      }

      for (final change in changes) {
        final collection = change['collection'] as String?;
        final json = Map<String, dynamic>.from(change['record'] as Map);
        if (collection == 'installments') {
          json['paidPiasters'] ??= 0;
          json['status'] ??= 'pending';
        }
        if (collection == 'settings' &&
            isPrivateSetting(json['key'] as String? ?? ''))
          continue;

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
          default:
            break; // collections this app version doesn't store yet
        }
        if (row == null || cloudUpdatedAt == null) continue;
        if (phoneIsNewer(collection!, json['id'] as String, cloudUpdatedAt)) {
          keptLocal++;
          continue;
        }
        switch (collection) {
          case 'customers':
            await _db
                .into(_db.customers)
                .insertOnConflictUpdate(row as Customer);
          case 'suppliers':
            await _db
                .into(_db.suppliers)
                .insertOnConflictUpdate(row as Supplier);
          case 'transactions':
            await _db
                .into(_db.transactions)
                .insertOnConflictUpdate(row as Transaction);
          case 'installment_plans':
            await _db
                .into(_db.installmentPlans)
                .insertOnConflictUpdate(row as InstallmentPlan);
          case 'installments':
            await _db
                .into(_db.installments)
                .insertOnConflictUpdate(row as Installment);
          case 'cash_days':
            await _db.into(_db.cashDays).insertOnConflictUpdate(row as CashDay);
          case 'expenses':
            await _db.into(_db.expenses).insertOnConflictUpdate(row as Expense);
          case 'settings':
            await _db
                .into(_db.appSettings)
                .insertOnConflictUpdate(row as AppSetting);
        }
        written++;
      }

      for (final entry in {
        'active_shop_id': shopId,
        'onboarding_completed': 'true',
      }.entries) {
        await _db
            .into(_db.appSettings)
            .insertOnConflictUpdate(
              AppSettingsCompanion(
                id: Value('setting-${entry.key}'),
                key: Value(entry.key),
                value: Value(entry.value),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      }
    });

    final session = await _store.read();
    if (session != null) {
      await _store.write(
        session.copyWith(linkedShopId: shopId, lastPullCursor: cursor),
      );
    }
    final filesNotDeleted = replaceLocalData && directory != null
        ? await _deleteLocalFiles(localFiles, directory)
        : 0;
    return RestoreResult(written, keptLocal, filesNotDeleted);
  }

  Future<int> clearLocalAccountData() async {
    final paths = await _localAttachmentPaths();
    final directory = paths.isEmpty
        ? null
        : await getApplicationDocumentsDirectory();
    await _db.transaction(_clearLocalAccountData);
    return paths.isEmpty ? 0 : _deleteLocalFiles(paths, directory!);
  }

  Future<void> _clearLocalAccountData() async {
    await _db.delete(_db.installments).go();
    await _db.delete(_db.installmentPlans).go();
    await _db.delete(_db.transactions).go();
    await _db.delete(_db.customerPhotos).go();
    await _db.delete(_db.customers).go();
    await _db.delete(_db.suppliers).go();
    await _db.delete(_db.expenses).go();
    await _db.delete(_db.cashDays).go();
    await _db.delete(_db.shops).go();
    const preservedSettings = {
      'privacy_mode_enabled',
      'home_widget_enabled',
      'cloud_account_user_id',
      'cloud_account_transition_pending',
    };
    final settingsToDelete = (await _db.select(_db.appSettings).get())
        .where(
          (setting) =>
              !setting.key.startsWith('security_') &&
              !setting.key.startsWith('general_') &&
              !preservedSettings.contains(setting.key),
        )
        .map((setting) => setting.key)
        .toList();
    if (settingsToDelete.isNotEmpty) {
      await (_db.delete(
        _db.appSettings,
      )..where((setting) => setting.key.isIn(settingsToDelete))).go();
    }
  }

  Future<List<String>> _localAttachmentPaths() async {
    final paths = <String>[];
    paths.addAll(
      (await _db.select(_db.customerPhotos).get()).map((row) => row.filePath),
    );
    paths.addAll(
      (await _db.select(_db.transactions).get())
          .map((row) => row.photoPath)
          .whereType<String>(),
    );
    paths.addAll(
      (await _db.select(_db.installmentPlans).get())
          .map((row) => row.photoPath)
          .whereType<String>(),
    );
    final logo = await _setting('shop_logo_path');
    if (logo != null && logo.isNotEmpty) paths.add(logo);
    return paths;
  }

  Future<int> _deleteLocalFiles(List<String> paths, Directory directory) async {
    var failures = 0;
    for (final path in paths.toSet()) {
      final normalized = p.normalize(
        p.isAbsolute(path) ? path : p.join(directory.path, path),
      );
      if (!p.isWithin(directory.path, normalized)) continue;
      final file = File(normalized);
      if (!await file.exists()) continue;
      try {
        await file.delete();
      } on FileSystemException {
        failures++;
      }
    }
    return failures;
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
}
