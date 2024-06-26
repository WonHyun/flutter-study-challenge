import 'package:flutter/material.dart';
import 'package:twitter_clone/global/color.dart';

class TwitterTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ThemeColors.twitterColor,
      onPrimary: Colors.white,
      secondary: Color(0xFF2C5EAD),
      onSecondary: Colors.black,
      error: Color(0xffb00020),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceTint: Colors.transparent,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade300,
    ),
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ThemeColors.twitterColor,
      onPrimary: Colors.white,
      secondary: Color(0xFF2C5EAD),
      onSecondary: Colors.black,
      error: Color(0xffb00020),
      onError: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      surfaceTint: Colors.transparent,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade700,
    ),
  );
}
