import 'package:drift/drift.dart';

/// Base mixin for all entity tables in Kashkool.
///
/// Ensures every table contains:
/// - `id`: UUID string primary key.
/// - `shopId`: Shop UUID reference (default 'default_shop').
/// - `deviceId`: Device UUID reference (default 'local_device').
/// - `createdBy`: Creator user/device UUID reference (default 'owner').
/// - `createdAt`: Timestamp when record was created (UTC).
/// - `updatedAt`: Timestamp when record was last updated (UTC).
/// - `deletedAt`: Nullable timestamp for soft deletes (essential for Phase 2 offline sync).
mixin BaseTable on Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().withDefault(const Constant('default_shop'))();
  TextColumn get deviceId => text().withDefault(const Constant('local_device'))();
  TextColumn get createdBy => text().withDefault(const Constant('owner'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
