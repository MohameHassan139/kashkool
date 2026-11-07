import 'package:drift/drift.dart';
import '../base_table.dart';

enum InstallmentStatus { pending, partial, paid }

/// Table storing individual scheduled installments for a plan.
class Installments extends Table with BaseTable {
  /// Foreign key referencing InstallmentPlans.id
  TextColumn get planId => text()();

  /// Sequence index of the installment (1, 2, 3...)
  IntColumn get installmentIndex => integer()();

  /// Scheduled due date
  DateTimeColumn get dueDate => dateTime()();

  /// Target amount in piasters (last installment absorbs rounding remainders)
  IntColumn get amountPiasters => integer()();

  /// Total amount paid towards this installment in piasters
  IntColumn get paidPiasters => integer().withDefault(const Constant(0))();

  /// Timestamp when this installment was paid or updated
  DateTimeColumn get paidAt => dateTime().nullable()();

  /// Current status: pending, partial, paid
  TextColumn get status => textEnum<InstallmentStatus>().withDefault(Constant(InstallmentStatus.pending.name))();

  /// Optional notes (e.g. "دفع كاش مع محمد")
  TextColumn get notes => text().nullable()();
}
