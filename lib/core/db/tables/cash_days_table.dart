import 'package:drift/drift.dart';
import '../base_table.dart';

/// Represents a business day's cash drawer opening, cash sales, actual physical count, and closing.
class CashDays extends Table with BaseTable {
  /// Date representing the calendar day (normalized to midnight)
  DateTimeColumn get date => dateTime().unique()();

  /// Opening cash in integer piasters (defaults to previous closed day's actual count or 0)
  IntColumn get openingCashPiasters => integer().withDefault(const Constant(0))();

  /// Manual entry of cash sales (non-credit daily cash revenue) in integer piasters
  IntColumn get cashSalesPiasters => integer().withDefault(const Constant(0))();

  /// Actual physical money counted in the drawer at close in piasters (null when day is open)
  IntColumn get actualCountPiasters => integer().nullable()();

  /// Timestamp when the day was closed (null = day is still open)
  DateTimeColumn get closedAt => dateTime().nullable()();

  /// Optional notes regarding the day's closing (e.g. "عجز 20 جنيه بسبب فكة")
  TextColumn get notes => text().nullable()();
}
