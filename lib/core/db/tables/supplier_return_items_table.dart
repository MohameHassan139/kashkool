import 'package:drift/drift.dart';
import '../base_table.dart';

class SupplierReturnItems extends Table with BaseTable {
  TextColumn get supplierReturnId => text()();
  TextColumn get purchaseItemId => text()();
  TextColumn get productId => text()();
  TextColumn get productName => text()();
  TextColumn get unitLabel => text()();
  IntColumn get quantityMilliUnits => integer()();
  IntColumn get unitCostPiasters => integer()();
  IntColumn get lineTotalPiasters => integer()();
}
