import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/util/generate_util.dart';

const testConfirmationPin = "000000";

class UserMock {
  static final List<User> users = UserGenerator.getRandomUsers(userCount: 30);

  static final me = User(
    userId: UserGenerator.generateTestUserId(baseId: "Umm Jun Sick"),
    userName: "Umm Jun Sick",
    email: "dongtan.sugundoduk@umjun.sick",
    phoneNum: "1577-1577",
    birthDate: DateTime(1991, 9, 4),
    userImgPath: "https://avatars.githubusercontent.com/u/34933982?v=4",
    isCertificatedUser: true,
  );
}

class PostMock {
  static final testPosts = PostGenerator.getRandomPosts(
    postCount: 10,
    users: UserMock.users,
  );
}
