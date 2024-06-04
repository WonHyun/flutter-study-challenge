import 'package:flutter/material.dart';
import 'package:twitter_clone/global/theme.dart';
import 'package:twitter_clone/screens/login/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TwitterTheme.light,
      home: const LoginScreen(),
    );
  }
}
