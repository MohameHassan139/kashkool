import 'package:drift/drift.dart';
import '../base_table.dart';

/// Photos kept for a customer (pages from the paper notebook, contracts, receipts…).
///
/// A customer can have many photos. The files stay on this phone only (not uploaded in
/// this version). Removing a photo only sets `deletedAt`, so it can be restored.
class CustomerPhotos extends Table with BaseTable {
  /// Foreign key referencing Customers.id
  TextColumn get customerId => text()();

  /// Local path of the image file (inside the app's documents folder)
  TextColumn get filePath => text()();

  /// Optional caption (e.g. "صفحة من الكشكول", "قسط: تلاجة")
  TextColumn get note => text().nullable()();
}
