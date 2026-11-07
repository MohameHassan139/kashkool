import 'package:drift/drift.dart';
import '../base_table.dart';

/// Table representing distributors and suppliers in Kashkool.
class Suppliers extends Table with BaseTable {
  /// Supplier or sales rep name (e.g. "أحمد مندوب جهينة")
  TextColumn get name => text().withLength(min: 2, max: 60)();

  /// Company or agency name (e.g. "جهينة", "شيبسي", "شركة النصر")
  TextColumn get company => text().nullable()();

  /// Normalized Egyptian mobile phone (optional)
  TextColumn get phone => text().nullable()();

  /// Weekday when the sales rep usually visits (0: Sat, 1: Sun, ..., 6: Fri)
  IntColumn get visitDay => integer().nullable()();

  /// Optional notes (e.g. "بيعدي الصبح بدري", "الطلبية بتتأخر يومين")
  TextColumn get notes => text().nullable()();
}
