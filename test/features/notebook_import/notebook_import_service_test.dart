import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/installments/data/installment_repository.dart';
import 'package:kashkool/features/notebook_import/data/notebook_import_service.dart';
import 'package:kashkool/features/transactions/data/transaction_repository.dart';

void main() {
  late AppDatabase db;
  late CustomerRepository customers;
  late NotebookImportService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    customers = CustomerRepository(db);
    service = NotebookImportService(db, customers, TransactionRepository(db), InstallmentRepository(db));
  });

  tearDown(() => db.close());

  group('check()', () {
    test('accepts Arabic digits and Egyptian phones', () {
      final r = NotebookImportService.check(name: ' أحمد محمد ', phone: '٠١٠١٢٣٤٥٦٧٨', amount: '١٬٢٥٠');
      expect(r.error, isNull);
      expect(r.row!.name, 'أحمد محمد');
      expect(r.row!.phone, '01012345678');
      expect(r.row!.amountPiasters, 125000);
    });

    test('empty lines are ignored, bad lines explain why', () {
      expect(NotebookImportService.check(name: '', phone: '', amount: '').isEmpty, isTrue);
      expect(NotebookImportService.check(name: 'ا', phone: '', amount: '5').error, 'الاسم ناقص');
      expect(NotebookImportService.check(name: 'أحمد', phone: '123', amount: '5').error, 'رقم الموبايل غلط');
      expect(NotebookImportService.check(name: 'أحمد', phone: '', amount: 'abc').error, 'المبلغ غلط');
      expect(NotebookImportService.check(name: 'أحمد', phone: '', amount: '-5').error, 'المبلغ غلط');
      expect(NotebookImportService.check(name: 'أحمد', phone: '', amount: '').row!.amountPiasters, 0);
    });
  });

  test('saves new customers with an opening balance on the chosen date, with the page photo', () async {
    final asOf = DateTime(2026, 10, 31);
    final summary = await service.saveCustomers(
      [
        const ImportRow(
          name: 'أحمد محمد',
          phone: '01012345678',
          amountPiasters: 150000,
          photoPaths: ['/local/ahmed1.jpg', '/local/ahmed2.jpg'],
        ),
        const ImportRow(name: 'محمود علي', amountPiasters: 0),
        const ImportRow(name: 'سيد', amountPiasters: 20000, customerOwes: false),
      ],
      asOf: asOf,
      pagePhotos: ['/local/page1.jpg', '/local/page1-back.jpg'],
    );
    expect(summary.newCustomers, 3);
    expect(summary.totalPiasters, 150000 - 20000);

    final all = await db.select(db.customers).get();
    expect(all.map((c) => c.name), containsAll(['أحمد محمد', 'محمود علي', 'سيد']));

    final txs = await db.select(db.transactions).get();
    expect(txs, hasLength(2), reason: 'no transaction for a zero balance');
    final debt = txs.firstWhere((t) => t.type == TransactionType.debt);
    expect(debt.amountPiasters, 150000);
    expect(debt.note, kNotebookOpeningNote);
    expect(debt.photoPath, '/local/ahmed1.jpg', reason: 'the row\'s own photo comes first');
    final credit0 = txs.firstWhere((t) => t.type == TransactionType.payment);
    expect(credit0.photoPath, '/local/page1.jpg', reason: 'no own photo → first page photo');

    // Many photos per customer: both page photos for everyone + Ahmed's own two.
    final ahmed = all.firstWhere((c) => c.name == 'أحمد محمد');
    final ahmedPhotos = await (db.select(db.customerPhotos)..where((p) => p.customerId.equals(ahmed.id))).get();
    expect(ahmedPhotos.map((p) => p.filePath),
        unorderedEquals(['/local/page1.jpg', '/local/page1-back.jpg', '/local/ahmed1.jpg', '/local/ahmed2.jpg']));
    expect(ahmedPhotos.where((p) => p.note == kNotebookPageNote), hasLength(2));
    final mahmoud = all.firstWhere((c) => c.name == 'محمود علي');
    final mahmoudPhotos = await (db.select(db.customerPhotos)..where((p) => p.customerId.equals(mahmoud.id))).get();
    expect(mahmoudPhotos.map((p) => p.filePath), unorderedEquals(['/local/page1.jpg', '/local/page1-back.jpg']));
    expect(debt.occurredAt, asOf);
    final credit = txs.firstWhere((t) => t.type == TransactionType.payment);
    expect(credit.method, PaymentMethod.other, reason: 'old credit must not appear in today\'s cash drawer');
  });

  test('adds to an existing customer instead of creating a duplicate, and merges repeats in one page', () async {
    final existingId = await customers.addCustomer(name: 'أحمد محمد');
    final summary = await service.saveCustomers(
      [
        const ImportRow(name: 'احمد محمد', amountPiasters: 10000), // same name, different alef
        const ImportRow(name: 'كريم', phone: '01112223334', amountPiasters: 5000),
        const ImportRow(name: 'كريم', phone: '01112223334', amountPiasters: 7000),
      ],
      asOf: DateTime(2026, 11, 1),
    );
    expect(summary.existingCustomers, 1);
    expect(summary.newCustomers, 1);
    expect(await db.select(db.customers).get(), hasLength(2));

    final ahmedTx = await (db.select(db.transactions)..where((t) => t.partyId.equals(existingId))).get();
    expect(ahmedTx.single.amountPiasters, 10000);
    final karim = (await db.select(db.customers).get()).firstWhere((c) => c.name == 'كريم');
    final karimTx = await (db.select(db.transactions)..where((t) => t.partyId.equals(karim.id))).get();
    expect(karimTx.map((t) => t.amountPiasters), unorderedEquals([5000, 7000]));
  });

  test('a repeated customer in one page gets each page photo once, plus all its own photos', () async {
    await service.saveCustomers(
      [
        const ImportRow(name: 'كريم', amountPiasters: 5000, photoPaths: ['/a.jpg']),
        const ImportRow(name: 'كريم', amountPiasters: 7000, photoPaths: ['/b.jpg', '/a.jpg']),
      ],
      asOf: DateTime(2026, 11, 1),
      pagePhotos: ['/page.jpg'],
    );
    final photos = await db.select(db.customerPhotos).get();
    expect(photos.map((p) => p.filePath), unorderedEquals(['/page.jpg', '/a.jpg', '/b.jpg']));
  });

  test('a line with photos but no name is an error (photos are not dropped silently)', () {
    expect(NotebookImportService.check(name: '', phone: '', amount: '', hasPhotos: true).error, 'الاسم ناقص');
  });

  test('old installment: schedule covers only the remaining amount; nothing counted as cash today', () async {
    final customerId = await customers.addCustomer(name: 'حسن');
    final planId = await service.saveOldInstallment(
      customerId: customerId,
      itemDescription: 'تلاجة توشيبا',
      totalPricePiasters: 1200000,
      paidPiasters: 450000,
      remainingCount: 5,
      nextDueDate: DateTime(2026, 12, 1),
      photoPaths: ['/contract.jpg', '/notebook.jpg'],
    );

    final photos = await (db.select(db.customerPhotos)..where((p) => p.customerId.equals(customerId))).get();
    expect(photos.map((p) => p.filePath), unorderedEquals(['/contract.jpg', '/notebook.jpg']));

    final plan = await (db.select(db.installmentPlans)..where((p) => p.id.equals(planId))).getSingle();
    expect(plan.totalPricePiasters, 1200000);
    expect(plan.downPaymentPiasters, 450000);
    expect(plan.installmentCount, 5);

    final rows = await (db.select(db.installments)..where((i) => i.planId.equals(planId))).get();
    expect(rows, hasLength(5));
    expect(rows.fold<int>(0, (s, r) => s + r.amountPiasters), 750000);
    rows.sort((a, b) => a.installmentIndex.compareTo(b.installmentIndex));
    expect(rows.first.dueDate, DateTime(2026, 12, 1));

    final txs = await (db.select(db.transactions)..where((t) => t.partyId.equals(customerId))).get();
    expect(txs, hasLength(1), reason: 'only the remaining debt; no "payment" today');
    expect(txs.single.type, TransactionType.debt);
    expect(txs.single.amountPiasters, 750000);
  });

  test('old installment validation', () async {
    final customerId = await customers.addCustomer(name: 'حسن');
    expect(
      () => service.saveOldInstallment(
        customerId: customerId,
        itemDescription: 'شاشة',
        totalPricePiasters: 100000,
        paidPiasters: 100000,
        remainingCount: 2,
        nextDueDate: DateTime(2026, 12, 1),
      ),
      throwsArgumentError,
    );
    expect(NotebookImportService.perInstallment(750000, 4), 187500);
  });
}
