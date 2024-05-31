import 'package:flutter/material.dart';
import 'package:movieflix/global/colors.dart';

class MovieflixTheme {
  static final light = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ThemeColors.movieflixPrimary,
      onPrimary: Colors.white,
      secondary: Color(0xFF2C5EAD),
      onSecondary: Colors.black,
      error: Color(0xffb00020),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    fontFamily: "Montserrat",
  );
  static final dark = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ThemeColors.movieflixPrimary,
      onPrimary: Colors.white,
      secondary: Color(0xFF2C5EAD),
      onSecondary: Colors.black,
      error: Color(0xffb00020),
      onError: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
    ),
    fontFamily: "Montserrat",
  );
}
