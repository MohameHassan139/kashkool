import 'package:drift/drift.dart';
import '../base_table.dart';

class SupplierReturns extends Table with BaseTable {
  TextColumn get supplierId => text()();
  TextColumn get purchaseId => text()();
  IntColumn get totalPiasters => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get occurredAt => dateTime().withDefault(currentDateAndTime)();
}
