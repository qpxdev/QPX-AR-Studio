import 'package:flutter/material.dart';
import '../colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      primaryColor: AppColors.primaryOrange,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF18181B),
        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
        prefixIconColor: AppColors.textMuted,
        suffixIconColor: AppColors.textMuted,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryOrange, width: 1.5),
        ),
      ),
    );
  }
}