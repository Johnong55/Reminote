import 'package:flutter/material.dart';
class AppTheme {
  static const _accentSuccess = Color(0xFF4CAF50);
  static const _accentWarning = Color(0xFFFFA726);
  static const _accentSuccessDark = Color(0xFF66BB6A);
  static const _accentWarningDark = Color(0xFFFFB74D);

  static ThemeData lightTheme = _buildTheme(Brightness.light);
  static ThemeData darkTheme = _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: isDark ? Colors.grey.shade300 : Colors.grey.shade900,
        secondary: isDark ? Colors.grey.shade500 : Colors.grey.shade700,
        background: isDark ? const Color(0xFF121212) : Colors.white,
        surface: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
        onPrimary: isDark ? Colors.black : Colors.black,
        onSecondary: isDark ? Colors.white : Colors.grey.shade300,
        onBackground: isDark ? Colors.white : Colors.black,
        onSurface: isDark ? Colors.grey.shade600 : Colors.grey.shade600,
        error: isDark ? Colors.redAccent.shade100 : Colors.redAccent,
        onError: isDark ? Colors.black : Colors.white,
        tertiary: isDark ? _accentSuccessDark : _accentSuccess,
        surfaceVariant: isDark ? _accentWarningDark : _accentWarning,
      ),
      textTheme: _getTextTheme(isDark),
      appBarTheme: _getAppBarTheme(isDark),
      cardTheme: _getCardTheme(isDark),
      elevatedButtonTheme: _getElevatedButtonTheme(isDark),
      textButtonTheme: _getTextButtonTheme(isDark),
      outlinedButtonTheme: _getOutlinedButtonTheme(isDark),
      chipTheme: _getChipTheme(isDark),
      checkboxTheme: _getCheckboxTheme(isDark),
      inputDecorationTheme: _getInputTheme(isDark),
      progressIndicatorTheme: _getProgressTheme(isDark),
      dividerTheme: DividerThemeData(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        thickness: 1,
        space: 32,
      ),
    );
  }

  static TextTheme _getTextTheme(bool isDark) {
    final baseColor = isDark ? Colors.white : Colors.grey.shade900;
    final secondary = isDark ? Colors.grey.shade300 : Colors.grey.shade800;

    return TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: baseColor),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: baseColor),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: baseColor),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: baseColor),
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: secondary),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: isDark ? Colors.grey.shade400 : Colors.grey.shade700),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: isDark ? Colors.grey.shade500 : Colors.grey.shade600),
    );
  }

  static AppBarTheme _getAppBarTheme(bool isDark) => AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black),
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        surfaceTintColor: Colors.transparent,
      );

  static CardTheme _getCardTheme(bool isDark) => CardTheme(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
        elevation: 1,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      );

  static ElevatedButtonThemeData _getElevatedButtonTheme(bool isDark) => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.grey.shade300 : Colors.grey.shade900,
          foregroundColor: isDark ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      );

  static TextButtonThemeData _getTextButtonTheme(bool isDark) => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? Colors.grey.shade300 : Colors.grey.shade900,
        ),
      );

  static OutlinedButtonThemeData _getOutlinedButtonTheme(bool isDark) => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? Colors.grey.shade300 : Colors.grey.shade900,
          side: BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey.shade400),
        ),
      );

  static ChipThemeData _getChipTheme(bool isDark) => ChipThemeData(
        backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
        disabledColor: isDark ? const Color(0xFF252525) : Colors.grey.shade200,
        selectedColor: isDark ? const Color(0xFF3A3A3A) : Colors.grey.shade300,
        labelStyle: TextStyle(color: isDark ? Colors.grey.shade300 : Colors.grey.shade800, fontSize: 12),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );

  static CheckboxThemeData _getCheckboxTheme(bool isDark) => CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return isDark ? _accentSuccessDark : _accentSuccess;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(isDark ? Colors.black : Colors.white),
        side: BorderSide(color: isDark ? Colors.grey.shade600 : Colors.grey.shade400),
      );

  static InputDecorationTheme _getInputTheme(bool isDark) => InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
        ),
        hintStyle: TextStyle(color: isDark ? Colors.grey.shade600 : Colors.grey.shade500),
      );

  static ProgressIndicatorThemeData _getProgressTheme(bool isDark) => ProgressIndicatorThemeData(
        color: isDark ? _accentSuccessDark : _accentSuccess,
      );
}
