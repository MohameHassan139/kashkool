import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/customers/domain/customer_filter_sort.dart';

void main() {
  late AppDatabase db;
  late CustomerRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = CustomerRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('CustomerRepository CRUD operations', () {
    test('creates customer with normalized phone and persists to DB', () async {
      final id = await repo.addCustomer(
        name: 'أحمد إبراهيم',
        phone: '+20 10 1234 5678',
        notes: 'جار المحل',
        creditLimitPiasters: 50000,
      );

      final customerWithBalance = await repo.getCustomerWithBalance(id);
      expect(customerWithBalance, isNotNull);
      expect(customerWithBalance!.customer.name, equals('أحمد إبراهيم'));
      expect(customerWithBalance.customer.phone, equals('01012345678'));
      expect(customerWithBalance.customer.creditLimitPiasters, equals(50000));
      expect(customerWithBalance.balancePiasters, equals(0));
      expect(customerWithBalance.isSettled, isTrue);
    });

    test('rejects customer with name less than 2 characters', () async {
      expect(
        () => repo.addCustomer(name: 'أ'),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => repo.addCustomer(name: '   '),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('updates customer details correctly', () async {
      final id = await repo.addCustomer(name: 'محمد علي', phone: '01112223334');

      await repo.updateCustomer(
        id: id,
        name: 'محمد علي حسن',
        phone: '01223334445',
        notes: 'تم تعديل البيانات',
        creditLimitPiasters: 100000,
      );

      final updated = await repo.getCustomerWithBalance(id);
      expect(updated!.customer.name, equals('محمد علي حسن'));
      expect(updated.customer.phone, equals('01223334445'));
      expect(updated.customer.notes, equals('تم تعديل البيانات'));
      expect(updated.customer.creditLimitPiasters, equals(100000));
    });

    test('soft deletes customer and hides from list query', () async {
      final id = await repo.addCustomer(name: 'محمود سامي');

      final listBefore = await repo.watchCustomersWithBalance().first;
      expect(listBefore.length, equals(1));

      await repo.deleteCustomer(id);

      final listAfter = await repo.watchCustomersWithBalance().first;
      expect(listAfter.isEmpty, isTrue);

      final customerWithBalance = await repo.getCustomerWithBalance(id);
      expect(customerWithBalance, isNull);
    });
  });

  group('Balance calculation and total receivables', () {
    test('computes balance dynamically from transactions (Debt - Payment)', () async {
      final customerId = await repo.addCustomer(name: 'حسن شاكر');

      // Add Debt: 150.00 EGP (15,000 piasters)
      await db.into(db.transactions).insert(
            TransactionsCompanion.insert(
              id: 'tx-1',
              partyType: PartyType.customer,
              partyId: customerId,
              type: TransactionType.debt,
              amountPiasters: 15000,
              occurredAt: Value(DateTime.now()),
            ),
          );

      var item = await repo.getCustomerWithBalance(customerId);
      expect(item!.balancePiasters, equals(15000));
      expect(item.hasDebt, isTrue);
      expect(item.isSettled, isFalse);

      // Add Payment: 50.00 EGP (5,000 piasters)
      await db.into(db.transactions).insert(
            TransactionsCompanion.insert(
              id: 'tx-2',
              partyType: PartyType.customer,
              partyId: customerId,
              type: TransactionType.payment,
              amountPiasters: 5000,
              occurredAt: Value(DateTime.now()),
            ),
          );

      item = await repo.getCustomerWithBalance(customerId);
      expect(item!.balancePiasters, equals(10000)); // 15,000 - 5,000 = 10,000 piasters

      // Add Payment settling balance: 100.00 EGP (10,000 piasters)
      await db.into(db.transactions).insert(
            TransactionsCompanion.insert(
              id: 'tx-3',
              partyType: PartyType.customer,
              partyId: customerId,
              type: TransactionType.payment,
              amountPiasters: 10000,
              occurredAt: Value(DateTime.now()),
            ),
          );

      item = await repo.getCustomerWithBalance(customerId);
      expect(item!.balancePiasters, equals(0));
      expect(item.isSettled, isTrue);
    });

    test('calculates total receivables across multiple customers', () async {
      final c1 = await repo.addCustomer(name: 'عميل 1');
      final c2 = await repo.addCustomer(name: 'عميل 2');

      // c1 owes 200 EGP (20,000 piasters)
      await db.into(db.transactions).insert(
            TransactionsCompanion.insert(
              id: 't1',
              partyType: PartyType.customer,
              partyId: c1,
              type: TransactionType.debt,
              amountPiasters: 20000,
            ),
          );

      // c2 owes 300 EGP (30,000 piasters)
      await db.into(db.transactions).insert(
            TransactionsCompanion.insert(
              id: 't2',
              partyType: PartyType.customer,
              partyId: c2,
              type: TransactionType.debt,
              amountPiasters: 30000,
            ),
          );

      final total = await repo.watchTotalReceivables().first;
      expect(total, equals(50000)); // 500.00 EGP
    });
  });

  group('Customer search, filters, and duplicate check', () {
    test('searches with Arabic orthographic normalization (أ/إ -> ا)', () async {
      await repo.addCustomer(name: 'إبراهيم أحمد');
      await repo.addCustomer(name: 'محمود مصطفى');

      // Search with plain Alef
      final results1 = await repo.watchCustomersWithBalance(query: 'ابراهيم').first;
      expect(results1.length, equals(1));
      expect(results1.first.customer.name, equals('إبراهيم أحمد'));

      // Search with Yaa/Alef Maksoura
      final results2 = await repo.watchCustomersWithBalance(query: 'مصطفي').first;
      expect(results2.length, equals(1));
      expect(results2.first.customer.name, equals('محمود مصطفى'));
    });

    test('filters by hasDebt and settled', () async {
      final c1 = await repo.addCustomer(name: 'عميل مديون');
      await repo.addCustomer(name: 'عميل خالص');

      await db.into(db.transactions).insert(
            TransactionsCompanion.insert(
              id: 't-debt',
              partyType: PartyType.customer,
              partyId: c1,
              type: TransactionType.debt,
              amountPiasters: 5000,
            ),
          );

      final hasDebtList =
          await repo.watchCustomersWithBalance(filter: CustomerFilter.hasDebt).first;
      expect(hasDebtList.length, equals(1));
      expect(hasDebtList.first.customer.name, equals('عميل مديون'));

      final settledList =
          await repo.watchCustomersWithBalance(filter: CustomerFilter.settled).first;
      expect(settledList.length, equals(1));
      expect(settledList.first.customer.name, equals('عميل خالص'));
    });

    test('detects duplicate customer by normalized phone or name', () async {
      await repo.addCustomer(name: 'علي حسن', phone: '01012345678');

      // Same phone with international prefix
      final dupPhone = await repo.checkForDuplicates(
        name: 'أي اسم آخر',
        phone: '+201012345678',
      );
      expect(dupPhone, isNotNull);
      expect(dupPhone!.name, equals('علي حسن'));

      // Same name with Alef variant
      final dupName = await repo.checkForDuplicates(name: 'على حسن');
      expect(dupName, isNotNull);
      expect(dupName!.name, equals('علي حسن'));
    });
  });
}
