import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/providers/notifiers/activity_notifier.dart';
import 'package:twitter_clone/providers/notifiers/main_screen_notifier.dart';
import 'package:twitter_clone/providers/notifiers/pin_verify_notifier.dart';
import 'package:twitter_clone/providers/notifiers/post_notifier.dart';
import 'package:twitter_clone/providers/notifiers/posting_notifier.dart';
import 'package:twitter_clone/providers/notifiers/setting_notifier.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/providers/notifiers/user_search_notifier.dart';
import 'package:twitter_clone/providers/states/activity_state.dart';
import 'package:twitter_clone/providers/states/main_screen_state.dart';
import 'package:twitter_clone/providers/states/pin_verify_state.dart';
import 'package:twitter_clone/providers/states/post_state.dart';
import 'package:twitter_clone/providers/states/posting_state.dart';
import 'package:twitter_clone/providers/states/setting_state.dart';
import 'package:twitter_clone/providers/states/user_search_state.dart';
import 'package:twitter_clone/repository/setting_repository.dart';
import 'package:twitter_clone/tests/mock.dart';
import 'package:twitter_clone/util/date_util.dart';
import 'package:twitter_clone/util/generate_util.dart';

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

final postingProvider = StateNotifierProvider<PostingNotifier, PostingState>(
  (ref) {
    return PostingNotifier(
      state: PostingState(
        post: Post(
          postId: uuid.v4(),
          authorId: ref.read(userProvider).value?.userId ?? "",
          authorName: ref.read(userProvider).value?.userName ?? "",
          authorImgPath: ref.read(userProvider).value?.avatarPath ?? "",
        ),
      ),
      ref: ref,
    );
  },
);

final activityProvider = StateNotifierProvider<ActivityNotifier, ActivityState>(
  (ref) {
    ActivityMock.testActivitys
        .sort((a, b) => compareDateTimeDescending(a.timestamp, b.timestamp));
    return ActivityNotifier(
      ActivityState(
        currentType: ActivityType.all,
        activitys: ActivityMock.testActivitys,
        filteredActivitys: ActivityMock.testActivitys,
      ),
    );
  },
);

final searchProvider =
    StateNotifierProvider<UserSearchNotifier, UserSearchState>(
  (ref) {
    return UserSearchNotifier(
      UserSearchState(result: UserMock.users),
    );
  },
);

final settingProvider = NotifierProvider<SettingNotifier, SettingState>(
  () => SettingNotifier(
    repository: SettingRepository(),
  ),
);
