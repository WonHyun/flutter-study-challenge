import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/providers/states/user_info_state.dart';

class UserInfoNotifier extends StateNotifier<UserInfoState> {
  UserInfoNotifier(super.state);

  void updateUserInfo(User userInfo) {
    state = state.copyWith(userInfo: userInfo);
  }

  void updateUserName(String userName) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        userName: userName,
      ),
    );
  }

  void updateEmail(String email) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        email: email,
      ),
    );
  }

  void updatePhoneNum(String phoneNum) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        phoneNum: phoneNum,
      ),
    );
  }

  void updateBirthDate(DateTime birthdate) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        birthDate: birthdate,
      ),
    );
  }

  void updateAgreementStatus(PolicyType policyType, bool isAgree) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        agreementStatus: {
          ...state.userInfo.agreementStatus,
          policyType: isAgree
        },
      ),
    );
  }
}
