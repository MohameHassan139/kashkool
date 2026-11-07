import 'package:drift/drift.dart';
import '../base_table.dart';

/// Table representing customers in Kashkool.
class Customers extends Table with BaseTable {
  /// Customer full name (required, between 2 and 60 characters)
  TextColumn get name => text().withLength(min: 2, max: 60)();

  /// Normalized Egyptian mobile phone (optional, e.g. "01012345678")
  TextColumn get phone => text().nullable()();

  /// Optional notes (e.g. "جار الدور التاني", "شغال في الورشة")
  TextColumn get notes => text().nullable()();

  /// Optional credit limit in piasters (null means no limit)
  IntColumn get creditLimitPiasters => integer().nullable()();

  /// Timestamp of the last collection reminder sent to this customer
  DateTimeColumn get lastReminderAt => dateTime().nullable()();

  /// Timestamp until which collection reminders are snoozed
  DateTimeColumn get snoozedUntil => dateTime().nullable()();
}
