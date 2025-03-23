import 'package:flutter/material.dart';
import 'package:task_manager_ostad/app/styling/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  colorSchemeSeed: themeColor,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide.none,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide.none,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide.none,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      fixedSize: const Size.fromWidth(double.maxFinite),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
);
