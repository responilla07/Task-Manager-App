import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.dark(primary: AppColors.primary),
    brightness: Brightness.dark,
  );
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    colorScheme:  ColorScheme.light(primary: AppColors.primary),
    brightness: Brightness.light,
  );
}

class AppColors {
  static var logoPrimary = const Color(0xff1e4be7);
  static var primary = const Color(0xff5b24f3);
  static var primaryL = const Color(0xff7b4bf6);
  static var secondary = const Color(0xff966ef8);
  static var secondaryL = const Color(0xffb699f9);
  static var green = const Color.fromARGB(255, 77, 196, 93);
  static var orage = const Color.fromARGB(255, 255, 158, 67);
  static var red = const Color.fromARGB(255, 223, 58, 58);
  static var grey = const Color.fromARGB(255, 134, 137, 148);
}
