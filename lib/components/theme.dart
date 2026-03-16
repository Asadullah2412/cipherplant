import 'package:flutter/material.dart';

// theme_notifier.dart

import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  ThemeNotifier() {
    loadTheme(); // Load saved mode on initialization
  }
  void saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDark);
  }

  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    saveTheme(isDark);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDark);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkTheme') ?? true;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // trigger rebuild if needed
  }

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF4CAF50), // Fresh leaf green
      onPrimary: Colors.white,
      secondary: Color(0xFF8BC34A), // Vibrant lime-green
      onSecondary: Colors.black87,
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      surface: Color(0xFFF6FAF4), // Very pale green-tinted surface
      onSurface: Color(0xFF1B3322), // Deep plant green for text
      outline: Color(0xFFC5D6C2), // Soft sage outline
      inverseSurface: Color(0xFF0E1F14), // Dark forest green
      inversePrimary: Color(0xFF2E7D32), // Deep leaf green
      shadow: Colors.black12,
      tertiary: Color(0xFFE7F3E3), // Misty moss highlight
      onTertiary: Colors.black87,
    ),
    scaffoldBackgroundColor: Color(0xFFEFF6EC), // Soft leafy background
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFE4F2DF), // Light mossy tone
      foregroundColor: Color(0xFF1B3322),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF4CAF50)),
      titleTextStyle: TextStyle(
        color: Color(0xFF1B3322),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardColor: Color(0xFFF1F7EF), // Slightly deeper than scaffold BG
    iconTheme: IconThemeData(color: Color(0xFF4CAF50)),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFF1B3322),
        height: 1.4,
      ),
      titleLarge: TextStyle(
        color: Color(0xFF2E7D32),
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xFF0E1F14), // Deep forest green
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFA5D6A7), // Soft mint
      secondary: Color(0xFF66BB6A), // Balanced green
      surface: Color(0xFF16291D), // Mossy green surface
      onSurface: Color(0xFFDCEAD8),
      outline: Color(0xFF486B4D), // Muted moss outline
      onPrimary: Colors.black,
      onSecondary: Colors.black87,
      error: Color(0xFFEF9A9A),
      onError: Colors.black,
      inverseSurface: Color(0xFFF0F7EB),
      inversePrimary: Color(0xFF81C784),
      tertiary: Color(0xFF355E3B), // Deep botanical green
      onTertiary: Colors.white,
    ),
    cardColor: Color(0xFF1B3322), // Dark leaf green card
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF143D27), // Rich emerald green
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFA5D6A7)),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    iconTheme: IconThemeData(color: Color(0xFFA5D6A7)),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFDCEAD8), height: 1.4),
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
