import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/cash_drawer/data/expenses_repository.dart';

void main() {
  late AppDatabase db;
  late ExpensesRepository expensesRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    expensesRepo = ExpensesRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ExpensesRepository CRUD and queries', () {
    test('adds an expense and persists correctly', () async {
      final now = DateTime(2026, 11, 6, 14, 30);
      final expense = await expensesRepo.addExpense(
        date: now,
        category: ExpenseCategory.electricity,
        amountPiasters: 25000, // 250 EGP
        method: PaymentMethod.cash,
        note: 'فاتورة كهرباء المحل لشهر أكتوبر',
      );

      expect(expense.id, isNotEmpty);
      expect(expense.amountPiasters, equals(25000));
      expect(expense.category, equals(ExpenseCategory.electricity));
      expect(expense.method, equals(PaymentMethod.cash));
      expect(expense.note, equals('فاتورة كهرباء المحل لشهر أكتوبر'));

      final list = await expensesRepo.getExpensesForDay(now);
      expect(list.length, equals(1));
      expect(list.first.id, equals(expense.id));
    });

    test('rejects non-positive expense amounts', () async {
      expect(
        () => expensesRepo.addExpense(
          date: DateTime.now(),
          category: ExpenseCategory.rent,
          amountPiasters: 0,
        ),
        throwsArgumentError,
      );

      expect(
        () => expensesRepo.addExpense(
          date: DateTime.now(),
          category: ExpenseCategory.rent,
          amountPiasters: -500,
        ),
        throwsArgumentError,
      );
    });

    test('updates an existing expense', () async {
      final now = DateTime(2026, 11, 6);
      final expense = await expensesRepo.addExpense(
        date: now,
        category: ExpenseCategory.supplies,
        amountPiasters: 10000,
        note: 'أكياس بلاستيك',
      );

      await expensesRepo.updateExpense(
        id: expense.id,
        amountPiasters: 15000,
        note: 'أكياس بلاستيك وشيكارتين',
        category: ExpenseCategory.other,
      );

      final list = await expensesRepo.getExpensesForDay(now);
      expect(list.first.amountPiasters, equals(15000));
      expect(list.first.note, equals('أكياس بلاستيك وشيكارتين'));
      expect(list.first.category, equals(ExpenseCategory.other));
    });

    test('soft deletes expense and excludes from active queries', () async {
      final now = DateTime(2026, 11, 6);
      final expense = await expensesRepo.addExpense(
        date: now,
        category: ExpenseCategory.salary,
        amountPiasters: 15000,
      );

      expect((await expensesRepo.getExpensesForDay(now)).length, equals(1));

      await expensesRepo.deleteExpense(expense.id);

      final remaining = await expensesRepo.getExpensesForDay(now);
      expect(remaining.isEmpty, isTrue);
    });

    test('filters expenses by day and month accurately', () async {
      final day1 = DateTime(2026, 11, 6, 10, 0);
      final day2 = DateTime(2026, 11, 7, 11, 0);
      final nextMonth = DateTime(2026, 12, 1, 9, 0);

      await expensesRepo.addExpense(
        date: day1,
        category: ExpenseCategory.supplies,
        amountPiasters: 5000,
      );
      await expensesRepo.addExpense(
        date: day2,
        category: ExpenseCategory.rent,
        amountPiasters: 100000,
      );
      await expensesRepo.addExpense(
        date: nextMonth,
        category: ExpenseCategory.salary,
        amountPiasters: 50000,
      );

      final day1Expenses = await expensesRepo.getExpensesForDay(day1);
      expect(day1Expenses.length, equals(1));
      expect(day1Expenses.first.amountPiasters, equals(5000));

      final novExpenses = await expensesRepo.watchExpensesForMonth(DateTime(2026, 11, 1)).first;
      expect(novExpenses.length, equals(2));

      final decExpenses = await expensesRepo.watchExpensesForMonth(DateTime(2026, 12, 1)).first;
      expect(decExpenses.length, equals(1));
    });
  });
}
