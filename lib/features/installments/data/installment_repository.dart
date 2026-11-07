import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/arabic_search.dart';
import '../domain/due_installment_item.dart';
import '../domain/installment_calculator.dart';
import '../domain/installment_plan_with_details.dart';

/// Repository managing Installment Plans, Schedules, and Payments.
class InstallmentRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  InstallmentRepository(this._db);

  /// Saves an image (contract, ID card, or receipt) into the permanent app storage.
  Future<String> persistPhoto(String tempPath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory('${appDir.path}/installment_photos');
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }

    final ext = tempPath.split('.').last;
    final fileName = '${_uuid.v4()}.$ext';
    final targetPath = '${photosDir.path}/$fileName';

    final tempFile = File(tempPath);
    await tempFile.copy(targetPath);
    return targetPath;
  }

  /// Creates a new installment plan, generates its schedule, and optionally links to customer ledger.
  Future<String> createPlan({
    required String customerId,
    required String itemDescription,
    required int totalPricePiasters,
    int downPaymentPiasters = 0,
    required int installmentCount,
    InstallmentFrequency frequency = InstallmentFrequency.monthly,
    required DateTime startDate,
    String? guarantorName,
    String? guarantorPhone,
    String? notes,
    String? photoPath,
    bool linkToCustomerLedger = true,
  }) async {
    if (itemDescription.trim().length < 2) {
      throw ArgumentError('وصف السلعة يجب ألا يقل عن حرفين');
    }
    if (totalPricePiasters <= 0) {
      throw ArgumentError('السعر الإجمالي يجب أن يكون أكبر من صفر');
    }
    if (downPaymentPiasters < 0) {
      throw ArgumentError('المقدم لا يمكن أن يكون بالسالب');
    }
    if (downPaymentPiasters >= totalPricePiasters) {
      throw ArgumentError('المقدم يجب أن يكون أقل من السعر الإجمالي');
    }
    if (installmentCount <= 0) {
      throw ArgumentError('عدد الأقساط يجب أن يكون أكبر من صفر');
    }

    final planId = _uuid.v4();
    final now = DateTime.now();

    // 1. Generate installment schedule
    final schedule = InstallmentCalculator.generateSchedule(
      totalPricePiasters: totalPricePiasters,
      downPaymentPiasters: downPaymentPiasters,
      count: installmentCount,
      frequency: frequency.name,
      startDate: startDate,
    );

    await _db.transaction(() async {
      // 2. Insert Plan
      await _db.into(_db.installmentPlans).insert(
            InstallmentPlansCompanion.insert(
              id: planId,
              customerId: customerId,
              itemDescription: itemDescription.trim(),
              totalPricePiasters: totalPricePiasters,
              downPaymentPiasters: Value(downPaymentPiasters),
              installmentCount: installmentCount,
              frequency: Value(frequency),
              startDate: startDate,
              guarantorName: Value(guarantorName?.trim().isEmpty == true ? null : guarantorName?.trim()),
              guarantorPhone: Value(guarantorPhone?.trim().isEmpty == true ? null : guarantorPhone?.trim()),
              notes: Value(notes?.trim().isEmpty == true ? null : notes?.trim()),
              photoPath: Value(photoPath),
              status: const Value(PlanStatus.active),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );

      // 3. Insert Installment Schedule rows
      for (final item in schedule) {
        await _db.into(_db.installments).insert(
              InstallmentsCompanion.insert(
                id: _uuid.v4(),
                planId: planId,
                installmentIndex: item.index,
                dueDate: item.dueDate,
                amountPiasters: item.amountPiasters,
                paidPiasters: const Value(0),
                status: const Value(InstallmentStatus.pending),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      }

      // 4. Optionally link to Customer's ledger transactions
      if (linkToCustomerLedger) {
        // Record total price as Debt ("عليه")
        await _db.into(_db.transactions).insert(
              TransactionsCompanion.insert(
                id: _uuid.v4(),
                partyType: PartyType.customer,
                partyId: customerId,
                type: TransactionType.debt,
                amountPiasters: totalPricePiasters,
                note: Value('قسط: ${itemDescription.trim()} ($installmentCount أقساط)'),
                occurredAt: Value(now),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );

        // Record Down Payment as Payment ("دفع")
        if (downPaymentPiasters > 0) {
          await _db.into(_db.transactions).insert(
                TransactionsCompanion.insert(
                  id: _uuid.v4(),
                  partyType: PartyType.customer,
                  partyId: customerId,
                  type: TransactionType.payment,
                  amountPiasters: downPaymentPiasters,
                  method: const Value(PaymentMethod.cash),
                  note: Value('مقدم قسط: ${itemDescription.trim()}'),
                  occurredAt: Value(now),
                  createdAt: Value(now),
                  updatedAt: Value(now),
                ),
              );
        }
      }
    });

    return planId;
  }

  /// Records payment towards a specific installment or rolls across unpaid installments sequentially.
  Future<void> recordPayment({
    required String planId,
    String? installmentId,
    required int amountPiasters,
    PaymentMethod method = PaymentMethod.cash,
    DateTime? paymentDate,
    String? notes,
    bool linkToCustomerLedger = true,
  }) async {
    if (amountPiasters <= 0) {
      throw ArgumentError('مبلغ السداد يجب أن يكون أكبر من صفر');
    }

    final now = paymentDate ?? DateTime.now();

    await _db.transaction(() async {
      final plan = await (_db.select(_db.installmentPlans)
            ..where((tbl) => tbl.id.equals(planId) & tbl.deletedAt.isNull()))
          .getSingleOrNull();

      if (plan == null) {
        throw StateError('خطة القسط غير موجودة أو تم حذفها');
      }

      // Fetch all installments for this plan ordered by index
      final allInstallments = await (_db.select(_db.installments)
            ..where((tbl) => tbl.planId.equals(planId) & tbl.deletedAt.isNull())
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.installmentIndex)]))
          .get();

      var remainingToAllocate = amountPiasters;

      // If specific installment targeted, pay it first, then roll excess over to later installments
      List<Installment> targets = [];
      if (installmentId != null) {
        final target = allInstallments.firstWhere((i) => i.id == installmentId);
        final others = allInstallments.where((i) => i.id != installmentId && i.installmentIndex > target.installmentIndex);
        targets = [target, ...others];
      } else {
        targets = allInstallments.where((i) => i.paidPiasters < i.amountPiasters).toList();
      }

      for (final inst in targets) {
        if (remainingToAllocate <= 0) break;

        final unpaidForThis = inst.amountPiasters - inst.paidPiasters;
        if (unpaidForThis <= 0) continue;

        final payThisTime = remainingToAllocate > unpaidForThis ? unpaidForThis : remainingToAllocate;
        final newPaid = inst.paidPiasters + payThisTime;
        final isFullyPaid = newPaid >= inst.amountPiasters;

        await (_db.update(_db.installments)..where((tbl) => tbl.id.equals(inst.id))).write(
          InstallmentsCompanion(
            paidPiasters: Value(newPaid),
            paidAt: Value(now),
            status: Value(isFullyPaid ? InstallmentStatus.paid : InstallmentStatus.partial),
            notes: notes != null && notes.trim().isNotEmpty ? Value(notes.trim()) : const Value.absent(),
            updatedAt: Value(now),
          ),
        );

        remainingToAllocate -= payThisTime;
      }

      // Check if all installments are completed
      final updatedInstallments = await (_db.select(_db.installments)
            ..where((tbl) => tbl.planId.equals(planId) & tbl.deletedAt.isNull()))
          .get();

      final allCompleted = updatedInstallments.every((i) => i.paidPiasters >= i.amountPiasters);
      if (allCompleted) {
        await (_db.update(_db.installmentPlans)..where((tbl) => tbl.id.equals(planId))).write(
          InstallmentPlansCompanion(
            status: const Value(PlanStatus.completed),
            updatedAt: Value(now),
          ),
        );
      }

      // Link payment to customer ledger
      if (linkToCustomerLedger) {
        await _db.into(_db.transactions).insert(
              TransactionsCompanion.insert(
                id: _uuid.v4(),
                partyType: PartyType.customer,
                partyId: plan.customerId,
                type: TransactionType.payment,
                amountPiasters: amountPiasters,
                method: Value(method),
                note: Value('سداد قسط: ${plan.itemDescription}${notes != null ? ' - $notes' : ''}'),
                occurredAt: Value(now),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      }
    });
  }

  /// Settles the entire remaining balance of a plan at once, with an optional early-settlement discount.
  Future<void> settlePlanEarly({
    required String planId,
    int discountPiasters = 0,
    PaymentMethod method = PaymentMethod.cash,
    String? notes,
    bool linkToCustomerLedger = true,
  }) async {
    final now = DateTime.now();

    await _db.transaction(() async {
      final plan = await (_db.select(_db.installmentPlans)
            ..where((tbl) => tbl.id.equals(planId) & tbl.deletedAt.isNull()))
          .getSingleOrNull();

      if (plan == null) throw StateError('خطة القسط غير موجودة');

      final allInstallments = await (_db.select(_db.installments)
            ..where((tbl) => tbl.planId.equals(planId) & tbl.deletedAt.isNull()))
          .get();

      final totalUnpaid = allInstallments.fold<int>(
        0,
        (sum, inst) => sum + (inst.amountPiasters - inst.paidPiasters).clamp(0, inst.amountPiasters),
      );

      if (totalUnpaid <= 0) return; // Already paid

      final settlement = InstallmentCalculator.calculateEarlySettlement(
        remainingPiasters: totalUnpaid,
        discountPiasters: discountPiasters,
      );

      // Mark all remaining installments as paid
      for (final inst in allInstallments) {
        if (inst.paidPiasters < inst.amountPiasters) {
          await (_db.update(_db.installments)..where((tbl) => tbl.id.equals(inst.id))).write(
            InstallmentsCompanion(
              paidPiasters: Value(inst.amountPiasters),
              paidAt: Value(now),
              status: const Value(InstallmentStatus.paid),
              updatedAt: Value(now),
            ),
          );
        }
      }

      // Mark plan as completed
      await (_db.update(_db.installmentPlans)..where((tbl) => tbl.id.equals(planId))).write(
        InstallmentPlansCompanion(
          status: const Value(PlanStatus.completed),
          updatedAt: Value(now),
        ),
      );

      // Link payment and discount to customer ledger
      if (linkToCustomerLedger) {
        // Record payment for net amount collected
        if (settlement.netSettlementAmount > 0) {
          await _db.into(_db.transactions).insert(
                TransactionsCompanion.insert(
                  id: _uuid.v4(),
                  partyType: PartyType.customer,
                  partyId: plan.customerId,
                  type: TransactionType.payment,
                  amountPiasters: settlement.netSettlementAmount,
                  method: Value(method),
                  note: Value('سداد مبكر لقسط: ${plan.itemDescription}'),
                  occurredAt: Value(now),
                  createdAt: Value(now),
                  updatedAt: Value(now),
                ),
              );
        }

        // If discount granted, also record it as payment/credit adjustment to clear customer ledger
        if (settlement.maxDiscount > 0 && discountPiasters > 0) {
          final actualDiscount = discountPiasters.clamp(0, totalUnpaid);
          if (actualDiscount > 0) {
            await _db.into(_db.transactions).insert(
                  TransactionsCompanion.insert(
                    id: _uuid.v4(),
                    partyType: PartyType.customer,
                    partyId: plan.customerId,
                    type: TransactionType.payment,
                    amountPiasters: actualDiscount,
                    method: const Value(PaymentMethod.other),
                    note: Value('خصم تعجيل سداد: ${plan.itemDescription}'),
                    occurredAt: Value(now),
                    createdAt: Value(now),
                    updatedAt: Value(now),
                  ),
                );
          }
        }
      }
    });
  }

  /// Cancels an active plan without deleting historical payments.
  Future<void> cancelPlan(String planId) async {
    final now = DateTime.now();
    await (_db.update(_db.installmentPlans)..where((tbl) => tbl.id.equals(planId))).write(
      InstallmentPlansCompanion(
        status: const Value(PlanStatus.cancelled),
        updatedAt: Value(now),
      ),
    );
  }

  /// Soft deletes an installment plan and its installments.
  Future<void> deletePlan(String planId) async {
    final now = DateTime.now();
    await _db.transaction(() async {
      await (_db.update(_db.installmentPlans)..where((tbl) => tbl.id.equals(planId))).write(
        InstallmentPlansCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      await (_db.update(_db.installments)..where((tbl) => tbl.planId.equals(planId))).write(
        InstallmentsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    });
  }

  /// Watches all installment plans joined with customer details and installment rows.
  Stream<List<InstallmentPlanWithDetails>> watchAllPlans({
    PlanStatus? statusFilter,
    String? searchQuery,
  }) {
    // Build joined query between InstallmentPlans and Customers
    final query = _db.select(_db.installmentPlans).join([
      innerJoin(
        _db.customers,
        _db.customers.id.equalsExp(_db.installmentPlans.customerId),
      ),
    ])
      ..where(_db.installmentPlans.deletedAt.isNull() & _db.customers.deletedAt.isNull());

    if (statusFilter != null) {
      query.where(_db.installmentPlans.status.equals(statusFilter.name));
    }

    query.orderBy([OrderingTerm.desc(_db.installmentPlans.createdAt)]);

    return query.watch().asyncMap((rows) async {
      final results = <InstallmentPlanWithDetails>[];

      for (final row in rows) {
        final plan = row.readTable(_db.installmentPlans);
        final customer = row.readTable(_db.customers);

        final installments = await (_db.select(_db.installments)
              ..where((tbl) => tbl.planId.equals(plan.id) & tbl.deletedAt.isNull())
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.installmentIndex)]))
            .get();

        final item = InstallmentPlanWithDetails(
          plan: plan,
          customer: customer,
          installments: installments,
        );

        if (searchQuery != null && searchQuery.trim().isNotEmpty) {
          final queryNorm = ArabicSearchUtils.normalize(searchQuery.trim());
          final nameMatch = ArabicSearchUtils.matches(customer.name, queryNorm);
          final phoneMatch = customer.phone?.contains(queryNorm) ?? false;
          final itemMatch = ArabicSearchUtils.matches(plan.itemDescription, queryNorm);
          final guarantorMatch = plan.guarantorName != null && ArabicSearchUtils.matches(plan.guarantorName!, queryNorm);

          if (!nameMatch && !phoneMatch && !itemMatch && !guarantorMatch) {
            continue;
          }
        }

        results.add(item);
      }

      return results;
    });
  }

  /// Watches installment plans for a single customer.
  Stream<List<InstallmentPlanWithDetails>> watchPlansForCustomer(String customerId) {
    final query = _db.select(_db.installmentPlans).join([
      innerJoin(
        _db.customers,
        _db.customers.id.equalsExp(_db.installmentPlans.customerId),
      ),
    ])
      ..where(
        _db.installmentPlans.customerId.equals(customerId) &
            _db.installmentPlans.deletedAt.isNull() &
            _db.customers.deletedAt.isNull(),
      )
      ..orderBy([OrderingTerm.desc(_db.installmentPlans.createdAt)]);

    return query.watch().asyncMap((rows) async {
      final results = <InstallmentPlanWithDetails>[];

      for (final row in rows) {
        final plan = row.readTable(_db.installmentPlans);
        final customer = row.readTable(_db.customers);

        final installments = await (_db.select(_db.installments)
              ..where((tbl) => tbl.planId.equals(plan.id) & tbl.deletedAt.isNull())
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.installmentIndex)]))
            .get();

        results.add(
          InstallmentPlanWithDetails(
            plan: plan,
            customer: customer,
            installments: installments,
          ),
        );
      }

      return results;
    });
  }

  /// Watches a single installment plan with full details.
  Stream<InstallmentPlanWithDetails?> watchPlanWithDetails(String planId) {
    final query = _db.select(_db.installmentPlans).join([
      innerJoin(
        _db.customers,
        _db.customers.id.equalsExp(_db.installmentPlans.customerId),
      ),
    ])..where(_db.installmentPlans.id.equals(planId) & _db.installmentPlans.deletedAt.isNull());

    return query.watchSingleOrNull().asyncMap((row) async {
      if (row == null) return null;

      final plan = row.readTable(_db.installmentPlans);
      final customer = row.readTable(_db.customers);

      final installments = await (_db.select(_db.installments)
            ..where((tbl) => tbl.planId.equals(plan.id) & tbl.deletedAt.isNull())
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.installmentIndex)]))
          .get();

      return InstallmentPlanWithDetails(
        plan: plan,
        customer: customer,
        installments: installments,
      );
    });
  }

  /// Watches all installments that are due today or overdue.
  Stream<List<DueInstallmentItem>> watchDueInstallments() {
    final query = _db.select(_db.installments).join([
      innerJoin(_db.installmentPlans, _db.installmentPlans.id.equalsExp(_db.installments.planId)),
      innerJoin(_db.customers, _db.customers.id.equalsExp(_db.installmentPlans.customerId)),
    ])..where(
        _db.installments.deletedAt.isNull() &
            _db.installmentPlans.deletedAt.isNull() &
            _db.customers.deletedAt.isNull() &
            _db.installmentPlans.status.equals(PlanStatus.active.name),
      );

    return query.watch().map((rows) {
      final now = DateTime.now();
      final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

      final list = <DueInstallmentItem>[];

      for (final row in rows) {
        final inst = row.readTable(_db.installments);
        final plan = row.readTable(_db.installmentPlans);
        final customer = row.readTable(_db.customers);

        final isUnpaid = inst.paidPiasters < inst.amountPiasters;
        final isDueOrOverdue = inst.dueDate.isBefore(todayEnd) ||
            InstallmentCalculator.isSameDay(inst.dueDate, now);

        if (isUnpaid && isDueOrOverdue) {
          list.add(
            DueInstallmentItem(
              installment: inst,
              plan: plan,
              customer: customer,
            ),
          );
        }
      }

      // Sort: Overdue first (by days overdue desc), then by dueDate asc
      list.sort((a, b) {
        if (a.isOverdue && !b.isOverdue) return -1;
        if (!a.isOverdue && b.isOverdue) return 1;
        return a.installment.dueDate.compareTo(b.installment.dueDate);
      });

      return list;
    });
  }
}

/// Riverpod provider for InstallmentRepository singleton
final installmentRepositoryProvider = Provider<InstallmentRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return InstallmentRepository(db);
});
