import 'package:flutter/material.dart';

/// Semantic colors used across the Kashkool app.
/// Designed for high contrast and quick readability in shop environments.
abstract final class AppColors {
  // Primary brand colors
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color primaryNavy = primaryBlue;
  static const Color primaryBlueLight = Color(0xFF2563EB);

  // Semantic financial colors (Egypt shop colloquial semantics)
  /// "عليه" (debt / customer owes shop) - Red
  static const Color debtRed = Color(0xFFDC2626);
  static const Color debtRedLight = Color(0xFFFEE2E2);

  /// "دفع" (payment / shop received money) - Green
  static const Color paymentGreen = Color(0xFF16A34A);
  static const Color paymentGreenLight = Color(0xFFDCFCE7);
  static const Color primaryGreen = paymentGreen;

  /// Warning / Credit limit / Due soon - Amber
  static const Color warningAmber = Color(0xFFD97706);
  static const Color warningAmberLight = Color(0xFFFEF3C7);

  /// Neutral grey for borders, secondary details, disabled states
  static const Color neutralGrey = Color(0xFF6B7280);
  static const Color neutralGreyLight = Color(0xFFF3F4F6);
  static const Color neutralGreyDark = Color(0xFF374151);

  /// High contrast dark text
  static const Color textDark = Color(0xFF1F2937);

  // Surface & backgrounds
  static const Color lightBg = Color(0xFFF9FAFB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkBg = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
}
