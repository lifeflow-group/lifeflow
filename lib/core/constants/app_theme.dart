import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFA500);
  static const Color secondaryColor = Color(0xFF4A90E2);
  static const Color accentColor = Color(0xFFFF5722);
  static const Color lightBackground = Color(0xFFFDF6E3);
  static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color cardLight = Color(0xFFFDE6C1);
  static const Color cardDark = Color(0xFF2A2A2A);
  static const Color lightTextColor = Colors.black87;
  static const Color darkTextColor = Colors.white70;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: lightBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.grey,
      onSurface: lightTextColor,
    ),
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ).apply(bodyColor: lightTextColor, displayColor: lightTextColor),
    cardTheme: CardTheme(
      color: cardLight,
      shadowColor: Colors.black26,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
    ),
    iconTheme: IconThemeData(color: primaryColor),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: cardDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: darkTextColor,
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ).apply(bodyColor: darkTextColor, displayColor: darkTextColor),
    cardTheme: CardTheme(
      color: cardDark,
      shadowColor: Colors.black54,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
    ),
    iconTheme: IconThemeData(color: accentColor),
  );
}
