import 'package:flutter/material.dart';

class AppColors {
  // --- Grayscale Palette (Unchanged) ---
  static const Color gray900 = Color(0xFF1A1A1A);
  static const Color gray800 = Color(0xFF333333);
  static const Color gray700 = Color(0xFF4D4D4D);
  static const Color gray600 = Color(0xFF666666);
  static const Color gray500 = Color(0xFF808080);
  static const Color gray400 = Color(0xFF999999);
  static const Color gray300 = Color(0xFFB3B3B3);
  static const Color gray200 = Color(0xFFCCCCCC);
  static const Color gray100 = Color(0xFFE6E6E6);
  static const Color white = Color(0xFFFFFFFF);

  // --- Feedback Colors ---
  static const Color success = Color(0xFF0C9409);
  static const Color error = Color(0xFFED1010);

  // --- Semantic UI Mappings (Flipped for Light Theme) ---
  static const Color background = white;
  static const Color surface = white; // Cards and dialogs
  static const Color surfaceVariant = gray100; // Subtle background fills
  static const Color border = gray200; // Soft borders
  static const Color textPrimary = gray900; // High contrast text
  static const Color textSecondary = gray600; // Muted text for subtitles

  // Since you didn't specify a brand color, using gray900 as the
  // primary action color creates a highly modern, minimalist look.
  static const Color primaryAction = gray900;
}
