import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/features/installments/domain/installment_calculator.dart';

void main() {
  group('InstallmentCalculator', () {
    test('generateSchedule generates correct count and absorbs rounding in final installment', () {
      // 1000 EGP (100,000 piasters) over 3 months with 0 down payment
      final schedule = InstallmentCalculator.generateSchedule(
        totalPricePiasters: 100000,
        downPaymentPiasters: 0,
        count: 3,
        frequency: 'monthly',
        startDate: DateTime(2026, 1, 1),
      );

      expect(schedule.length, 3);
      expect(schedule[0].amountPiasters, 33333);
      expect(schedule[1].amountPiasters, 33333);
      expect(schedule[2].amountPiasters, 33334); // Absorbs 1 remainder

      final sum = schedule.fold<int>(0, (prev, elem) => prev + elem.amountPiasters);
      expect(sum, 100000);
    });

    test('generateSchedule accounts for down payment correctly', () {
      // Total 12,000 EGP, Down payment 2,000 EGP => Principal 10,000 EGP (1,000,000 piasters) across 10 installments
      final schedule = InstallmentCalculator.generateSchedule(
        totalPricePiasters: 1200000,
        downPaymentPiasters: 200000,
        count: 10,
        frequency: 'monthly',
        startDate: DateTime(2026, 3, 1),
      );

      expect(schedule.length, 10);
      for (final inst in schedule) {
        expect(inst.amountPiasters, 100000); // 1,000 EGP each
      }
      final sum = schedule.fold<int>(0, (prev, elem) => prev + elem.amountPiasters);
      expect(sum, 1000000);
    });

    test('addMonths handles month-end clamping (e.g. Jan 31 -> Feb 28 -> Mar 31 -> Apr 30)', () {
      final start = DateTime(2026, 1, 31);

      expect(InstallmentCalculator.addMonths(start, 0), DateTime(2026, 1, 31));
      expect(InstallmentCalculator.addMonths(start, 1), DateTime(2026, 2, 28)); // Non-leap 2026
      expect(InstallmentCalculator.addMonths(start, 2), DateTime(2026, 3, 31));
      expect(InstallmentCalculator.addMonths(start, 3), DateTime(2026, 4, 30));
    });

    test('addMonths handles leap year (e.g. Jan 31, 2028 -> Feb 29, 2028)', () {
      final leapStart = DateTime(2028, 1, 31);
      expect(InstallmentCalculator.addMonths(leapStart, 1), DateTime(2028, 2, 29));
    });

    test('generateSchedule supports weekly frequency', () {
      final start = DateTime(2026, 5, 1);
      final schedule = InstallmentCalculator.generateSchedule(
        totalPricePiasters: 40000,
        downPaymentPiasters: 0,
        count: 4,
        frequency: 'weekly',
        startDate: start,
      );

      expect(schedule.length, 4);
      expect(schedule[0].dueDate, start);
      expect(schedule[1].dueDate, start.add(const Duration(days: 7)));
      expect(schedule[2].dueDate, start.add(const Duration(days: 14)));
      expect(schedule[3].dueDate, start.add(const Duration(days: 21)));
    });

    test('calculateRemainingPiasters calculates remaining accurately', () {
      // 10,000 total, 2,000 down payment, 3,000 paid so far => 5,000 remaining
      final remaining = InstallmentCalculator.calculateRemainingPiasters(
        totalPricePiasters: 1000000,
        downPaymentPiasters: 200000,
        totalPaidPiasters: 300000,
      );
      expect(remaining, 500000);
    });

    test('calculateEarlySettlement caps discount at remaining principal', () {
      final result = InstallmentCalculator.calculateEarlySettlement(
        remainingPiasters: 500000,
        discountPiasters: 50000,
      );
      expect(result.remainingPiasters, 500000);
      expect(result.netSettlementAmount, 450000);

      // Oversized discount should be clamped safely
      final oversized = InstallmentCalculator.calculateEarlySettlement(
        remainingPiasters: 500000,
        discountPiasters: 9999999,
      );
      expect(oversized.netSettlementAmount, 0);
    });

    test('isOverdue and isDueToday evaluate dates correctly', () {
      final today = DateTime(2026, 6, 15, 12, 0);

      // Overdue: yesterday
      expect(
        InstallmentCalculator.isOverdue(
          dueDate: DateTime(2026, 6, 14),
          amountPiasters: 10000,
          paidPiasters: 0,
          now: today,
        ),
        isTrue,
      );

      // Paid installment is NOT overdue even if date is past
      expect(
        InstallmentCalculator.isOverdue(
          dueDate: DateTime(2026, 6, 14),
          amountPiasters: 10000,
          paidPiasters: 10000,
          now: today,
        ),
        isFalse,
      );

      // Due today
      expect(
        InstallmentCalculator.isDueToday(
          dueDate: DateTime(2026, 6, 15, 9, 0),
          amountPiasters: 10000,
          paidPiasters: 0,
          now: today,
        ),
        isTrue,
      );

      // Tomorrow is NOT overdue and NOT due today
      expect(
        InstallmentCalculator.isOverdue(
          dueDate: DateTime(2026, 6, 16),
          amountPiasters: 10000,
          paidPiasters: 0,
          now: today,
        ),
        isFalse,
      );
      expect(
        InstallmentCalculator.isDueToday(
          dueDate: DateTime(2026, 6, 16),
          amountPiasters: 10000,
          paidPiasters: 0,
          now: today,
        ),
        isFalse,
      );
    });
  });
}
