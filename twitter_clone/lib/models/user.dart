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
  final List<User> followUsers;

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
    this.followUsers = const [],
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
    List<User>? followUsers,
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
      followUsers: followUsers ?? this.followUsers,
    );
  }
}
