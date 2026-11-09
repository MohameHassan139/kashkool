import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kashkool/core/constants/app_colors.dart';
import 'package:kashkool/core/theme/app_theme.dart';

void main() {
  group('AppTheme Tests', () {
    test('Light theme properties', () {
      final light = AppTheme.lightTheme;

      expect(light.brightness, Brightness.light);
      expect(light.useMaterial3, isTrue);
      expect(light.scaffoldBackgroundColor, AppColors.lightBg);
      expect(light.cardColor, AppColors.lightSurface);
      expect(light.colorScheme.primary, AppColors.primaryBlue);
      expect(light.cardTheme.color, AppColors.lightSurface);
      expect(light.bottomSheetTheme.backgroundColor, AppColors.lightSurface);
      expect(light.dialogTheme.backgroundColor, AppColors.lightSurface);
      expect(light.tabBarTheme.labelColor, AppColors.primaryBlue);
    });

    test('Dark theme properties and contrast', () {
      final dark = AppTheme.darkTheme;

      expect(dark.brightness, Brightness.dark);
      expect(dark.useMaterial3, isTrue);
      expect(dark.scaffoldBackgroundColor, AppColors.darkBg);
      expect(dark.cardColor, AppColors.darkSurface);
      expect(dark.colorScheme.primary, AppColors.primaryBlueDark);
      expect(dark.cardTheme.color, AppColors.darkSurface);
      expect(dark.bottomSheetTheme.backgroundColor, AppColors.darkSurface);
      expect(dark.dialogTheme.backgroundColor, AppColors.darkSurface);
      expect(dark.tabBarTheme.labelColor, AppColors.primaryBlueDark);
      expect(dark.navigationBarTheme.backgroundColor, AppColors.darkSurface);
    });

    test('AppColors dark-mode helpers return correct contrast containers', () {
      // Light containers
      expect(AppColors.debtContainer(false), AppColors.debtRedLight);
      expect(AppColors.paymentContainer(false), AppColors.paymentGreenLight);
      expect(AppColors.warningContainer(false), AppColors.warningAmberLight);
      expect(AppColors.neutralContainer(false), AppColors.neutralGreyLight);

      // Dark containers
      expect(AppColors.debtContainer(true), isNot(AppColors.debtRedLight));
      expect(AppColors.paymentContainer(true), isNot(AppColors.paymentGreenLight));
      expect(AppColors.warningContainer(true), isNot(AppColors.warningAmberLight));
      expect(AppColors.neutralContainer(true), isNot(AppColors.neutralGreyLight));

      // Secondary text helper
      expect(AppColors.secondaryText(false), AppColors.neutralGrey);
      expect(AppColors.secondaryText(true), const Color(0xFF9CA3AF));
    });
  });
}
