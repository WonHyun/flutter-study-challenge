import 'package:flutter/material.dart';
import 'package:pomotimer/global/colors.dart';

enum ThemeType { tomato, eggplant }

class PomodoroTheme {
  static final tomato = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ThemeColors.tomatoPrimary,
      onPrimary: Colors.white,
      secondary: Color(0xFFF9A59D),
      onSecondary: Colors.black,
      error: Color(0xffb00020),
      onError: Colors.white,
      surface: ThemeColors.tomatoPrimary,
      onSurface: Colors.white,
    ),
  );
  static final eggplant = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ThemeColors.eggplantPrimary,
      onPrimary: Colors.white,
      secondary: Color(0xFF955EE0),
      onSecondary: Colors.black,
      error: Color(0xffb00020),
      onError: Colors.white,
      surface: ThemeColors.eggplantPrimary,
      onSurface: Colors.white,
    ),
  );
}
