import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/rating_constants.dart';
import '../db/app_database.dart';
import '../../l10n/l10n.dart';

enum RatingBadge {
  /// ⚪ جديد (< 3 transactions)
  newCustomer,

  /// 🟢 ممتاز (balance <= 0 or oldest debt <= 14 days)
  good,

  /// 🟡 متابعة (between 15 and 45 days)
  watch,

  /// 🔴 متأخر (oldest debt > 45 days or credit limit exceeded)
  late,
}

class CustomerRatingResult {
  final RatingBadge badge;
  final int? oldestUnpaidAgeDays;
  final String explanation;

  const CustomerRatingResult({
    required this.badge,
    this.oldestUnpaidAgeDays,
    required this.explanation,
  });

  Color get color {
    switch (badge) {
      case RatingBadge.newCustomer:
        return const Color(0xFF94A3B8); // Slate 400
      case RatingBadge.good:
        return AppColors.paymentGreen;
      case RatingBadge.watch:
        return AppColors.warningAmber;
      case RatingBadge.late:
        return AppColors.debtRed;
    }
  }

  String get labelAr {
    switch (badge) {
      case RatingBadge.newCustomer:
        return L10n.t.ratingExplanationBottomSheet10;
      case RatingBadge.good:
        return L10n.t.ratingExplanationBottomSheet4;
      case RatingBadge.watch:
        return L10n.t.ratingExplanationBottomSheet6;
      case RatingBadge.late:
        return L10n.t.ratingExplanationBottomSheet8;
    }
  }

  String get labelEn {
    switch (badge) {
      case RatingBadge.newCustomer:
        return 'New';
      case RatingBadge.good:
        return 'Good';
      case RatingBadge.watch:
        return 'Watch';
      case RatingBadge.late:
        return 'Late';
    }
  }
}

/// Computes customer rating using FIFO (First-In, First-Out) debt settlement analysis.
abstract final class CustomerRatingUtils {
  /// Calculates the age in days of the oldest unpaid debt using FIFO settlement.
  static int? calculateOldestUnpaidAgeDays({
    required List<Transaction> transactions,
    required int balancePiasters,
    DateTime? now,
  }) {
    if (balancePiasters <= 0) return 0;
    final currentTime = now ?? DateTime.now();

    final sortedTxs = List<Transaction>.from(transactions)
      ..sort((a, b) => a.occurredAt.compareTo(b.occurredAt));

    var remainingPayments = 0;
    for (final tx in sortedTxs) {
      if (tx.type == TransactionType.payment) {
        remainingPayments += tx.amountPiasters;
      }
    }

    for (final tx in sortedTxs) {
      if (tx.type == TransactionType.debt) {
        if (remainingPayments >= tx.amountPiasters) {
          remainingPayments -= tx.amountPiasters;
        } else {
          final age = currentTime.difference(tx.occurredAt).inDays;
          return age >= 0 ? age : 0;
        }
      }
    }

    return 0;
  }

  static CustomerRatingResult compute({
    required List<Transaction> transactions,
    required int balancePiasters,
    required int? creditLimitPiasters,
    DateTime? now,
  }) {
    final currentTime = now ?? DateTime.now();

    final int oldestUnpaidAgeDays = calculateOldestUnpaidAgeDays(
      transactions: transactions,
      balancePiasters: balancePiasters,
      now: currentTime,
    ) ?? 0;

    // 1. New Customer (< 3 transactions)
    if (transactions.length < RatingConstants.minTransactionsForRegular) {
      return CustomerRatingResult(
        badge: RatingBadge.newCustomer,
        oldestUnpaidAgeDays: oldestUnpaidAgeDays,
        explanation: L10n.t.customerRating1,
      );
    }

    // 2. Settled or Credit balance
    if (balancePiasters <= 0) {
      return CustomerRatingResult(
        badge: RatingBadge.good,
        oldestUnpaidAgeDays: 0,
        explanation: L10n.t.customerRating2,
      );
    }

    final isLimitExceeded = creditLimitPiasters != null &&
        creditLimitPiasters > 0 &&
        balancePiasters > creditLimitPiasters;

    // Rule: Exceeding credit limit immediately marks as Late
    if (isLimitExceeded) {
      final reason = oldestUnpaidAgeDays > RatingConstants.lateThresholdDays
          ? L10n.t.customerRating3(oldestUnpaidAgeDays)
          : L10n.t.customerRating4;

      return CustomerRatingResult(
        badge: RatingBadge.late,
        oldestUnpaidAgeDays: oldestUnpaidAgeDays,
        explanation: reason,
      );
    }

    // Rule: Good (oldestUnpaidAgeDays <= 14 days and within limit)
    if (oldestUnpaidAgeDays <= RatingConstants.goodThresholdDays) {
      return CustomerRatingResult(
        badge: RatingBadge.good,
        oldestUnpaidAgeDays: oldestUnpaidAgeDays,
        explanation: oldestUnpaidAgeDays == 0
            ? L10n.t.customerRating5
            : L10n.t.customerRating6(oldestUnpaidAgeDays),
      );
    }

    // Rule: Late (oldestUnpaidAgeDays > 45 days)
    if (oldestUnpaidAgeDays > RatingConstants.lateThresholdDays) {
      return CustomerRatingResult(
        badge: RatingBadge.late,
        oldestUnpaidAgeDays: oldestUnpaidAgeDays,
        explanation: L10n.t.customerRating7(oldestUnpaidAgeDays),
      );
    }

    // Rule: Watch (everything else: 15–45 days)
    return CustomerRatingResult(
      badge: RatingBadge.watch,
      oldestUnpaidAgeDays: oldestUnpaidAgeDays,
      explanation: L10n.t.customerRating8(oldestUnpaidAgeDays),
    );
  }
}
