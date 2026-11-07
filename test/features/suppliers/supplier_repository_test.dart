import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/suppliers/data/supplier_repository.dart';
import 'package:kashkool/features/suppliers/domain/supplier_filter_sort.dart';
import 'package:kashkool/features/transactions/data/transaction_repository.dart';

void main() {
  late AppDatabase db;
  late CustomerRepository customerRepo;
  late SupplierRepository supplierRepo;
  late TransactionRepository txRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    customerRepo = CustomerRepository(db);
    supplierRepo = SupplierRepository(db, customerRepo);
    txRepo = TransactionRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SupplierRepository CRUD operations', () {
    test('creates supplier with normalized phone and company details', () async {
      final id = await supplierRepo.addSupplier(
        name: 'عماد مندوب جهينة',
        company: 'شركة جهينة',
        phone: '+20 10 9988 7766',
        visitDay: 3, // الثلاثاء
        notes: 'بيعدي الساعة 10 الصبح',
      );

      final item = await supplierRepo.getSupplierWithBalance(id);
      expect(item, isNotNull);
      expect(item!.supplier.name, equals('عماد مندوب جهينة'));
      expect(item.supplier.company, equals('شركة جهينة'));
      expect(item.supplier.phone, equals('01099887766'));
      expect(item.supplier.visitDay, equals(3));
      expect(item.supplier.notes, equals('بيعدي الساعة 10 الصبح'));
      expect(item.balancePiasters, equals(0));
      expect(item.isSettled, isTrue);
    });

    test('rejects supplier with name less than 2 characters', () async {
      expect(
        () => supplierRepo.addSupplier(name: 'ع'),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => supplierRepo.addSupplier(name: '   '),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('updates supplier details correctly', () async {
      final id = await supplierRepo.addSupplier(
        name: 'سامح',
        company: 'شيبسي',
        phone: '01112223334',
        visitDay: 1,
      );

      await supplierRepo.updateSupplier(
        id: id,
        name: 'سامح عبد الله',
        company: 'شركة شيبسي للصناعات الغذائية',
        phone: '01223334445',
        visitDay: 4,
        notes: 'تعديل موعد الزيارة للأربعاء',
      );

      final updated = await supplierRepo.getSupplierWithBalance(id);
      expect(updated!.supplier.name, equals('سامح عبد الله'));
      expect(updated.supplier.company, equals('شركة شيبسي للصناعات الغذائية'));
      expect(updated.supplier.phone, equals('01223334445'));
      expect(updated.supplier.visitDay, equals(4));
      expect(updated.supplier.notes, equals('تعديل موعد الزيارة للأربعاء'));
    });

    test('soft deletes supplier and hides from list query', () async {
      final id = await supplierRepo.addSupplier(name: 'مورد تجريبي');

      final listBefore = await supplierRepo.watchSuppliersWithBalance().first;
      expect(listBefore.length, equals(1));

      await supplierRepo.deleteSupplier(id);

      final listAfter = await supplierRepo.watchSuppliersWithBalance().first;
      expect(listAfter.isEmpty, isTrue);

      final item = await supplierRepo.getSupplierWithBalance(id);
      expect(item, isNull);
    });
  });

  group('Supplier balance calculation and transaction handling', () {
    test('computes balance dynamically (debt increases what I owe, payment decreases it)', () async {
      final supplierId = await supplierRepo.addSupplier(name: 'مندوب كوكاكولا');

      // 1. Bought credit goods: debt = 5,000 EGP (500,000 piasters)
      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: supplierId,
        type: TransactionType.debt,
        amountPiasters: 500000,
        note: 'بضاعة كانز كوكاكولا وشويبس',
      );

      var item = await supplierRepo.getSupplierWithBalance(supplierId);
      expect(item!.balancePiasters, equals(500000));
      expect(item.hasDebt, isTrue);
      expect(item.isSettled, isFalse);

      // 2. Paid him: payment = 2,000 EGP (200,000 piasters)
      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: supplierId,
        type: TransactionType.payment,
        amountPiasters: 200000,
        note: 'دفعة نقدية من الدرج',
      );

      item = await supplierRepo.getSupplierWithBalance(supplierId);
      expect(item!.balancePiasters, equals(300000)); // 5,000 - 2,000 = 3,000 EGP

      // 3. Paid rest: payment = 3,000 EGP (300,000 piasters)
      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: supplierId,
        type: TransactionType.payment,
        amountPiasters: 300000,
      );

      item = await supplierRepo.getSupplierWithBalance(supplierId);
      expect(item!.balancePiasters, equals(0));
      expect(item.isSettled, isTrue);
      expect(item.transactionCount, equals(3));
    });

    test('handles supplier overpayment resulting in negative balance (credit for the shop)', () async {
      final supplierId = await supplierRepo.addSupplier(name: 'مندوب المراعي');

      // Debt = 1,000 EGP (100,000 piasters)
      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: supplierId,
        type: TransactionType.debt,
        amountPiasters: 100000,
      );

      // Overpayment: 1,500 EGP (150,000 piasters)
      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: supplierId,
        type: TransactionType.payment,
        amountPiasters: 150000,
      );

      final item = await supplierRepo.getSupplierWithBalance(supplierId);
      expect(item!.balancePiasters, equals(-50000));
      expect(item.hasCredit, isTrue);
    });
  });

  group('Isolation Guarantee: Customers and Suppliers never mix', () {
    test('customer transactions do not affect supplier balance, and vice versa', () async {
      final customerId = await customerRepo.addCustomer(name: 'زبون تجريبي');
      final supplierId = await supplierRepo.addSupplier(name: 'مورد تجريبي');

      // Customer takes 400 EGP debt
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 40000,
      );

      // Supplier delivers 700 EGP debt
      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: supplierId,
        type: TransactionType.debt,
        amountPiasters: 70000,
      );

      final customer = await customerRepo.getCustomerWithBalance(customerId);
      final supplier = await supplierRepo.getSupplierWithBalance(supplierId);

      expect(customer!.balancePiasters, equals(40000));
      expect(supplier!.balancePiasters, equals(70000));

      final customerTransactions = await customerRepo.watchCustomerTransactions(customerId).first;
      final supplierTransactions = await supplierRepo.watchSupplierTransactions(supplierId).first;

      expect(customerTransactions.length, equals(1));
      expect(customerTransactions.first.partyType, equals(PartyType.customer));

      expect(supplierTransactions.length, equals(1));
      expect(supplierTransactions.first.partyType, equals(PartyType.supplier));
    });
  });

  group('Total Payables and Net Market Position', () {
    test('calculates total payables and net market position accurately', () async {
      // Customer 1 owes 6,000 EGP
      final c1 = await customerRepo.addCustomer(name: 'أحمد زبون');
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: c1,
        type: TransactionType.debt,
        amountPiasters: 600000,
      );

      // Supplier 1: we owe 2,500 EGP
      final s1 = await supplierRepo.addSupplier(name: 'مندوب 1');
      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: s1,
        type: TransactionType.debt,
        amountPiasters: 250000,
      );

      // Supplier 2: we owe 1,500 EGP
      final s2 = await supplierRepo.addSupplier(name: 'مندوب 2');
      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: s2,
        type: TransactionType.debt,
        amountPiasters: 150000,
      );

      // Total payables = 2,500 + 1,500 = 4,000 EGP (400,000 piasters)
      final payables = await supplierRepo.watchTotalPayables().first;
      expect(payables, equals(400000));

      // Total receivables = 6,000 EGP (600,000 piasters)
      final receivables = await customerRepo.watchTotalReceivables().first;
      expect(receivables, equals(600000));

      // Net market position = 6,000 - 4,000 = +2,000 EGP (200,000 piasters)
      final net = await supplierRepo.watchNetMarketPosition().first;
      expect(net, equals(200000));
    });
  });

  group('Supplier Search, Filter, and Sorting', () {
    test('searches by rep name, company, and phone with Arabic normalization', () async {
      await supplierRepo.addSupplier(
        name: 'إبراهيم مندوب جهينة',
        company: 'شركة جهينة للألبان',
        phone: '01011112222',
      );
      await supplierRepo.addSupplier(
        name: 'محمود الصعيدي',
        company: 'شركة بيبسي',
        phone: '01122223333',
      );

      // Search normalized rep name ('ابراهيم' matches 'إبراهيم')
      final res1 = await supplierRepo.watchSuppliersWithBalance(query: 'ابراهيم').first;
      expect(res1.length, equals(1));
      expect(res1.first.supplier.name, equals('إبراهيم مندوب جهينة'));

      // Search company ('جهينه' matches 'جهينة')
      final res2 = await supplierRepo.watchSuppliersWithBalance(query: 'جهينه').first;
      expect(res2.length, equals(1));
      expect(res2.first.supplier.company, equals('شركة جهينة للألبان'));

      // Search phone
      final res3 = await supplierRepo.watchSuppliersWithBalance(query: '0112222').first;
      expect(res3.length, equals(1));
      expect(res3.first.supplier.name, equals('محمود الصعيدي'));
    });

    test('filters by hasDebt and settled', () async {
      final s1 = await supplierRepo.addSupplier(name: 'مورد 1');
      await supplierRepo.addSupplier(name: 'مورد 2'); // settled (0)

      await txRepo.addTransaction(
        partyType: PartyType.supplier,
        partyId: s1,
        type: TransactionType.debt,
        amountPiasters: 10000,
      );

      final hasDebtList =
          await supplierRepo.watchSuppliersWithBalance(filter: SupplierFilter.hasDebt).first;
      expect(hasDebtList.length, equals(1));
      expect(hasDebtList.first.supplier.id, equals(s1));

      final settledList =
          await supplierRepo.watchSuppliersWithBalance(filter: SupplierFilter.settled).first;
      expect(settledList.length, equals(1));
      expect(settledList.first.supplier.name, equals('مورد 2'));
    });

    test('sorts by visitDay and company', () async {
      await supplierRepo.addSupplier(name: 'أحمد', company: 'جهينة', visitDay: 4); // الأربعاء
      await supplierRepo.addSupplier(name: 'سامح', company: 'الأهرام', visitDay: 1); // الأحد
      await supplierRepo.addSupplier(name: 'محمود', company: 'بيبسيكو', visitDay: 0); // السبت

      // Sort by visit day
      final byVisit =
          await supplierRepo.watchSuppliersWithBalance(sort: SupplierSort.visitDay).first;
      expect(byVisit[0].supplier.name, equals('محمود')); // 0
      expect(byVisit[1].supplier.name, equals('سامح')); // 1
      expect(byVisit[2].supplier.name, equals('أحمد')); // 4

      // Sort by company
      final byCompany =
          await supplierRepo.watchSuppliersWithBalance(sort: SupplierSort.company).first;
      expect(byCompany[0].supplier.company, equals('الأهرام'));
      expect(byCompany[1].supplier.company, equals('بيبسيكو'));
      expect(byCompany[2].supplier.company, equals('جهينة'));
    });

    test('detects duplicate supplier by phone or normalized name', () async {
      await supplierRepo.addSupplier(name: 'إبراهيم مندوب', phone: '01012345678');

      // Duplicate phone
      final dupPhone = await supplierRepo.checkForDuplicates(
        name: 'شخص آخر',
        phone: '+20 10 1234 5678',
      );
      expect(dupPhone, isNotNull);

      // Duplicate name (normalized 'ابراهيم مندوب' matches 'إبراهيم مندوب')
      final dupName = await supplierRepo.checkForDuplicates(name: 'ابراهيم مندوب');
      expect(dupName, isNotNull);

      // Exclude self does not flag duplicate
      final dupSelf = await supplierRepo.checkForDuplicates(
        name: 'ابراهيم مندوب',
        phone: '01012345678',
        excludeSupplierId: dupPhone!.id,
      );
      expect(dupSelf, isNull);
    });
  });
}
