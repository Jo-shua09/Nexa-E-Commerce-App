import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,

      // Applies the color palette to core Material widgets
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryAction,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.white, // Text color on top of primary buttons
        onSurface: AppColors.textPrimary,
      ),

      // Maps your custom styles and applies the dark text colors
      textTheme: TextTheme(
        displayLarge: AppTextStyles.header1SemiBold.copyWith(
          color: AppColors.textPrimary,
        ),
        displayMedium: AppTextStyles.header2SemiBold.copyWith(
          color: AppColors.textPrimary,
        ),
        displaySmall: AppTextStyles.header3SemiBold.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTextStyles.header4SemiBold.copyWith(
          color: AppColors.textPrimary,
        ),

        bodyLarge: AppTextStyles.body1Regular.copyWith(
          color: AppColors.textSecondary,
        ),
        bodyMedium: AppTextStyles.body2Regular.copyWith(
          color: AppColors.textSecondary,
        ),
        bodySmall: AppTextStyles.body3Regular.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // Premium solid button styling
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAction,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.gray200,
          disabledForegroundColor: AppColors.gray300,
          textStyle: AppTextStyles.body2SemiBold,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),

      // Input field styling (for search bars, forms, etc.)
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.surfaceVariant,
        filled: false,
        hintStyle: AppTextStyles.body1Regular.copyWith(
          color: AppColors.gray400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray900, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryAction,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
