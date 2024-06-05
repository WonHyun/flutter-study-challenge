import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/theme.dart';
import 'package:twitter_clone/providers/notifiers/theme_notifier.dart';
import 'package:twitter_clone/providers/states/theme_state.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier(theme: TwitterTheme.light);
});
