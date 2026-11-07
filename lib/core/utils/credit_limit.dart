import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum CreditLimitStatus {
  /// No limit set for this customer
  none,

  /// Debt is below 80% of the limit (Safe)
  safe,

  /// Debt is between 80% and 100% of the limit (Approaching limit)
  warning,

  /// Debt has exceeded 100% of the limit
  exceeded,
}

/// Utility methods for calculating and visualizing customer credit limit thresholds.
abstract final class CreditLimitUtils {
  /// Checks whether adding a new debt will cause the customer's balance to exceed their credit limit.
  ///
  /// CRITICAL RULE: Returns `false` if [limitPiasters] is `null` or `<= 0` (no limit).
  /// Exceeding is strictly `(currentBalance + addedDebt) > limit`.
  static bool willExceed({
    required int currentBalancePiasters,
    required int addedDebtPiasters,
    required int? limitPiasters,
  }) {
    if (limitPiasters == null || limitPiasters <= 0) return false;
    final newBalance = currentBalancePiasters + addedDebtPiasters;
    return newBalance > limitPiasters;
  }

  /// Calculates the ratio of balance to limit (e.g., 0.5 for 50%, 1.2 for 120%).
  static double getUsageRatio({
    required int balancePiasters,
    required int? limitPiasters,
  }) {
    if (limitPiasters == null || limitPiasters <= 0) return 0.0;
    if (balancePiasters <= 0) return 0.0;
    return balancePiasters / limitPiasters;
  }

  /// Determines the status badge/color level based on debt vs limit.
  /// - < 80% -> safe (neutral)
  /// - 80%–100% -> warning (amber)
  /// - > 100% -> exceeded (red)
  static CreditLimitStatus getStatus({
    required int balancePiasters,
    required int? limitPiasters,
  }) {
    if (limitPiasters == null || limitPiasters <= 0) {
      return CreditLimitStatus.none;
    }
    if (balancePiasters <= 0) {
      return CreditLimitStatus.safe;
    }

    final ratio = balancePiasters / limitPiasters;
    if (ratio > 1.0) {
      return CreditLimitStatus.exceeded;
    } else if (ratio >= 0.8) {
      return CreditLimitStatus.warning;
    } else {
      return CreditLimitStatus.safe;
    }
  }

  /// Returns the corresponding semantic color for the given credit limit status.
  static Color getStatusColor(CreditLimitStatus status, {required bool isDark}) {
    switch (status) {
      case CreditLimitStatus.none:
        return Colors.transparent;
      case CreditLimitStatus.safe:
        return isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);
      case CreditLimitStatus.warning:
        return AppColors.warningAmber;
      case CreditLimitStatus.exceeded:
        return AppColors.debtRed;
    }
  }
}
