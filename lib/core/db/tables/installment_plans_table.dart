import 'package:drift/drift.dart';
import '../base_table.dart';

enum InstallmentFrequency { monthly, weekly }
enum PlanStatus { active, completed, cancelled }

/// Table storing installment plans for customers.
class InstallmentPlans extends Table with BaseTable {
  /// Customer ID who took the installment plan
  TextColumn get customerId => text()();

  /// Description of the item or merchandise (e.g. "سامسونج A15 128GB")
  TextColumn get itemDescription => text()();

  /// Total price in piasters (including markup / interest)
  IntColumn get totalPricePiasters => integer()();

  /// Down payment (المقدم) in piasters
  IntColumn get downPaymentPiasters => integer().withDefault(const Constant(0))();

  /// Total number of installments (e.g. 6, 10, 12, 24)
  IntColumn get installmentCount => integer()();

  /// Repayment frequency: monthly or weekly
  TextColumn get frequency => textEnum<InstallmentFrequency>().withDefault(Constant(InstallmentFrequency.monthly.name))();

  /// First due date
  DateTimeColumn get startDate => dateTime()();

  /// Guarantor's name (الضامن)
  TextColumn get guarantorName => text().nullable()();

  /// Guarantor's phone number
  TextColumn get guarantorPhone => text().nullable()();

  /// Additional notes
  TextColumn get notes => text().nullable()();

  /// Path to contract photo or national ID photo
  TextColumn get photoPath => text().nullable()();

  /// Current plan status: active, completed, cancelled
  TextColumn get status => textEnum<PlanStatus>().withDefault(Constant(PlanStatus.active.name))();
}
