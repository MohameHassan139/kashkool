import 'package:drift/drift.dart';
import '../base_table.dart';

enum SalePaymentType { cash, credit }

class Sales extends Table with BaseTable {
  TextColumn get customerId => text().nullable()();
  TextColumn get paymentType => textEnum<SalePaymentType>()();
  IntColumn get totalPiasters => integer()();
  DateTimeColumn get occurredAt => dateTime().withDefault(currentDateAndTime)();
}
