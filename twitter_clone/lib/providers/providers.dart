import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/theme.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/providers/notifiers/sign_up_notifier.dart';
import 'package:twitter_clone/providers/notifiers/theme_notifier.dart';
import 'package:twitter_clone/providers/states/user_info_state.dart';
import 'package:twitter_clone/providers/states/theme_state.dart';
import 'package:twitter_clone/util/generate_util.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier(theme: TwitterTheme.light);
});

final userInfoProvider =
    StateNotifierProvider<UserInfoNotifier, UserInfoState>((ref) {
  return UserInfoNotifier(UserInfoState(userInfo: User(id: uuid.v4())));
});
