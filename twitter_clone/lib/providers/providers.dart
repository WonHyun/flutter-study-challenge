import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/theme.dart';
import 'package:twitter_clone/providers/notifiers/main_screen_notifier.dart';
import 'package:twitter_clone/providers/notifiers/pin_verify_notifier.dart';
import 'package:twitter_clone/providers/notifiers/user_info_notifier.dart';
import 'package:twitter_clone/providers/notifiers/theme_notifier.dart';
import 'package:twitter_clone/providers/states/main_screen_state.dart';
import 'package:twitter_clone/providers/states/pin_verify_state.dart';
import 'package:twitter_clone/providers/states/user_info_state.dart';
import 'package:twitter_clone/providers/states/theme_state.dart';
import 'package:twitter_clone/tests/mock.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier(
    theme: TwitterTheme.light,
  );
});

final userInfoProvider =
    StateNotifierProvider<UserInfoNotifier, UserInfoState>((ref) {
  return UserInfoNotifier(
    UserInfoState(
      // TODO: should be replace to login user info
      userInfo: testUserInfo,
    ),
  );
});

final pinVerifyProvider =
    StateNotifierProvider<PinVerifyNotifier, PinVerifyState>((ref) {
  return PinVerifyNotifier(const PinVerifyState());
});

final mainScreenProvider =
    StateNotifierProvider<MainScreenNotifier, MainScreenState>((ref) {
  return MainScreenNotifier(
    const MainScreenState(
      currentScreen: MainScreenType.home,
    ),
  );
});
