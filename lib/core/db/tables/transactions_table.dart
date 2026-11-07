import 'package:drift/drift.dart';
import '../base_table.dart';

enum PartyType { customer, supplier }

/// "عليه" (debt - customer owes shop / shop owes supplier)
/// "دفع" (payment - customer paid / shop paid supplier)
enum TransactionType { debt, payment }

enum PaymentMethod { cash, instapay, wallet, other }

/// Table storing all debts and payments for both customers and suppliers.
/// Financial records are immutable & append-only.
class Transactions extends Table with BaseTable {
  /// Whether this transaction is for a customer or a supplier
  TextColumn get partyType => textEnum<PartyType>()();

  /// Foreign key referencing Customer.id or Supplier.id
  TextColumn get partyId => text()();

  /// Transaction direction: debt ("عليه") or payment ("دفع")
  TextColumn get type => textEnum<TransactionType>()();

  /// Amount in integer piasters (always positive > 0)
  IntColumn get amountPiasters => integer()();

  /// Optional payment method (for payments only: cash, instapay, wallet, etc.)
  TextColumn get method => textEnum<PaymentMethod>().nullable()();

  /// Optional note explaining the transaction (e.g. "سكر وزيت", "حساب قديم")
  TextColumn get note => text().nullable()();

  /// Local path to photo receipt/item image if captured
  TextColumn get photoPath => text().nullable()();

  /// Date and time when the transaction actually took place
  DateTimeColumn get occurredAt => dateTime().withDefault(currentDateAndTime)();

  /// Reference to replacement transaction if this row was soft-edited (append-only)
  TextColumn get supersededById => text().nullable()();
}
