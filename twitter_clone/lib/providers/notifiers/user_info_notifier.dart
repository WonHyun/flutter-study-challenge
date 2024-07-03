import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/user_profile.dart';
import 'package:twitter_clone/providers/states/user_info_state.dart';

class UserInfoNotifier extends StateNotifier<UserInfoState> {
  UserInfoNotifier(super.state);

  void updateUserInfo(UserProfile userInfo) {
    state = state.copyWith(userInfo: userInfo);
  }

  void updateUserName(String? userName) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        userName: userName,
      ),
    );
  }

  void updateEmail(String? email) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        email: email,
      ),
    );
  }

  void updatePhoneNum(String? phoneNum) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        phoneNum: phoneNum,
      ),
    );
  }

  void updateBirthDate(DateTime? birthday) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        birthday: birthday,
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

  void updateInterests(Map<String, List<String>> interests) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        interests: interests,
      ),
    );
  }

  void updateDetails(String category, List<String> details) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        interests: {
          ...state.userInfo.interests,
          category: details,
        },
      ),
    );
  }

  void addDetail(String category, String detail) {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        interests: {
          ...state.userInfo.interests,
          category: [...state.userInfo.interests[category] ?? [], detail],
        },
      ),
    );
  }

  void removeDetail(String category, String detail) {
    if (state.userInfo.interests[category] != null) {
      state = state.copyWith(
        userInfo: state.userInfo.copyWith(
          interests: {
            ...state.userInfo.interests,
            category: state.userInfo.interests[category]!
                .where((value) => value != detail)
                .toList(),
          },
        ),
      );
    }
  }

  void resetAllInterests() {
    state = state.copyWith(
      userInfo: state.userInfo.copyWith(
        interests: {},
      ),
    );
  }

  void resetUserInfo() {
    state = state.copyWith(userInfo: null);
  }
}
