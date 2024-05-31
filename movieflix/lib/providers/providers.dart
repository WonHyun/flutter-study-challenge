import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflix/global/theme.dart';
import 'package:movieflix/providers/notifiers/theme_notifier.dart';
import 'package:movieflix/providers/states/theme_state.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier(theme: MovieflixTheme.light);
});
