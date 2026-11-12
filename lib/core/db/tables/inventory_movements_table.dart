import 'package:drift/drift.dart';
import '../base_table.dart';

enum InventoryMovementType {
  opening,
  adjustment,
  purchase,
  sale,
  customerReturn,
  supplierReturn,
}

class InventoryMovements extends Table with BaseTable {
  TextColumn get productId => text()();
  IntColumn get quantityDeltaMilliUnits => integer()();
  IntColumn get unitCostPiasters => integer().nullable()();
  TextColumn get type => textEnum<InventoryMovementType>()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get occurredAt => dateTime().withDefault(currentDateAndTime)();
}
