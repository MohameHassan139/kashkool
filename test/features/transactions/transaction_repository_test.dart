import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/transactions/data/transaction_repository.dart';

void main() {
  late AppDatabase db;
  late CustomerRepository customerRepo;
  late TransactionRepository txRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    customerRepo = CustomerRepository(db);
    txRepo = TransactionRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('TransactionRepository operations and balance calculations', () {
    test('adds debt transaction and increases customer balance', () async {
      final customerId = await customerRepo.addCustomer(name: 'محمود أحمد');

      final txId = await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 7500, // 75.00 EGP
        note: 'شراء كارت شحن',
      );

      final customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(7500));
      expect(customer.hasDebt, isTrue);
      expect(customer.transactionCount, equals(1));

      final savedTx = await txRepo.getTransaction(txId);
      expect(savedTx, isNotNull);
      expect(savedTx!.note, equals('شراء كارت شحن'));
    });

    test('adds payment transaction and reduces customer balance', () async {
      final customerId = await customerRepo.addCustomer(name: 'سامي عبد الله');

      // Add debt of 100 EGP
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 10000,
      );

      // Add payment of 40 EGP via InstaPay
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.payment,
        amountPiasters: 4000,
        method: PaymentMethod.instapay,
      );

      final customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(6000)); // 60.00 EGP
      expect(customer.transactionCount, equals(2));
    });

    test('handles overpayment producing negative balance (credit for customer)', () async {
      final customerId = await customerRepo.addCustomer(name: 'فاطمة حسن');

      // Debt: 50 EGP
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 5000,
      );

      // Payment: 80 EGP (overpaid by 30 EGP)
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.payment,
        amountPiasters: 8000,
        method: PaymentMethod.cash,
      );

      final customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(-3000)); // -30.00 EGP
      expect(customer.hasCredit, isTrue);
      expect(customer.hasDebt, isFalse);
      expect(customer.isSettled, isFalse);
    });

    test('updates transaction amount and recalculates balance', () async {
      final customerId = await customerRepo.addCustomer(name: 'يوسف جمال');

      final txId = await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 5000,
      );

      var customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(5000));

      // Correct debt amount to 70 EGP
      await txRepo.updateTransaction(
        id: txId,
        amountPiasters: 7000,
        note: 'تعديل السعر',
        occurredAt: DateTime.now(),
      );

      customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(7000));
    });

    test('soft deletes transaction and updates balance accordingly', () async {
      final customerId = await customerRepo.addCustomer(name: 'إبراهيم فؤاد');

      final tx1 = await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 12000,
      );

      final tx2 = await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 3000,
      );

      var customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(15000));

      // Soft delete tx2
      await txRepo.deleteTransaction(tx2);

      customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(12000));
      expect(customer.transactionCount, equals(1));

      // Soft delete tx1
      await txRepo.deleteTransaction(tx1);

      customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(0));
      expect(customer.isSettled, isTrue);
      expect(customer.transactionCount, equals(0));
    });

    test('undo immediately removes transaction and restores balance', () async {
      final customerId = await customerRepo.addCustomer(name: 'عمر شريف');

      // Add debt of 50 EGP
      await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 5000,
      );

      // Accidentally recorded another 100 EGP debt
      final mistakenTxId = await txRepo.addTransaction(
        partyType: PartyType.customer,
        partyId: customerId,
        type: TransactionType.debt,
        amountPiasters: 10000,
      );

      var customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(15000));

      // User presses Undo
      await txRepo.undoTransaction(mistakenTxId);

      customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, equals(5000));
      expect(customer.transactionCount, equals(1));

      final deletedTx = await txRepo.getTransaction(mistakenTxId);
      expect(deletedTx, isNull);
    });

    test('rejects transaction with non-positive amount', () async {
      final customerId = await customerRepo.addCustomer(name: 'كريم');

      expect(
        () => txRepo.addTransaction(
          partyType: PartyType.customer,
          partyId: customerId,
          type: TransactionType.debt,
          amountPiasters: 0,
        ),
        throwsA(isA<ArgumentError>()),
      );

      expect(
        () => txRepo.addTransaction(
          partyType: PartyType.customer,
          partyId: customerId,
          type: TransactionType.debt,
          amountPiasters: -500,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
