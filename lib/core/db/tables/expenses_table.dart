import 'package:drift/drift.dart';
import '../base_table.dart';
import 'transactions_table.dart';

enum ExpenseCategory {
  rent,
  electricity,
  salary,
  supplies,
  supplierPayment,
  other,
}

/// Represents a general shop expense (rent, electricity, salaries, supplies, etc.)
class Expenses extends Table with BaseTable {
  /// Date when expense occurred
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();

  /// Expense category
  TextColumn get category => textEnum<ExpenseCategory>()();

  /// Expense amount in integer piasters
  IntColumn get amountPiasters => integer()();

  /// Payment method: cash, instapay, wallet
  TextColumn get method => textEnum<PaymentMethod>().withDefault(const Constant('cash'))();

  /// Optional notes (e.g. "فاتورة كهرباء", "يومية العامل")
  TextColumn get note => text().nullable()();
}
