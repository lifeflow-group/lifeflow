import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFA500);
  static const Color secondaryColor = Color(0xFF4A90E2);
  static const Color accentColor = Color(0xFFFF5722);
  static const Color lightBackground = Color.fromRGBO(250, 250, 250, 1);
  static const Color darkBackground = Color(0xFF121212);
  static const Color cardLight = Color(0xFFFDE6C1);
  static const Color cardDark = Color(0xFF2A2A2A);
  static const Color lightTextColor = Colors.black87;
  static const Color darkTextColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: Color(0xFFBBDEFB),
      secondaryContainer: Color(0xFFE3F2FD),
      surface: lightBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.grey,
      onSurface: lightTextColor,
      outline: Color(0xFF9E9E9E),
      outlineVariant: Color(0xFFE0E0E0),
      shadow: Color(0x40000000),
      scrim: Color(0x80000000),
      error: Colors.red,
    ),
    primaryColorLight: primaryColor,
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
    cardTheme: CardThemeData(
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
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.blueAccent.withAlpha(127),
      selectionHandleColor: Colors.blueAccent,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor.withAlpha(180),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryColor.withAlpha(180),
      secondary: Color(0xFF81D4FA), // Brighter secondary color for dark theme
      secondaryContainer: Color(0xFF0D47A1), // Darker container for contrast
      surface: darkBackground,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: darkTextColor,
      outline: Color(0xFF757575), // Brighter outline for dark mode
      outlineVariant: Color(0xFF424242), // Appropriate outline variant
      shadow: Color(0x80000000), // Stronger shadow for dark theme
      scrim: Color(0x99000000), // Slightly denser scrim
      error: Colors.red.shade300, // Brighter error color for dark mode
    ),
    primaryColorLight: primaryColor,
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF2C2C2C), // Darker app bar
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
    ).apply(bodyColor: darkTextColor, displayColor: darkTextColor),
    cardTheme: CardThemeData(
      color: cardDark,
      shadowColor: Colors.black87,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black, // Better contrast on orange buttons
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
    ),
    iconTheme:
        IconThemeData(color: primaryColor), // Using primary color for icons
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withAlpha(100),
      selectionHandleColor: primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xFF1E1E1E),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFF424242)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.white70),
      hintStyle: TextStyle(color: Colors.white38),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.white24,
      thickness: 1,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xFF282828),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Color(0xFF323232),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
