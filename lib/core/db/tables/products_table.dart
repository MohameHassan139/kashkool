import 'package:drift/drift.dart';
import '../base_table.dart';

class Products extends Table with BaseTable {
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get barcode => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get unitLabel => text().withLength(min: 1, max: 24)();
  IntColumn get purchasePricePiasters => integer()();
  IntColumn get salePricePiasters => integer()();
  IntColumn get minimumStockMilliUnits => integer()();
}
