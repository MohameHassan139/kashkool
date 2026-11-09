import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/cloud/cloud_api.dart';
import 'package:kashkool/core/cloud/cloud_backup_service.dart';
import 'package:kashkool/core/cloud/cloud_session_store.dart';
import 'package:kashkool/core/db/app_database.dart';

/// Fake backend that keeps pushed records in memory (like the real server's sync API).
class FakeCloudApi extends CloudApi {
  FakeCloudApi(CloudSessionStore store) : super(store, baseUrl: 'https://api.test');

  final Map<String, Map<String, dynamic>> server = {};
  final List<List<Map<String, dynamic>>> pushedBatches = [];
  int seq = 0;
  Map<String, dynamic>? registered;

  @override
  Future<Map<String, dynamic>> registerShop({
    required String id,
    required String name,
    required String type,
    String? phone,
    String? address,
    String? shopCode,
  }) async {
    registered = {'id': id, 'name': name, 'type': type, 'phone': phone, 'address': address};
    return registered!;
  }

  @override
  Future<List<Map<String, dynamic>>> push(String shopId, String deviceId, List<Map<String, dynamic>> changes) async {
    pushedBatches.add(changes);
    return [
      for (final c in changes)
        () {
          final record = Map<String, dynamic>.from(c['record'] as Map);
          final key = '${c['collection']}:${record['id']}';
          final existed = server.containsKey(key);
          server[key] = {'collection': c['collection'], 'record': {...record, 'shopId': shopId, 'serverSeq': ++seq}};
          return {'collection': c['collection'], 'id': record['id'], 'status': existed ? 'updated' : 'inserted'};
        }(),
    ];
  }

  @override
  Future<PullPage> pull(String shopId, {int since = 0, int limit = 1000}) async {
    final all = server.values.where((c) => ((c['record'] as Map)['serverSeq'] as int) > since).toList()
      ..sort((a, b) => ((a['record'] as Map)['serverSeq'] as int).compareTo((b['record'] as Map)['serverSeq'] as int));
    final page = all.take(limit).toList();
    final cursor = page.isEmpty ? since : (page.last['record'] as Map)['serverSeq'] as int;
    return PullPage(page, cursor, all.length > limit);
  }

  @override
  Future<List<Map<String, dynamic>>> listShops() async => [if (registered != null) registered!];
}

Future<void> seed(AppDatabase db) async {
  await db.into(db.shops).insert(ShopsCompanion.insert(id: 'shop-1', name: 'سوبر ماركت النور', shopType: const Value('grocery')));
  await db.into(db.appSettings).insert(AppSettingsCompanion.insert(id: 'setting-active_shop_id', key: 'active_shop_id', value: 'shop-1'));
  await db.into(db.appSettings).insert(AppSettingsCompanion.insert(id: 'setting-security_pin_hash', key: 'security_pin_hash', value: 'secret'));
  await db.into(db.appSettings).insert(AppSettingsCompanion.insert(id: 'setting-shop_name', key: 'shop_name', value: 'سوبر ماركت النور'));
  await db.into(db.customers).insert(CustomersCompanion.insert(id: 'c1', name: 'أحمد محمد'));
  await db.into(db.transactions).insert(TransactionsCompanion.insert(
        id: 't1',
        partyType: PartyType.customer,
        partyId: 'c1',
        type: TransactionType.debt,
        amountPiasters: 15000,
        occurredAt: Value(DateTime(2026, 11, 1, 10)),
      ));
  await db.into(db.installmentPlans).insert(InstallmentPlansCompanion.insert(
        id: 'p1',
        customerId: 'c1',
        itemDescription: 'Samsung A15',
        totalPricePiasters: 1200000,
        installmentCount: 2,
        startDate: DateTime(2026, 12, 1),
      ));
  await db.into(db.installments).insert(InstallmentsCompanion.insert(
        id: 'i1',
        planId: 'p1',
        installmentIndex: 1,
        dueDate: DateTime(2026, 12, 1),
        amountPiasters: 600000,
        paidPiasters: const Value(600000),
        status: const Value(InstallmentStatus.paid),
      ));
}

void main() {
  late AppDatabase db;
  late MemoryCloudSessionStore store;
  late FakeCloudApi api;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    store = MemoryCloudSessionStore();
    await store.write(const CloudSession(accessToken: 'a', refreshToken: 'r', userId: 'u1', email: 'a@test.com'));
    api = FakeCloudApi(store);
    await seed(db);
  });

  tearDown(() => db.close());

  test('first backup uploads every row, never security settings, dates as ISO strings', () async {
    final result = await CloudBackupService(db, api, store).backupNow();

    expect(api.registered!['id'], 'shop-1');
    final all = api.pushedBatches.expand((b) => b).toList();
    final collections = all.map((c) => c['collection']).toSet();
    expect(collections, containsAll(['customers', 'transactions', 'installment_plans', 'installments', 'settings']));

    final settingKeys = all.where((c) => c['collection'] == 'settings').map((c) => (c['record'] as Map)['key']).toList();
    expect(settingKeys, contains('shop_name'));
    expect(settingKeys, isNot(contains('security_pin_hash')));
    expect(settingKeys, isNot(contains('active_shop_id')));

    final tx = all.firstWhere((c) => c['collection'] == 'transactions')['record'] as Map;
    expect(tx['occurredAt'], isA<String>());
    expect(DateTime.tryParse(tx['occurredAt'] as String), isNotNull);
    expect(tx['partyType'], 'customer');
    expect(tx['type'], 'debt');

    expect(result.uploaded, all.length);
    expect(result.rejected, 0);
    final session = await store.read();
    expect(session!.linkedShopId, 'shop-1');
    expect(session.lastBackupAt, isNotNull);
  });

  test('next backup only uploads rows changed since the last one', () async {
    final service = CloudBackupService(db, api, store);
    await service.backupNow();
    // Pretend the last backup started a while ago, and nothing changed since.
    final s = await store.read();
    await store.write(s!.copyWith(lastBackupStartedAt: DateTime.now().add(const Duration(hours: 1))));
    api.pushedBatches.clear();

    await db.into(db.customers).insert(CustomersCompanion.insert(
          id: 'c2',
          name: 'محمود',
          updatedAt: Value(DateTime.now().add(const Duration(hours: 2))),
        ));
    await service.backupNow();
    final ids = api.pushedBatches.expand((b) => b).map((c) => (c['record'] as Map)['id']).toList();
    expect(ids, ['c2']);
  });

  test('restore on a new phone brings everything back and keeps that phone\'s PIN', () async {
    await CloudBackupService(db, api, store).backupNow();

    final newPhone = AppDatabase(NativeDatabase.memory());
    addTearDown(newPhone.close);
    await newPhone.into(newPhone.appSettings).insert(
          AppSettingsCompanion.insert(id: 'setting-security_pin_hash', key: 'security_pin_hash', value: 'new-phone-pin'),
        );

    final result = await CloudBackupService(newPhone, api, store).restore(api.registered!);
    expect(result.records, greaterThan(0));

    final customers = await newPhone.select(newPhone.customers).get();
    expect(customers.single.name, 'أحمد محمد');
    final tx = await newPhone.select(newPhone.transactions).getSingle();
    expect(tx.amountPiasters, 15000);
    expect(tx.occurredAt, DateTime(2026, 11, 1, 10));
    final inst = await newPhone.select(newPhone.installments).getSingle();
    expect(inst.paidPiasters, 600000);
    expect(inst.status, InstallmentStatus.paid);

    final shop = await newPhone.select(newPhone.shops).getSingle();
    expect(shop.id, 'shop-1');
    final settings = {for (final s in await newPhone.select(newPhone.appSettings).get()) s.key: s.value};
    expect(settings['active_shop_id'], 'shop-1');
    expect(settings['onboarding_completed'], 'true');
    expect(settings['shop_name'], 'سوبر ماركت النور');
    expect(settings['security_pin_hash'], 'new-phone-pin');
  });

  test('restore never deletes: phone-only rows stay, newer phone edits win', () async {
    await CloudBackupService(db, api, store).backupNow();

    final phone = AppDatabase(NativeDatabase.memory());
    addTearDown(phone.close);
    // A customer that exists only on this phone.
    await phone.into(phone.customers).insert(CustomersCompanion.insert(id: 'phone-only', name: 'عميل الموبايل'));
    // The same customer as the cloud (c1), edited on the phone AFTER the cloud copy.
    await phone.into(phone.customers).insert(CustomersCompanion.insert(
          id: 'c1',
          name: 'أحمد (معدّل على الموبايل)',
          updatedAt: Value(DateTime.now().add(const Duration(days: 1))),
        ));

    final result = await CloudBackupService(phone, api, store).restore(api.registered!);
    expect(result.keptLocal, 1);

    final customers = {for (final c in await phone.select(phone.customers).get()) c.id: c.name};
    expect(customers['phone-only'], 'عميل الموبايل');
    expect(customers['c1'], 'أحمد (معدّل على الموبايل)');
    expect(await phone.select(phone.transactions).get(), hasLength(1));
  });

  test('backup without signing in fails with a clear error', () async {
    await store.clear();
    await expectLater(
      CloudBackupService(db, api, store).backupNow(),
      throwsA(isA<CloudApiException>().having((e) => e.code, 'code', 'signed_out')),
    );
  });
}
