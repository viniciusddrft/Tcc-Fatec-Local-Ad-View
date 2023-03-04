import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
    backgroundColor: Colors.deepPurple,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      textStyle: const TextStyle(fontSize: 20),
      foregroundColor: Colors.white,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: Colors.deepPurple,
  ),
  colorScheme: const ColorScheme(
    background: Color(0xfffbfbfb),
    brightness: Brightness.light,
    error: Colors.deepPurple,
    onBackground: Colors.black,
    onError: Colors.red,
    onPrimary: Colors.deepPurple,
    onSecondary: Colors.deepPurple,
    onSurface: Colors.black,
    primary: Colors.black,
    secondary: Colors.deepPurple,
    surface: Colors.deepPurple,
  ),
);
