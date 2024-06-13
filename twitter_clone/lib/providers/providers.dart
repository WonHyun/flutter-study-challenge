import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/theme.dart';
import 'package:twitter_clone/providers/notifiers/main_screen_notifier.dart';
import 'package:twitter_clone/providers/notifiers/pin_verify_notifier.dart';
import 'package:twitter_clone/providers/notifiers/post_notifier.dart';
import 'package:twitter_clone/providers/notifiers/user_info_notifier.dart';
import 'package:twitter_clone/providers/notifiers/theme_notifier.dart';
import 'package:twitter_clone/providers/states/main_screen_state.dart';
import 'package:twitter_clone/providers/states/pin_verify_state.dart';
import 'package:twitter_clone/providers/states/post_state.dart';
import 'package:twitter_clone/providers/states/user_info_state.dart';
import 'package:twitter_clone/providers/states/theme_state.dart';
import 'package:twitter_clone/tests/mock.dart';
import 'package:twitter_clone/util/date_util.dart';

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

final postProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  PostMock.testPosts
      .sort((a, b) => compareDateTimeDescending(a.timestamp, b.timestamp));
  return PostNotifier(
    PostState(
      // TODO: should be replace fetch post list
      posts: PostMock.testPosts,
    ),
  );
});
