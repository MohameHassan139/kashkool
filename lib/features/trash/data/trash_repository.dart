import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';

enum TrashKind { customer, supplier, transaction, expense, installmentPlan }

/// Something that was deleted. Nothing in Kashkool is erased: deleting only hides a row
/// (`deletedAt`), and it can be brought back from here.
class TrashItem {
  final TrashKind kind;
  final String id;
  final String title;
  final String? subtitle;
  final int? amountPiasters;
  final DateTime deletedAt;

  const TrashItem({
    required this.kind,
    required this.id,
    required this.title,
    this.subtitle,
    this.amountPiasters,
    required this.deletedAt,
  });
}

class TrashRepository {
  final AppDatabase _db;
  TrashRepository(this._db);

  static const _expenseLabels = {
    ExpenseCategory.rent: 'إيجار',
    ExpenseCategory.electricity: 'كهربا',
    ExpenseCategory.salary: 'مرتبات',
    ExpenseCategory.supplies: 'مستلزمات',
    ExpenseCategory.supplierPayment: 'دفع لمورد',
    ExpenseCategory.other: 'مصروف',
  };

  /// Everything currently in the trash, newest first.
  /// Old versions replaced by an edit (`supersededById`) are history, not trash, so they are not listed.
  Future<List<TrashItem>> load({int limit = 500}) async {
    final customers = await _db.select(_db.customers).get();
    final suppliers = await _db.select(_db.suppliers).get();
    final customerNames = {for (final c in customers) c.id: c.name};
    final supplierNames = {for (final s in suppliers) s.id: s.name};

    final items = <TrashItem>[
      for (final c in customers.where((c) => c.deletedAt != null))
        TrashItem(kind: TrashKind.customer, id: c.id, title: c.name, subtitle: c.phone, deletedAt: c.deletedAt!),
      for (final s in suppliers.where((s) => s.deletedAt != null))
        TrashItem(kind: TrashKind.supplier, id: s.id, title: s.name, subtitle: s.company, deletedAt: s.deletedAt!),
    ];

    final txs = await (_db.select(_db.transactions)
          ..where((t) => t.deletedAt.isNotNull() & t.supersededById.isNull()))
        .get();
    for (final t in txs) {
      final party = t.partyType == PartyType.customer ? customerNames[t.partyId] : supplierNames[t.partyId];
      final isCustomer = t.partyType == PartyType.customer;
      final label = switch (t.type) {
        TransactionType.debt => isCustomer ? 'عليه' : 'عليّا',
        TransactionType.payment => isCustomer ? 'دفع' : 'دفعتله',
      };
      items.add(TrashItem(
        kind: TrashKind.transaction,
        id: t.id,
        title: '$label — ${party ?? 'غير معروف'}',
        subtitle: t.note,
        amountPiasters: t.amountPiasters,
        deletedAt: t.deletedAt!,
      ));
    }

    final expenses = await (_db.select(_db.expenses)..where((e) => e.deletedAt.isNotNull())).get();
    for (final e in expenses) {
      items.add(TrashItem(
        kind: TrashKind.expense,
        id: e.id,
        title: _expenseLabels[e.category] ?? 'مصروف',
        subtitle: e.note,
        amountPiasters: e.amountPiasters,
        deletedAt: e.deletedAt!,
      ));
    }

    final plans = await (_db.select(_db.installmentPlans)..where((p) => p.deletedAt.isNotNull())).get();
    for (final p in plans) {
      items.add(TrashItem(
        kind: TrashKind.installmentPlan,
        id: p.id,
        title: 'تقسيط: ${p.itemDescription}',
        subtitle: customerNames[p.customerId],
        amountPiasters: p.totalPricePiasters,
        deletedAt: p.deletedAt!,
      ));
    }

    items.sort((a, b) => b.deletedAt.compareTo(a.deletedAt));
    return items.take(limit).toList();
  }

  /// Brings an item back. Restoring a transaction or installment plan also restores
  /// its customer/supplier if they were deleted too, so it shows up again.
  Future<void> restore(TrashItem item) async {
    final now = DateTime.now();
    await _db.transaction(() async {
      switch (item.kind) {
        case TrashKind.customer:
          await _restoreCustomer(item.id, now);
        case TrashKind.supplier:
          await _restoreSupplier(item.id, now);
        case TrashKind.transaction:
          await (_db.update(_db.transactions)..where((t) => t.id.equals(item.id)))
              .write(TransactionsCompanion(deletedAt: const Value(null), updatedAt: Value(now)));
          final tx = await (_db.select(_db.transactions)..where((t) => t.id.equals(item.id))).getSingleOrNull();
          if (tx != null) {
            if (tx.partyType == PartyType.customer) {
              await _restoreCustomer(tx.partyId, now);
            } else {
              await _restoreSupplier(tx.partyId, now);
            }
          }
        case TrashKind.expense:
          await (_db.update(_db.expenses)..where((e) => e.id.equals(item.id)))
              .write(ExpensesCompanion(deletedAt: const Value(null), updatedAt: Value(now)));
        case TrashKind.installmentPlan:
          await (_db.update(_db.installmentPlans)..where((p) => p.id.equals(item.id)))
              .write(InstallmentPlansCompanion(deletedAt: const Value(null), updatedAt: Value(now)));
          await (_db.update(_db.installments)..where((i) => i.planId.equals(item.id) & i.deletedAt.isNotNull()))
              .write(InstallmentsCompanion(deletedAt: const Value(null), updatedAt: Value(now)));
          final plan = await (_db.select(_db.installmentPlans)..where((p) => p.id.equals(item.id))).getSingleOrNull();
          if (plan != null) await _restoreCustomer(plan.customerId, now);
      }
    });
  }

  Future<void> _restoreCustomer(String id, DateTime now) async {
    await (_db.update(_db.customers)..where((c) => c.id.equals(id) & c.deletedAt.isNotNull()))
        .write(CustomersCompanion(deletedAt: const Value(null), updatedAt: Value(now)));
  }

  Future<void> _restoreSupplier(String id, DateTime now) async {
    await (_db.update(_db.suppliers)..where((s) => s.id.equals(id) & s.deletedAt.isNotNull()))
        .write(SuppliersCompanion(deletedAt: const Value(null), updatedAt: Value(now)));
  }
}

final trashRepositoryProvider = Provider<TrashRepository>((ref) => TrashRepository(ref.watch(databaseProvider)));

/// Trash contents; refreshes automatically when the database changes.
final trashItemsProvider = StreamProvider.autoDispose<List<TrashItem>>((ref) async* {
  final db = ref.watch(databaseProvider);
  final repo = ref.watch(trashRepositoryProvider);
  yield await repo.load();
  await for (final _ in db.tableUpdates()) {
    yield await repo.load();
  }
});
