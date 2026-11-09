import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/trash/data/trash_repository.dart';

void main() {
  late AppDatabase db;
  late TrashRepository repo;
  final deletedAt = DateTime(2026, 11, 9, 12);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = TrashRepository(db);
    await db.into(db.customers).insert(CustomersCompanion.insert(id: 'c1', name: 'أحمد'));
    await db.into(db.customers).insert(CustomersCompanion.insert(id: 'c2', name: 'محمود', deletedAt: Value(deletedAt)));
    await db.into(db.transactions).insert(TransactionsCompanion.insert(
          id: 't1',
          partyType: PartyType.customer,
          partyId: 'c2',
          type: TransactionType.debt,
          amountPiasters: 5000,
          deletedAt: Value(deletedAt.add(const Duration(minutes: 1))),
        ));
    // An old version replaced by an edit: history, not trash.
    await db.into(db.transactions).insert(TransactionsCompanion.insert(
          id: 't-old',
          partyType: PartyType.customer,
          partyId: 'c1',
          type: TransactionType.debt,
          amountPiasters: 100,
          deletedAt: Value(deletedAt),
          supersededById: const Value('t-new'),
        ));
    await db.into(db.installmentPlans).insert(InstallmentPlansCompanion.insert(
          id: 'p1',
          customerId: 'c1',
          itemDescription: 'Samsung A15',
          totalPricePiasters: 1200000,
          installmentCount: 2,
          startDate: DateTime(2026, 12, 1),
          deletedAt: Value(deletedAt.subtract(const Duration(minutes: 1))),
        ));
    for (final i in [1, 2]) {
      await db.into(db.installments).insert(InstallmentsCompanion.insert(
            id: 'i$i',
            planId: 'p1',
            installmentIndex: i,
            dueDate: DateTime(2026, 11 + i, 1),
            amountPiasters: 600000,
            deletedAt: Value(deletedAt),
          ));
    }
  });

  tearDown(() => db.close());

  test('lists deleted items newest first, without edit history', () async {
    final items = await repo.load();
    expect(items.map((i) => i.id), ['t1', 'c2', 'p1']);
    expect(items.first.kind, TrashKind.transaction);
    expect(items.first.title, contains('محمود'));
    expect(items.first.amountPiasters, 5000);
  });

  test('restoring a transaction also restores its deleted customer', () async {
    final tx = (await repo.load()).firstWhere((i) => i.id == 't1');
    await repo.restore(tx);
    final t1 = await (db.select(db.transactions)..where((t) => t.id.equals('t1'))).getSingle();
    final c2 = await (db.select(db.customers)..where((c) => c.id.equals('c2'))).getSingle();
    expect(t1.deletedAt, isNull);
    expect(c2.deletedAt, isNull);
    expect((await repo.load()).map((i) => i.id), ['p1']);
  });

  test('restoring an installment plan restores its schedule too', () async {
    final plan = (await repo.load()).firstWhere((i) => i.kind == TrashKind.installmentPlan);
    await repo.restore(plan);
    final rows = await db.select(db.installments).get();
    expect(rows.every((r) => r.deletedAt == null), isTrue);
    final p = await db.select(db.installmentPlans).getSingle();
    expect(p.deletedAt, isNull);
  });

  test('restore bumps updatedAt so the next cloud backup uploads it', () async {
    final before = DateTime.now().subtract(const Duration(seconds: 2));
    final customer = (await repo.load()).firstWhere((i) => i.id == 'c2');
    await repo.restore(customer);
    final c2 = await (db.select(db.customers)..where((c) => c.id.equals('c2'))).getSingle();
    expect(c2.updatedAt.isAfter(before), isTrue);
  });
}
