import 'package:twitter_clone/models/user_profile.dart';

class UserInfoState {
  final UserProfile userInfo;

  UserInfoState({
    required this.userInfo,
  });

  UserInfoState copyWith({
    UserProfile? userInfo,
  }) {
    return UserInfoState(
      userInfo: userInfo ?? this.userInfo,
    );
  }
}
