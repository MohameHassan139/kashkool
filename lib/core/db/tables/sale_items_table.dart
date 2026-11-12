import 'package:drift/drift.dart';
import '../base_table.dart';

class SaleItems extends Table with BaseTable {
  TextColumn get saleId => text()();
  TextColumn get productId => text()();
  TextColumn get productName => text()();
  TextColumn get unitLabel => text()();
  IntColumn get quantityMilliUnits => integer()();
  IntColumn get unitPricePiasters => integer()();
  IntColumn get unitCostPiasters => integer()();
  IntColumn get lineTotalPiasters => integer()();
}
