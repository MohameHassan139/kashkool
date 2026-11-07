import 'package:drift/drift.dart';

/// Base mixin for all entity tables in Kashkool.
///
/// Ensures every table contains:
/// - `id`: UUID string primary key.
/// - `createdAt`: Timestamp when record was created.
/// - `updatedAt`: Timestamp when record was last updated.
/// - `deletedAt`: Nullable timestamp for soft deletes (essential for Phase 2 offline sync).
mixin BaseTable on Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
