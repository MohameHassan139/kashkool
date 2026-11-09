import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// App theme configuration for Kashkool.
/// Adheres to Material 3 with Cairo font, high contrast, and accessible touch targets (min 56dp).
abstract final class AppTheme {
  static const String fontFamily = 'Cairo';

  /// Minimum touch target size for buttons & interactive elements
  static const double minTouchTargetSize = 56.0;

  /// Light theme definition
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.light,
      primary: AppColors.primaryBlue,
      surface: AppColors.lightSurface,
      error: AppColors.debtRed,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      scaffoldBg: AppColors.lightBg,
      cardColor: AppColors.lightSurface,
      isDark: false,
    );
  }

  /// Dark theme definition
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlueDark,
      brightness: Brightness.dark,
      primary: AppColors.primaryBlueDark,
      surface: AppColors.darkSurface,
      error: AppColors.debtRedDark,
    ).copyWith(
      surface: AppColors.darkSurface,
      onSurface: AppColors.textLight,
      surfaceContainer: const Color(0xFF1F2937),
      surfaceContainerLow: const Color(0xFF111827),
      surfaceContainerHigh: const Color(0xFF374151),
      outline: const Color(0xFF4B5563),
      outlineVariant: const Color(0xFF374151),
    );

    return _buildTheme(
      colorScheme: colorScheme,
      scaffoldBg: AppColors.darkBg,
      cardColor: AppColors.darkSurface,
      isDark: true,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color scaffoldBg,
    required Color cardColor,
    required bool isDark,
  }) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBg,
      cardColor: cardColor,
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: isDark ? 1.0 : 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: cardColor,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFF0F172A),
        contentTextStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        contentTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 15,
          color: colorScheme.onSurface,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
        thickness: 1,
        space: 1,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary,
        unselectedLabelColor: isDark ? const Color(0xFF9CA3AF) : AppColors.neutralGrey,
        indicatorColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDark ? colorScheme.primary : AppColors.primaryBlue,
        foregroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
        elevation: 3,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: cardColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        textColor: colorScheme.onSurface,
        iconColor: isDark ? const Color(0xFF9CA3AF) : AppColors.neutralGrey,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: scaffoldBg,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(64.0, minTouchTargetSize),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64.0, minTouchTargetSize),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1F2937) : const Color(0xFFFFFFFF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF374151) : const Color(0xFFD1D5DB),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF374151) : const Color(0xFFD1D5DB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        backgroundColor: cardColor,
        indicatorColor: isDark
            ? colorScheme.primary.withValues(alpha: 0.2)
            : AppColors.primaryBlue.withValues(alpha: 0.12),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.primary);
          }
          return IconThemeData(
            color: isDark ? const Color(0xFF9CA3AF) : AppColors.neutralGrey,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          return TextStyle(
            fontFamily: fontFamily,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? colorScheme.primary
                : (isDark ? const Color(0xFF9CA3AF) : AppColors.neutralGrey),
          );
        }),
      ),
    );
  }
}
