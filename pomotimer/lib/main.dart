import 'package:flutter/material.dart';
import 'package:pomotimer/global/colors.dart';
import 'package:pomotimer/screens/pomodoro_main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff6200ee),
          onPrimary: Colors.white,
          secondary: Color(0xff03dac6),
          onSecondary: Colors.black,
          error: Color(0xffb00020),
          onError: Colors.white,
          surface: ThemeColors.primary,
          onSurface: Colors.white,
        ),
      ),
      home: const PomodoroMainScreen(),
    );
  }
}
