import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/db/app_database.dart';
import '../../../core/utils/arabic_search.dart';
import '../../../core/utils/money.dart';
import '../../../core/utils/phone.dart';
import '../../customers/data/customer_photo_repository.dart';
import '../../customers/data/customer_repository.dart';
import '../../installments/data/installment_repository.dart';
import '../../transactions/data/transaction_repository.dart';
import '../../../l10n/l10n.dart';

/// Note written on every opening balance, so it is easy to recognise later.
String get kNotebookOpeningNote => L10n.t.notebookImportService1;

/// Caption for a notebook page photo linked to every customer typed from that page.
String get kNotebookPageNote => L10n.t.notebookImportService2;

/// One typed row from the notebook, after validation.
class ImportRow {
  final String name;
  final String? phone;

  /// Always >= 0. Zero means "just add the customer, no balance".
  final int amountPiasters;

  /// true = "عليه" (customer owes the shop), false = "له" (shop owes the customer).
  final bool customerOwes;

  /// Photos for this customer only (already copied into the app folder).
  final List<String> photoPaths;

  const ImportRow({
    required this.name,
    this.phone,
    required this.amountPiasters,
    this.customerOwes = true,
    this.photoPaths = const [],
  });

  ImportRow withPhotos(List<String> paths) => ImportRow(
        name: name,
        phone: phone,
        amountPiasters: amountPiasters,
        customerOwes: customerOwes,
        photoPaths: List.unmodifiable(paths),
      );
}

/// Result of checking a typed row.
class RowCheck {
  final ImportRow? row;
  final String? error;
  const RowCheck.ok(this.row) : error = null;
  const RowCheck.error(this.error) : row = null;
  const RowCheck.empty()
      : row = null,
        error = null;
  bool get isEmpty => row == null && error == null;
}

class ImportSummary {
  final int newCustomers;
  final int existingCustomers;
  final int totalPiasters;
  const ImportSummary(this.newCustomers, this.existingCustomers, this.totalPiasters);
}

/// Moves a paper notebook ("الكشكول") into the app quickly, without AI:
/// the owner types name / phone / balance per line, and old installment plans in one form.
/// Photos of the notebook stay on the phone only. A customer can have many photos.
class NotebookImportService {
  final AppDatabase _db;
  final CustomerRepository _customers;
  final TransactionRepository _transactions;
  final InstallmentRepository _installments;
  final CustomerPhotoRepository _photos;

  NotebookImportService(this._db, this._customers, this._transactions, this._installments, [CustomerPhotoRepository? photos])
      : _photos = photos ?? CustomerPhotoRepository(_db);

  /// Validates one line. Empty lines are ignored (not errors).
  /// A line with photos but no name is an error, so the photos are not lost silently.
  static RowCheck check({
    required String name,
    required String phone,
    required String amount,
    bool customerOwes = true,
    bool hasPhotos = false,
  }) {
    final trimmedName = name.trim();
    final trimmedPhone = phone.trim();
    final trimmedAmount = amount.trim();
    if (trimmedName.isEmpty && trimmedPhone.isEmpty && trimmedAmount.isEmpty && !hasPhotos) return const RowCheck.empty();
    if (trimmedName.length < 2) return RowCheck.error(L10n.t.notebookImportService3);
    if (trimmedName.length > 60) return RowCheck.error(L10n.t.notebookImportService4);

    String? normalizedPhone;
    if (trimmedPhone.isNotEmpty) {
      normalizedPhone = PhoneUtils.normalizeEgyptianMobile(trimmedPhone);
      if (normalizedPhone == null) return RowCheck.error(L10n.t.oldInstallmentImportScreen18);
    }

    var piasters = 0;
    if (trimmedAmount.isNotEmpty) {
      piasters = MoneyUtils.toPiasters(trimmedAmount, fallback: -1);
      if (piasters < 0) return RowCheck.error(L10n.t.notebookImportService5);
    }
    return RowCheck.ok(ImportRow(
      name: trimmedName,
      phone: normalizedPhone,
      amountPiasters: piasters,
      customerOwes: customerOwes,
    ));
  }

  /// Existing (not deleted) customer with the same phone or the same name (Arabic-normalized).
  Future<Customer?> findExisting(String name, String? phone) {
    return _customers.checkForDuplicates(name: name, phone: phone);
  }

  /// Saves all rows in one database transaction. A row that matches an existing customer
  /// adds its balance to that customer instead of creating a duplicate.
  /// Two rows with the same name/phone in one batch are merged into one customer.
  ///
  /// [pagePhotos] are photos of the notebook page(s): they are linked to every customer saved
  /// in this batch. Each row can also have its own [ImportRow.photoPaths]. A customer can end
  /// up with many photos; all of them show in the customer's "الصور" screen.
  Future<ImportSummary> saveCustomers(
    List<ImportRow> rows, {
    required DateTime asOf,
    List<String> pagePhotos = const [],
  }) async {
    var created = 0, existing = 0, total = 0;
    await _db.transaction(() async {
      final idsInBatch = <String, String>{};
      for (final row in rows) {
        final key = row.phone ?? 'name:${ArabicSearchUtils.normalize(row.name)}';
        var customerId = idsInBatch[key];
        if (customerId == null) {
          final match = await findExisting(row.name, row.phone);
          if (match != null) {
            customerId = match.id;
            existing++;
          } else {
            customerId = await _customers.addCustomer(name: row.name, phone: row.phone);
            created++;
          }
          idsInBatch[key] = customerId;
          if (row.phone != null) idsInBatch['name:${ArabicSearchUtils.normalize(row.name)}'] = customerId;
        }

        await _photos.addPhotos(customerId, pagePhotos, note: kNotebookPageNote);
        await _photos.addPhotos(customerId, row.photoPaths);

        // The balance row keeps one photo as a quick reference in the ledger.
        final photoPath = row.photoPaths.isNotEmpty ? row.photoPaths.first : (pagePhotos.isEmpty ? null : pagePhotos.first);
        if (row.amountPiasters > 0) {
          await _transactions.addTransaction(
            partyType: PartyType.customer,
            partyId: customerId,
            type: row.customerOwes ? TransactionType.debt : TransactionType.payment,
            amountPiasters: row.amountPiasters,
            // "Other" keeps an old credit out of today's cash drawer.
            method: row.customerOwes ? null : PaymentMethod.other,
            note: kNotebookOpeningNote,
            photoPath: photoPath,
            occurredAt: asOf,
          );
          total += row.customerOwes ? row.amountPiasters : -row.amountPiasters;
        }
      }
    });
    return ImportSummary(created, existing, total);
  }

  /// Adds an installment plan that started before the app.
  ///
  /// [paidPiasters] is what the customer already paid (down payment + installments).
  /// The remaining amount is split into [remainingCount] installments starting at [nextDueDate].
  /// Nothing is recorded as cash collected today: the customer's balance just gains the remaining amount.
  Future<String> saveOldInstallment({
    required String customerId,
    required String itemDescription,
    required int totalPricePiasters,
    required int paidPiasters,
    required int remainingCount,
    required DateTime nextDueDate,
    InstallmentFrequency frequency = InstallmentFrequency.monthly,
    String? guarantorName,
    String? guarantorPhone,
    List<String> photoPaths = const [],
  }) async {
    final photoPath = photoPaths.isEmpty ? null : photoPaths.first;
    final remaining = totalPricePiasters - paidPiasters;
    if (paidPiasters < 0) throw ArgumentError(L10n.t.notebookImportService6);
    if (remaining <= 0) throw ArgumentError(L10n.t.notebookImportService7);
    if (remainingCount < 1) throw ArgumentError(L10n.t.notebookImportService8);

    late String planId;
    await _db.transaction(() async {
      planId = await _installments.createPlan(
        customerId: customerId,
        itemDescription: itemDescription,
        totalPricePiasters: totalPricePiasters,
        downPaymentPiasters: paidPiasters,
        installmentCount: remainingCount,
        frequency: frequency,
        startDate: nextDueDate,
        guarantorName: guarantorName,
        guarantorPhone: guarantorPhone,
        notes: L10n.t.notebookImportService9(MoneyUtils.formatMoney(paidPiasters)),
        photoPath: photoPath,
        // Don't post the full price + a "down payment" collected today (that would show up in
        // today's cash drawer). Post only the remaining amount below.
        linkToCustomerLedger: false,
      );
      await _transactions.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: remaining,
        note: L10n.t.notebookImportService10(itemDescription.trim(), MoneyUtils.formatMoney(totalPricePiasters)),
        photoPath: photoPath,
      );
      await _photos.addPhotos(customerId, photoPaths, note: L10n.t.notebookImportService11(itemDescription.trim()));
    });
    return planId;
  }

  /// Installment amount preview (the last installment absorbs any remainder).
  static int perInstallment(int remainingPiasters, int count) => count < 1 ? 0 : remainingPiasters ~/ count;
}

final notebookImportServiceProvider = Provider<NotebookImportService>((ref) {
  return NotebookImportService(
    ref.watch(databaseProvider),
    ref.watch(customerRepositoryProvider),
    ref.watch(transactionRepositoryProvider),
    ref.watch(installmentRepositoryProvider),
    ref.watch(customerPhotoRepositoryProvider),
  );
});
