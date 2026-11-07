import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/db/app_database.dart';
import 'package:kashkool/features/customers/data/customer_repository.dart';
import 'package:kashkool/features/installments/data/installment_repository.dart';

void main() {
  late AppDatabase db;
  late CustomerRepository customerRepo;
  late InstallmentRepository installmentRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    customerRepo = CustomerRepository(db);
    installmentRepo = InstallmentRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('InstallmentRepository', () {
    test('createPlan creates plan, installments, and links to customer ledger', () async {
      final customerId = await customerRepo.addCustomer(name: 'أحمد سعيد', phone: '01012345678');

      final planId = await installmentRepo.createPlan(
        customerId: customerId,
        itemDescription: 'تليفون ريلمي 11',
        totalPricePiasters: 600000, // 6,000 EGP
        downPaymentPiasters: 100000, // 1,000 EGP
        installmentCount: 5,
        frequency: InstallmentFrequency.monthly,
        startDate: DateTime(2026, 4, 1),
        guarantorName: 'محمود سعيد',
        guarantorPhone: '01123456789',
        linkToCustomerLedger: true,
      );

      final planDetails = await installmentRepo.watchPlanWithDetails(planId).first;
      expect(planDetails, isNotNull);
      expect(planDetails!.plan.itemDescription, 'تليفون ريلمي 11');
      expect(planDetails.installments.length, 5);
      expect(planDetails.totalInstallmentsCount, 5);
      expect(planDetails.remainingPiasters, 500000); // 6,000 - 1,000 = 5,000 EGP remaining
      expect(planDetails.plan.status, PlanStatus.active);

      // Verify customer ledger balance: 6,000 debt - 1,000 down payment = 5,000 EGP balance
      final customerWithBalance = await customerRepo.getCustomerWithBalance(customerId);
      expect(customerWithBalance!.balancePiasters, 500000);
    });

    test('recordPayment pays specific installment and rolls over excess to next installment', () async {
      final customerId = await customerRepo.addCustomer(name: 'حسن علي');

      final planId = await installmentRepo.createPlan(
        customerId: customerId,
        itemDescription: 'غسالة توشيبا',
        totalPricePiasters: 300000, // 3,000 EGP
        downPaymentPiasters: 0,
        installmentCount: 3, // 1,000 EGP each (100,000 piasters)
        startDate: DateTime(2026, 5, 1),
      );

      final details = await installmentRepo.watchPlanWithDetails(planId).first;
      final inst1 = details!.installments[0];

      // Pay 1,500 EGP (150,000 piasters) targeted at installment 1
      await installmentRepo.recordPayment(
        planId: planId,
        installmentId: inst1.id,
        amountPiasters: 150000,
        linkToCustomerLedger: true,
      );

      final updated = await installmentRepo.watchPlanWithDetails(planId).first;
      final updatedInst1 = updated!.installments[0];
      final updatedInst2 = updated.installments[1];

      // Installment 1 should be fully paid (100,000 / 100,000)
      expect(updatedInst1.status, InstallmentStatus.paid);
      expect(updatedInst1.paidPiasters, 100000);

      // Excess 50,000 rolled over to Installment 2 (partial: 50,000 / 100,000)
      expect(updatedInst2.status, InstallmentStatus.partial);
      expect(updatedInst2.paidPiasters, 50000);

      expect(updated.remainingPiasters, 150000);
      expect(updated.paidInstallmentsCount, 1);

      // Customer balance should decrease by 1,500 EGP (remaining 1,500 EGP)
      final customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, 150000);
    });

    test('completing all installments automatically marks plan as completed', () async {
      final customerId = await customerRepo.addCustomer(name: 'مروان كمال');

      final planId = await installmentRepo.createPlan(
        customerId: customerId,
        itemDescription: 'شاشة سامسونج',
        totalPricePiasters: 200000, // 2,000 EGP
        downPaymentPiasters: 0,
        installmentCount: 2, // 1,000 EGP each
        startDate: DateTime(2026, 6, 1),
      );

      // Pay both installments
      await installmentRepo.recordPayment(
        planId: planId,
        amountPiasters: 200000,
      );

      final updated = await installmentRepo.watchPlanWithDetails(planId).first;
      expect(updated!.plan.status, PlanStatus.completed);
      expect(updated.isFullyPaid, isTrue);
      expect(updated.remainingPiasters, 0);
      expect(updated.progressPercentage, 1.0);
    });

    test('settlePlanEarly marks all installments paid and applies discount', () async {
      final customerId = await customerRepo.addCustomer(name: 'كريم عادل');

      final planId = await installmentRepo.createPlan(
        customerId: customerId,
        itemDescription: 'لابتوب ديل',
        totalPricePiasters: 1000000, // 10,000 EGP
        downPaymentPiasters: 200000, // 2,000 EGP (remaining 8,000 EGP)
        installmentCount: 8,
        startDate: DateTime(2026, 7, 1),
      );

      // Early settlement with 1,000 EGP discount (100,000 piasters)
      await installmentRepo.settlePlanEarly(
        planId: planId,
        discountPiasters: 100000,
        linkToCustomerLedger: true,
      );

      final updated = await installmentRepo.watchPlanWithDetails(planId).first;
      expect(updated!.plan.status, PlanStatus.completed);
      expect(updated.paidInstallmentsCount, 8);

      // Customer ledger should be settled to 0
      final customer = await customerRepo.getCustomerWithBalance(customerId);
      expect(customer!.balancePiasters, 0);
    });

    test('deletePlan soft deletes plan and its installments', () async {
      final customerId = await customerRepo.addCustomer(name: 'أيمن طارق');

      final planId = await installmentRepo.createPlan(
        customerId: customerId,
        itemDescription: 'سخان أولمبيك',
        totalPricePiasters: 300000,
        downPaymentPiasters: 0,
        installmentCount: 3,
        startDate: DateTime(2026, 8, 1),
      );

      await installmentRepo.deletePlan(planId);

      final plans = await installmentRepo.watchAllPlans().first;
      expect(plans.isEmpty, isTrue);
    });

    test('watchDueInstallments lists overdue and today installments', () async {
      final customerId = await customerRepo.addCustomer(name: 'سالم يحيى');
      final pastDate = DateTime(2026, 1, 1);

      await installmentRepo.createPlan(
        customerId: customerId,
        itemDescription: 'مروحة توشيبا',
        totalPricePiasters: 200000,
        downPaymentPiasters: 0,
        installmentCount: 2,
        startDate: pastDate, // First installment due in Jan 2026 (past => overdue)
      );

      final dueItems = await installmentRepo.watchDueInstallments().first;
      expect(dueItems.isNotEmpty, isTrue);
      expect(dueItems.first.isOverdue, isTrue);
      expect(dueItems.first.customer.name, 'سالم يحيى');
    });
  });
}
