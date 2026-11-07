import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';
import '../../settings/data/settings_repository.dart';

/// Repository for Shop profile and onboarding state management.
class ShopRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  static const String keyActiveShopId = 'active_shop_id';
  static const String keyOnboardingCompleted = 'onboarding_completed';

  ShopRepository(this._db);

  /// Retrieves the current active shop or null if none exists yet.
  Future<Shop?> getActiveShop() async {
    // 1. Try reading active_shop_id from app_settings
    final setting = await (_db.select(_db.appSettings)
          ..where((s) => s.key.equals(keyActiveShopId)))
        .getSingleOrNull();

    if (setting != null && setting.value.isNotEmpty) {
      final shop = await (_db.select(_db.shops)
            ..where((s) => s.id.equals(setting.value) & s.deletedAt.isNull()))
          .getSingleOrNull();
      if (shop != null) return shop;
    }

    // 2. Fallback to first non-deleted shop
    final firstShop = await (_db.select(_db.shops)
          ..where((s) => s.deletedAt.isNull())
          ..limit(1))
        .getSingleOrNull();

    return firstShop;
  }

  /// Watches the current active shop.
  Stream<Shop?> watchActiveShop() {
    return (_db.select(_db.shops)
          ..where((s) => s.deletedAt.isNull())
          ..limit(1))
        .watchSingleOrNull();
  }

  /// Creates a new shop or updates the existing one.
  Future<Shop> createOrUpdateShop({
    required String name,
    required String shopType,
    String? phone,
    String? address,
    bool? enableInstallments,
  }) async {
    final now = DateTime.now();
    final existing = await getActiveShop();

    final bool installmentsAllowed = enableInstallments ??
        (shopType == 'mobile' || shopType == 'electronics');

    final String shopId = existing?.id ?? _uuid.v4();
    final String deviceId = existing?.deviceId ?? _uuid.v4();
    final String createdBy = existing?.createdBy ?? 'owner';

    final companion = ShopsCompanion(
      id: Value(shopId),
      shopId: Value(shopId),
      deviceId: Value(deviceId),
      createdBy: Value(createdBy),
      name: Value(name.trim()),
      shopType: Value(shopType),
      phone: Value(phone?.trim()),
      address: Value(address?.trim()),
      currency: const Value('EGP'),
      enableInstallments: Value(installmentsAllowed),
      createdAt: Value(existing?.createdAt ?? now),
      updatedAt: Value(now),
    );

    await _db.into(_db.shops).insertOnConflictUpdate(companion);

    // Save active_shop_id in settings
    await _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion(
            id: const Value('setting-active_shop_id'),
            key: const Value(keyActiveShopId),
            value: Value(shopId),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

    // Sync shop_name and shop_phone into legacy settings for compatibility with reminders & PDFs
    await _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion(
            id: const Value('setting-shop_name'),
            key: const Value(SettingsRepository.keyShopName),
            value: Value(name.trim()),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

    if (phone != null && phone.trim().isNotEmpty) {
      await _db.into(_db.appSettings).insertOnConflictUpdate(
            AppSettingsCompanion(
              id: const Value('setting-shop_phone'),
              key: const Value(SettingsRepository.keyShopPhone),
              value: Value(phone.trim()),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
    }

    final updated = await (_db.select(_db.shops)
          ..where((s) => s.id.equals(shopId)))
        .getSingle();

    return updated;
  }

  /// Checks if onboarding was completed.
  Future<bool> isOnboardingCompleted() async {
    final entry = await (_db.select(_db.appSettings)
          ..where((s) => s.key.equals(keyOnboardingCompleted)))
        .getSingleOrNull();
    return entry?.value == 'true';
  }

  /// Watches onboarding completion status reactively.
  Stream<bool> watchOnboardingCompleted() {
    return (_db.select(_db.appSettings)
          ..where((s) => s.key.equals(keyOnboardingCompleted)))
        .watchSingleOrNull()
        .map((entry) => entry?.value == 'true');
  }

  /// Sets onboarding completion status.
  Future<void> setOnboardingCompleted(bool completed) async {
    final now = DateTime.now();
    await _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion(
            id: const Value('setting-onboarding_completed'),
            key: const Value(keyOnboardingCompleted),
            value: Value(completed ? 'true' : 'false'),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
  }

  /// Seeds realistic test data for the shop owner to try out the app.
  Future<void> seedSampleData() async {
    final now = DateTime.now();
    final shop = await getActiveShop();
    final shopId = shop?.id ?? 'default-shop';
    final deviceId = shop?.deviceId ?? 'default-device';
    final createdBy = shop?.createdBy ?? 'owner';

    // 1. Sample customer 1 (Debt only)
    final cust1Id = _uuid.v4();
    await _db.into(_db.customers).insert(
          CustomersCompanion(
            id: Value(cust1Id),
            shopId: Value(shopId),
            deviceId: Value(deviceId),
            createdBy: Value(createdBy),
            name: const Value('أحمد محمد (تجريبي)'),
            phone: const Value('01012345678'),
            notes: const Value('[تجريبي] تجربة كشكول - مشتريات بالآجل'),
            creditLimitPiasters: const Value(150000), // 1,500 EGP
            createdAt: Value(now.subtract(const Duration(days: 5))),
            updatedAt: Value(now.subtract(const Duration(days: 5))),
          ),
        );

    await _db.into(_db.transactions).insert(
          TransactionsCompanion(
            id: Value(_uuid.v4()),
            shopId: Value(shopId),
            deviceId: Value(deviceId),
            createdBy: Value(createdBy),
            partyType: const Value(PartyType.customer),
            partyId: Value(cust1Id),
            type: const Value(TransactionType.debt),
            amountPiasters: const Value(35000), // 350 EGP
            note: const Value('مشتريات طلبات منزلية'),
            occurredAt: Value(now.subtract(const Duration(days: 5))),
            createdAt: Value(now.subtract(const Duration(days: 5))),
            updatedAt: Value(now.subtract(const Duration(days: 5))),
          ),
        );

    // 2. Sample customer 2 (Debt + Partial Payment)
    final cust2Id = _uuid.v4();
    await _db.into(_db.customers).insert(
          CustomersCompanion(
            id: Value(cust2Id),
            shopId: Value(shopId),
            deviceId: Value(deviceId),
            createdBy: Value(createdBy),
            name: const Value('محمود إبراهيم (تجريبي)'),
            phone: const Value('01198765432'),
            notes: const Value('[تجريبي] تجربة كشكول - سداد جزئي'),
            creditLimitPiasters: const Value(300000), // 3,000 EGP
            createdAt: Value(now.subtract(const Duration(days: 10))),
            updatedAt: Value(now.subtract(const Duration(days: 2))),
          ),
        );

    // Debt of 1200 EGP
    await _db.into(_db.transactions).insert(
          TransactionsCompanion(
            id: Value(_uuid.v4()),
            shopId: Value(shopId),
            deviceId: Value(deviceId),
            createdBy: Value(createdBy),
            partyType: const Value(PartyType.customer),
            partyId: Value(cust2Id),
            type: const Value(TransactionType.debt),
            amountPiasters: const Value(120000), // 1200 EGP
            note: const Value('بضاعة أول الشهر'),
            occurredAt: Value(now.subtract(const Duration(days: 10))),
            createdAt: Value(now.subtract(const Duration(days: 10))),
            updatedAt: Value(now.subtract(const Duration(days: 10))),
          ),
        );

    // Payment of 500 EGP
    await _db.into(_db.transactions).insert(
          TransactionsCompanion(
            id: Value(_uuid.v4()),
            shopId: Value(shopId),
            deviceId: Value(deviceId),
            createdBy: Value(createdBy),
            partyType: const Value(PartyType.customer),
            partyId: Value(cust2Id),
            type: const Value(TransactionType.payment),
            amountPiasters: const Value(50000), // 500 EGP
            note: const Value('دفعة نقدية على الحساب'),
            occurredAt: Value(now.subtract(const Duration(days: 2))),
            createdAt: Value(now.subtract(const Duration(days: 2))),
            updatedAt: Value(now.subtract(const Duration(days: 2))),
          ),
        );
  }

  /// Clears any sample / demo customers created during onboarding.
  Future<int> clearSampleData() async {
    final now = DateTime.now();
    return (_db.update(_db.customers)
          ..where((c) => c.notes.like('%[تجريبي]%') & c.deletedAt.isNull()))
        .write(CustomersCompanion(deletedAt: Value(now)));
  }
}

/// Global provider for ShopRepository
final shopRepositoryProvider = Provider<ShopRepository>((ref) {
  return ShopRepository(ref.watch(databaseProvider));
});

/// Watches the active shop
final activeShopStreamProvider = StreamProvider<Shop?>((ref) {
  return ref.watch(shopRepositoryProvider).watchActiveShop();
});

/// Stream provider watching whether onboarding is complete
final isOnboardingCompletedStreamProvider = StreamProvider<bool>((ref) {
  return ref.watch(shopRepositoryProvider).watchOnboardingCompleted();
});

/// Future provider checking if onboarding is complete
final isOnboardingCompletedProvider = FutureProvider<bool>((ref) {
  return ref.watch(shopRepositoryProvider).isOnboardingCompleted();
});

/// Provides whether installments is enabled for the shop
final installmentsEnabledProvider = Provider<bool>((ref) {
  final shop = ref.watch(activeShopStreamProvider).value;
  return shop?.enableInstallments ?? false;
});
