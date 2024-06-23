import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/states/theme_state.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier({required ThemeMode themeMode})
      : super(ThemeState(themeMode: themeMode));

  void updateThemeMode(ThemeMode theme) {
    state = state.copyWith(themeMode: theme);
  }
}
