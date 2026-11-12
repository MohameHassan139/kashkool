import 'package:drift/drift.dart';
import '../base_table.dart';

enum PurchasePaymentType { cash, credit }

class PurchaseInvoices extends Table with BaseTable {
  TextColumn get supplierId => text()();
  TextColumn get invoiceNumber => text().nullable()();
  TextColumn get paymentType => textEnum<PurchasePaymentType>()();
  IntColumn get totalPiasters => integer()();
  DateTimeColumn get occurredAt => dateTime().withDefault(currentDateAndTime)();
}
