import 'package:twitter_clone/global/enum.dart';

class UserProfile {
  final String userId;
  final String? userName;
  final String? email;
  final String? phoneNum;
  final DateTime? birthday;
  final Map<PolicyType, bool> agreementStatus;
  final Map<String, List<String>> interests;
  final String? avatarPath;
  final bool? isCertificatedUser;
  final List<UserProfile> followers;
  final List<UserProfile> followings;
  final int followerTotalCounts;
  final int follwingTotalCounts;
  final String description;
  final DateTime? createdAt;

  UserProfile({
    this.userId = "",
    this.userName,
    this.email,
    this.phoneNum,
    this.birthday,
    this.agreementStatus = const {},
    this.interests = const {},
    this.avatarPath,
    this.isCertificatedUser,
    this.followers = const [],
    this.followings = const [],
    this.followerTotalCounts = 0,
    this.follwingTotalCounts = 0,
    this.description = "",
    this.createdAt,
  });

  UserProfile copyWith({
    String? userId,
    String? userName,
    String? email,
    String? phoneNum,
    DateTime? birthday,
    Map<PolicyType, bool>? agreementStatus,
    Map<String, List<String>>? interests,
    String? avatarPath,
    bool? isCertificatedUser,
    List<UserProfile>? followers,
    List<UserProfile>? followings,
    int? followerTotalCounts,
    int? follwingTotalCounts,
    String? description,
    DateTime? createdAt,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNum: phoneNum ?? this.phoneNum,
      birthday: birthday ?? this.birthday,
      agreementStatus: agreementStatus ?? this.agreementStatus,
      interests: interests ?? this.interests,
      avatarPath: avatarPath ?? this.avatarPath,
      isCertificatedUser: isCertificatedUser ?? this.isCertificatedUser,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      followerTotalCounts: followerTotalCounts ?? this.followerTotalCounts,
      follwingTotalCounts: follwingTotalCounts ?? this.follwingTotalCounts,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  UserProfile copyWithMap({required Map<String, dynamic> map}) {
    return UserProfile(
      userId: map["userId"] ?? userId,
      userName: map["userName"] ?? userName,
      email: map["email"] ?? email,
      phoneNum: map["phoneNum"] ?? phoneNum,
      birthday: map["birthday"] ?? birthday,
      agreementStatus: map["agreementStatus"] ?? agreementStatus,
      interests: map["interests"] ?? interests,
      avatarPath: map["avatarPath"] ?? avatarPath,
      isCertificatedUser: map["isCertificatedUser"] ?? isCertificatedUser,
      followers: map["followers"] ?? followers,
      followings: map["followings"] ?? followings,
      followerTotalCounts: map["followerTotalCounts"] ?? followerTotalCounts,
      follwingTotalCounts: map["follwingTotalCounts"] ?? follwingTotalCounts,
      description: map["description"] ?? description,
      createdAt: map["createdAt"] ?? createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userName": userName,
      "email": email,
      "phoneNum": phoneNum,
      "birthDate": birthday?.toIso8601String(),
      "agreementStatus": agreementStatus
          .map((key, value) => MapEntry(key.toString().split(".").last, value)),
      "interests": interests,
      "userImgPath": avatarPath,
      "isCertificatedUser": isCertificatedUser,
      "followers": const [],
      "followings": const [],
      "followerTotalCounts": followerTotalCounts,
      "follwingTotalCounts": follwingTotalCounts,
      "description": description,
      "createdAt": createdAt?.toIso8601String(),
    };
  }

  UserProfile.fromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        userName = json["userName"],
        email = json["email"],
        phoneNum = json["phoneNum"],
        birthday = json["birthDate"] != null
            ? DateTime.parse(json["birthDate"])
            : null,
        agreementStatus = (json["agreementStatus"] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
              PolicyType.values
                  .firstWhere((e) => e.toString().split(".").last == key),
              value as bool),
        ),
        interests = (json["interests"] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, List<String>.from(value)),
        ),
        avatarPath = json["userImgPath"],
        isCertificatedUser = json["isCertificatedUser"],
        followers = const [],
        followings = const [],
        followerTotalCounts = json["followerTotalCounts"],
        follwingTotalCounts = json["follwingTotalCounts"],
        description = json["description"],
        createdAt = json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null;

  UserProfile.empty()
      : userId = "",
        userName = "",
        email = "",
        phoneNum = "",
        birthday = null,
        agreementStatus = {},
        interests = {},
        avatarPath = "",
        isCertificatedUser = false,
        followers = const [],
        followings = const [],
        followerTotalCounts = 0,
        follwingTotalCounts = 0,
        description = "",
        createdAt = null;
}
