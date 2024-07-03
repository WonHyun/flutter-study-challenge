import 'package:twitter_clone/models/user_profile.dart';
import 'package:twitter_clone/util/generate_util.dart';

const testConfirmationPin = "000000";

class UserMock {
  static final List<UserProfile> users =
      UserGenerator.getRandomUsers(userCount: 30);

  static final me = UserProfile(
    userName: "Umm Jun Sick",
    // email: "dongtan.sugundoduk@umjun.sick",
    email: "a@naver.com",
    phoneNum: "1577-1577",
    birthday: DateTime(1991, 9, 4),
    avatarPath: "https://avatars.githubusercontent.com/u/34933982?v=4",
    isCertificatedUser: true,
    description: "The master of avoid",
    // followers: UserGenerator.getRandomUsers(userCount: 12),
    // followerTotalCounts: 12,
  );
}

class PostMock {
  static final testPosts = PostGenerator.getRandomPosts(
    postCount: 10,
    users: UserMock.users,
  );
}

class ActivityMock {
  static final testActivitys =
      ActivityGenerator.getRandomActivitys(activityCount: 20);
}
