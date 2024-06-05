import 'package:twitter_clone/global/enum.dart';

class User {
  final String id;
  final String? userName;
  final String? email;
  final String? phoneNum;
  final DateTime? birthDate;
  final Map<PolicyType, bool> agreementStatus;

  User({
    required this.id,
    this.userName,
    this.email,
    this.phoneNum,
    this.birthDate,
    this.agreementStatus = const {},
  });

  User copyWith({
    String? userName,
    String? email,
    String? phoneNum,
    DateTime? birthDate,
    Map<PolicyType, bool>? agreementStatus,
  }) {
    return User(
      id: id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNum: phoneNum ?? this.phoneNum,
      birthDate: birthDate ?? this.birthDate,
      agreementStatus: agreementStatus ?? this.agreementStatus,
    );
  }
}
