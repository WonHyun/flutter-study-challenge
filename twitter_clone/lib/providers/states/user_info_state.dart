import 'package:twitter_clone/models/user.dart';

class UserInfoState {
  final User userInfo;

  UserInfoState({
    required this.userInfo,
  });

  UserInfoState copyWith({
    User? userInfo,
  }) {
    return UserInfoState(
      userInfo: userInfo ?? this.userInfo,
    );
  }
}
