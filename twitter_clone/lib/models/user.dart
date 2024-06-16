import 'package:twitter_clone/global/enum.dart';

class User {
  final String userId;
  final String? userName;
  final String? email;
  final String? phoneNum;
  final DateTime? birthDate;
  final Map<PolicyType, bool> agreementStatus;
  final Map<String, List<String>> interests;
  final String? userImgPath;
  final bool? isCertificatedUser;
  final List<User> followers;
  final List<User> followings;
  final int followerTotalCounts;
  final int follwingTotalCounts;

  User({
    required this.userId,
    this.userName,
    this.email,
    this.phoneNum,
    this.birthDate,
    this.agreementStatus = const {},
    this.interests = const {},
    this.userImgPath,
    this.isCertificatedUser,
    this.followers = const [],
    this.followings = const [],
    this.followerTotalCounts = 0,
    this.follwingTotalCounts = 0,
  });

  User copyWith({
    String? userName,
    String? email,
    String? phoneNum,
    DateTime? birthDate,
    Map<PolicyType, bool>? agreementStatus,
    Map<String, List<String>>? interests,
    String? userImgPath,
    bool? isCertificatedUser,
    List<User>? followers,
    List<User>? followings,
    int? followerTotalCounts,
    int? follwingTotalCounts,
  }) {
    return User(
      userId: userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNum: phoneNum ?? this.phoneNum,
      birthDate: birthDate ?? this.birthDate,
      agreementStatus: agreementStatus ?? this.agreementStatus,
      interests: interests ?? this.interests,
      userImgPath: userImgPath ?? this.userImgPath,
      isCertificatedUser: isCertificatedUser ?? this.isCertificatedUser,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      followerTotalCounts: followerTotalCounts ?? this.followerTotalCounts,
      follwingTotalCounts: follwingTotalCounts ?? this.follwingTotalCounts,
    );
  }
}
