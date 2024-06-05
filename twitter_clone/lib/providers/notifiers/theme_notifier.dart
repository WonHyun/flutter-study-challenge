import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/theme.dart';
import 'package:twitter_clone/providers/states/theme_state.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier({required ThemeData theme}) : super(ThemeState(theme: theme));

  void updateTheme(ThemeData theme) {
    state = state.copyWith(theme: theme);
  }

  void switchTheme(bool isDarkMode) {
    updateTheme(isDarkMode ? TwitterTheme.dark : TwitterTheme.light);
  }
}
