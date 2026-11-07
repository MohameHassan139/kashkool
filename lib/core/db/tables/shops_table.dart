import 'package:drift/drift.dart';
import '../base_table.dart';

/// Shops table holding local and synced business profiles.
class Shops extends Table with BaseTable {
  TextColumn get name => text()();
  TextColumn get shopType => text().withDefault(const Constant('other'))(); // grocery, mobile, electronics, pharmacy, other
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get currency => text().withDefault(const Constant('EGP'))();
  BoolColumn get enableInstallments => boolean().withDefault(const Constant(false))();
}
