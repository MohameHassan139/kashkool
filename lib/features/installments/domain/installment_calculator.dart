/// Model representing a scheduled installment calculated in memory.
class GeneratedInstallment {
  final int index;
  final DateTime dueDate;
  final int amountPiasters;

  const GeneratedInstallment({
    required this.index,
    required this.dueDate,
    required this.amountPiasters,
  });
}

/// Core calculation engine for installments.
abstract final class InstallmentCalculator {
  /// Safely adds [monthsToAdd] to [date], clamping the day if the target month has fewer days.
  /// Example: Jan 31 + 1 month => Feb 28 (or 29), Mar 31 + 1 month => Apr 30.
  static DateTime addMonths(DateTime date, int monthsToAdd) {
    final rawMonth = date.month + monthsToAdd;
    final targetYear = date.year + (rawMonth - 1) ~/ 12;
    final targetMonth = ((rawMonth - 1) % 12) + 1;

    // Day 0 of next month is the last day of targetMonth
    final daysInTargetMonth = DateTime(targetYear, targetMonth + 1, 0).day;
    final targetDay = date.day > daysInTargetMonth ? daysInTargetMonth : date.day;

    return DateTime(
      targetYear,
      targetMonth,
      targetDay,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
    );
  }

  /// Generates the schedule of installments.
  ///
  /// Guarantees:
  /// - `totalPricePiasters - downPaymentPiasters` equals the exact sum of all generated installment amounts.
  /// - Rounding remainders are absorbed by the final installment.
  static List<GeneratedInstallment> generateSchedule({
    required int totalPricePiasters,
    required int downPaymentPiasters,
    required int count,
    required String frequency, // 'monthly' or 'weekly'
    required DateTime startDate,
  }) {
    if (count <= 0) {
      throw ArgumentError.value(count, 'count', 'Installment count must be greater than zero.');
    }

    final principal = totalPricePiasters - downPaymentPiasters;
    if (principal <= 0) {
      throw ArgumentError('Principal amount (total - down payment) must be greater than zero.');
    }

    final baseAmount = principal ~/ count;
    final remainder = principal % count;

    final schedule = <GeneratedInstallment>[];

    for (int i = 0; i < count; i++) {
      final dueDate = (frequency == 'weekly')
          ? startDate.add(Duration(days: 7 * i))
          : addMonths(startDate, i);

      // Final installment absorbs the remainder so sum matches principal exactly
      final isLast = (i == count - 1);
      final amount = isLast ? (baseAmount + remainder) : baseAmount;

      schedule.add(
        GeneratedInstallment(
          index: i + 1,
          dueDate: dueDate,
          amountPiasters: amount,
        ),
      );
    }

    return schedule;
  }

  /// Calculates the remaining unpaid balance for a plan in piasters.
  static int calculateRemainingPiasters({
    required int totalPricePiasters,
    required int downPaymentPiasters,
    required int totalPaidPiasters,
  }) {
    final principal = totalPricePiasters - downPaymentPiasters;
    final remaining = principal - totalPaidPiasters;
    return remaining < 0 ? 0 : remaining;
  }

  /// Calculates early settlement details including an optional discount.
  static ({int remainingPiasters, int maxDiscount, int netSettlementAmount}) calculateEarlySettlement({
    required int remainingPiasters,
    int discountPiasters = 0,
  }) {
    final safeDiscount = discountPiasters.clamp(0, remainingPiasters);
    final netAmount = remainingPiasters - safeDiscount;
    return (
      remainingPiasters: remainingPiasters,
      maxDiscount: remainingPiasters,
      netSettlementAmount: netAmount,
    );
  }

  /// Checks if a date falls on the same calendar day as [targetDate].
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Determines if an installment is overdue relative to [now].
  static bool isOverdue({
    required DateTime dueDate,
    required int amountPiasters,
    required int paidPiasters,
    DateTime? now,
  }) {
    if (paidPiasters >= amountPiasters) return false;

    final current = now ?? DateTime.now();
    final todayStart = DateTime(current.year, current.month, current.day);
    final dueDayStart = DateTime(dueDate.year, dueDate.month, dueDate.day);

    return dueDayStart.isBefore(todayStart);
  }

  /// Determines if an installment is due today relative to [now].
  static bool isDueToday({
    required DateTime dueDate,
    required int amountPiasters,
    required int paidPiasters,
    DateTime? now,
  }) {
    if (paidPiasters >= amountPiasters) return false;
    final current = now ?? DateTime.now();
    return isSameDay(dueDate, current);
  }
}
