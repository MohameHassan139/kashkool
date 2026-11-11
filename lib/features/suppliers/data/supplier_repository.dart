import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/arabic_search.dart';
import '../../../core/utils/phone.dart';
import '../../customers/data/customer_repository.dart';
import '../domain/supplier_filter_sort.dart';
import '../domain/supplier_with_balance.dart';

/// Repository handling all supplier database operations, balance calculations, and search.
class SupplierRepository {
  final AppDatabase _db;
  final CustomerRepository _customerRepo;
  final _uuid = const Uuid();

  SupplierRepository(this._db, this._customerRepo);

  /// Watches all active suppliers with their dynamically computed balance.
  ///
  /// Joins Suppliers and Transactions with partyType = PartyType.supplier.
  /// Balance is calculated on-the-fly: Σ debt (عليّا) − Σ payment (دفعتله).
  Stream<List<SupplierWithBalance>> watchSuppliersWithBalance({
    String? query,
    SupplierFilter filter = SupplierFilter.all,
    SupplierSort sort = SupplierSort.highestBalance,
  }) {
    final joinedQuery = _db.select(_db.suppliers).join([
      leftOuterJoin(
        _db.transactions,
        _db.transactions.partyId.equalsExp(_db.suppliers.id) &
            _db.transactions.partyType.equalsValue(PartyType.supplier) &
            _db.transactions.deletedAt.isNull(),
      ),
    ])..where(_db.suppliers.deletedAt.isNull());

    return joinedQuery.watch().map((rows) {
      final Map<String, Supplier> supplierMap = {};
      final Map<String, int> balanceMap = {};
      final Map<String, DateTime?> lastActivityMap = {};
      final Map<String, int> countMap = {};

      for (final row in rows) {
        final supplier = row.readTable(_db.suppliers);
        final transaction = row.readTableOrNull(_db.transactions);

        supplierMap[supplier.id] = supplier;
        balanceMap.putIfAbsent(supplier.id, () => 0);
        countMap.putIfAbsent(supplier.id, () => 0);

        if (transaction != null) {
          countMap[supplier.id] = (countMap[supplier.id] ?? 0) + 1;

          // For suppliers: Debt = I owe him (+), Payment = I paid him (-)
          if (transaction.type == TransactionType.debt) {
            balanceMap[supplier.id] = (balanceMap[supplier.id] ?? 0) + transaction.amountPiasters;
          } else {
            balanceMap[supplier.id] = (balanceMap[supplier.id] ?? 0) - transaction.amountPiasters;
          }

          final currentLast = lastActivityMap[supplier.id];
          if (currentLast == null || transaction.occurredAt.isAfter(currentLast)) {
            lastActivityMap[supplier.id] = transaction.occurredAt;
          }
        }
      }

      var list = supplierMap.values.map((supplier) {
        return SupplierWithBalance(
          supplier: supplier,
          balancePiasters: balanceMap[supplier.id] ?? 0,
          lastTransactionAt: lastActivityMap[supplier.id],
          transactionCount: countMap[supplier.id] ?? 0,
        );
      }).toList();

      // 1. Search Query filtering (Rep name, Company name, Phone)
      if (query != null && query.trim().isNotEmpty) {
        final q = query.trim();
        list = list.where((item) {
          final nameMatch = ArabicSearchUtils.matches(item.supplier.name, q);
          final companyMatch = item.supplier.company != null &&
              ArabicSearchUtils.matches(item.supplier.company!, q);
          final phoneMatch = item.supplier.phone != null && item.supplier.phone!.contains(q);
          return nameMatch || companyMatch || phoneMatch;
        }).toList();
      }

      // 2. Chip Filter (all, hasDebt, settled)
      switch (filter) {
        case SupplierFilter.all:
          break;
        case SupplierFilter.hasDebt:
          list = list.where((item) => item.balancePiasters > 0).toList();
          break;
        case SupplierFilter.settled:
          list = list.where((item) => item.balancePiasters == 0).toList();
          break;
      }

      // 3. Sorting
      switch (sort) {
        case SupplierSort.highestBalance:
          list.sort((a, b) => b.balancePiasters.compareTo(a.balancePiasters));
          break;
        case SupplierSort.name:
          list.sort((a, b) => ArabicSearchUtils.normalize(a.supplier.name)
              .compareTo(ArabicSearchUtils.normalize(b.supplier.name)));
          break;
        case SupplierSort.company:
          list.sort((a, b) {
            final aComp = a.supplier.company ?? '';
            final bComp = b.supplier.company ?? '';
            if (aComp.isEmpty && bComp.isEmpty) return 0;
            if (aComp.isEmpty) return 1;
            if (bComp.isEmpty) return -1;
            return ArabicSearchUtils.normalize(aComp)
                .compareTo(ArabicSearchUtils.normalize(bComp));
          });
          break;
        case SupplierSort.visitDay:
          list.sort((a, b) {
            final aDay = a.supplier.visitDay ?? 999;
            final bDay = b.supplier.visitDay ?? 999;
            return aDay.compareTo(bDay);
          });
          break;
      }

      return list;
    });
  }

  /// Watches the total amount the shop owes to all suppliers ("عليك للموردين").
  Stream<int> watchTotalPayables() {
    return watchSuppliersWithBalance().map((suppliers) {
      var total = 0;
      for (final s in suppliers) {
        if (s.balancePiasters > 0) {
          total += s.balancePiasters;
        }
      }
      return total;
    });
  }

  /// Watches net market position (Receivables - Payables).
  ///
  /// Positive (> 0): Net credit in market ("صافي ليك في السوق").
  /// Negative (< 0): Net deficit owed ("عليك عجز إجمالي").
  /// Zero (== 0): Balanced market position.
  Stream<int> watchNetMarketPosition() {
    return _customerRepo.watchTotalReceivables().asyncExpand((receivables) {
      return watchTotalPayables().map((payables) {
        return receivables - payables;
      });
    });
  }

  /// Watches a single supplier with their computed balance.
  Stream<SupplierWithBalance?> watchSupplierWithBalance(String supplierId) {
    return watchSuppliersWithBalance().map((suppliers) {
      final matches = suppliers.where((s) => s.supplier.id == supplierId);
      return matches.isEmpty ? null : matches.first;
    });
  }

  /// Gets a single supplier with their computed balance (single read).
  Future<SupplierWithBalance?> getSupplierWithBalance(String supplierId) async {
    final stream = watchSupplierWithBalance(supplierId);
    return await stream.first;
  }

  /// Watches full transaction history for a supplier, newest first.
  Stream<List<Transaction>> watchSupplierTransactions(String supplierId) {
    return (_db.select(_db.transactions)
          ..where((t) =>
              t.partyId.equals(supplierId) &
              t.partyType.equalsValue(PartyType.supplier) &
              t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
        .watch();
  }

  /// Adds a new supplier.
  Future<String> addSupplier({
    required String name,
    String? company,
    String? phone,
    int? visitDay,
    String? notes,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.length < 2 || trimmedName.length > 60) {
      throw ArgumentError('Supplier name must be between 2 and 60 characters');
    }

    final normalizedPhone = PhoneUtils.normalize(phone);
    final id = _uuid.v4();
    final now = DateTime.now();

    await _db.into(_db.suppliers).insert(
          SuppliersCompanion.insert(
            id: id,
            name: trimmedName,
            company: Value(company?.trim().isEmpty == true ? null : company?.trim()),
            phone: Value(normalizedPhone),
            visitDay: Value(visitDay),
            notes: Value(notes?.trim().isEmpty == true ? null : notes?.trim()),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

    return id;
  }

  /// Updates an existing supplier.
  Future<void> updateSupplier({
    required String id,
    required String name,
    String? company,
    String? phone,
    int? visitDay,
    String? notes,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.length < 2 || trimmedName.length > 60) {
      throw ArgumentError('Supplier name must be between 2 and 60 characters');
    }

    final normalizedPhone = PhoneUtils.normalize(phone);
    final now = DateTime.now();

    await (_db.update(_db.suppliers)..where((s) => s.id.equals(id))).write(
      SuppliersCompanion(
        name: Value(trimmedName),
        company: Value(company?.trim().isEmpty == true ? null : company?.trim()),
        phone: Value(normalizedPhone),
        visitDay: Value(visitDay),
        notes: Value(notes?.trim().isEmpty == true ? null : notes?.trim()),
        updatedAt: Value(now),
      ),
    );
  }

  /// Soft deletes a supplier (sets deletedAt timestamp).
  Future<void> deleteSupplier(String id) async {
    final now = DateTime.now();
    await (_db.update(_db.suppliers)..where((s) => s.id.equals(id))).write(
      SuppliersCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  /// Checks if another supplier exists with identical phone or normalized name.
  Future<Supplier?> checkForDuplicates({
    required String name,
    String? phone,
    String? excludeSupplierId,
  }) async {
    final activeSuppliers = await (_db.select(_db.suppliers)
          ..where((s) => s.deletedAt.isNull()))
        .get();

    final normalizedTargetName = ArabicSearchUtils.normalize(name);
    final normalizedTargetPhone = PhoneUtils.normalize(phone);

    for (final s in activeSuppliers) {
      if (excludeSupplierId != null && s.id == excludeSupplierId) continue;

      if (normalizedTargetPhone != null && s.phone != null && s.phone == normalizedTargetPhone) {
        return s;
      }

      if (ArabicSearchUtils.normalize(s.name) == normalizedTargetName) {
        return s;
      }
    }

    return null;
  }
}

/// Global provider for SupplierRepository
final supplierRepositoryProvider = Provider<SupplierRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final customerRepo = ref.watch(customerRepositoryProvider);
  return SupplierRepository(db, customerRepo);
});
