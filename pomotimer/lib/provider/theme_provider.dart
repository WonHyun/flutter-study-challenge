import 'package:flutter/material.dart';
import 'package:pomotimer/global/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeType _themeType = ThemeType.tomato;
  ThemeType get themeType => _themeType;

  ThemeData _theme = PomodoroTheme.tomato;
  ThemeData get theme => _theme;

  void onChangeTheme(ThemeType type) {
    switch (type) {
      case ThemeType.tomato:
        _themeType = ThemeType.tomato;
        _theme = PomodoroTheme.tomato;
      case ThemeType.eggplant:
        _themeType = ThemeType.eggplant;
        _theme = PomodoroTheme.eggplant;
    }
    notifyListeners();
  }
}
