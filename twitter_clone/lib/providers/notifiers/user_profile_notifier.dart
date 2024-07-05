import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/user_profile.dart';
import 'package:twitter_clone/repository/authentication_repository.dart';
import 'package:twitter_clone/repository/user_profile_repository.dart';
import 'package:twitter_clone/util/generate_util.dart';

class UserProfileNotifier extends AsyncNotifier<UserProfile> {
  late final UserProfileRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfile> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository.findProfile(
        _authenticationRepository.user!.uid,
      );
      if (profile != null) {
        return UserProfile.fromJson(profile);
      }
    }

    return UserProfile.empty();
  }

  Future<void> fetchUserProfile() async {
    state = await AsyncValue.guard(
      () async {
        final profile = await _userRepository.findProfile(
          _authenticationRepository.user!.uid,
        );
        if (profile != null) {
          return UserProfile.fromJson(profile);
        } else {
          return UserProfile.empty();
        }
      },
    );
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null || state.value == null) return;
    state = const AsyncValue.loading();
    state = AsyncData(
      state.value!.copyWith(
        userId: credential.user?.uid,
        email: credential.user?.email,
        avatarPath: credential.user?.photoURL,
        createdAt: DateTime.now(),
        displayUserId:
            UserGenerator.generateUserId(baseId: state.value!.userName),
      ),
    );
    await _userRepository.createProfile(state.value!);
  }

  Future<void> _updateUserProfileInfo(Map<String, dynamic> data) async {
    if (state.value == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _userRepository.updateProfileInfo(state.value!.userId, data);
      return state.value!.copyWithMap(map: data);
    });
  }

  Future<void> onAvatarUpload(String avatarPath) async {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.copyWith(avatarPath: avatarPath),
    );
    await _userRepository.updateProfileInfo(
      state.value!.userId,
      {"avatarPath": avatarPath},
    );
  }

  Future<void> editUserProfile({
    required String description,
  }) async {
    if (state.value == null) return;
    await _updateUserProfileInfo({"description": description});
  }

  Future<void> editInterests({
    required Map<String, List<String>>? interests,
  }) async {
    if (state.value == null || interests == null) return;
    await _updateUserProfileInfo({"interests": interests});
  }

  void updateUserName(String? userName) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        userName: userName,
      ),
    );
  }

  void updateEmail(String? email) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        email: email,
      ),
    );
  }

  void updatePhoneNum(String? phoneNum) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        phoneNum: phoneNum,
      ),
    );
  }

  void updateBirthDate(DateTime? birthday) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        birthday: birthday,
      ),
    );
  }

  void updateAgreementStatus(PolicyType policyType, bool isAgree) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        agreementStatus: {
          ...state.value!.agreementStatus,
          policyType: isAgree,
        },
      ),
    );
  }

  void updateInterests(Map<String, List<String>> interests) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        interests: interests,
      ),
    );
  }

  void updateDetails(String category, List<String> details) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        interests: {
          ...state.value!.interests,
          category: details,
        },
      ),
    );
  }

  void addDetail(String category, String detail) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        interests: {
          ...state.value!.interests,
          category: [...state.value!.interests[category] ?? [], detail],
        },
      ),
    );
  }

  void removeDetail(String category, String detail) {
    if (state.value == null || state.value!.interests[category] == null) return;
    state = AsyncData(
      state.value!.copyWith(
        interests: {
          ...state.value!.interests,
          category: state.value!.interests[category]!
              .where((value) => value != detail)
              .toList(),
        },
      ),
    );
  }

  void resetAllInterests() {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        interests: {},
      ),
    );
  }

  void resetUserInfo() {
    state = AsyncData(UserProfile.empty());
  }
}

final userProvider = AsyncNotifierProvider<UserProfileNotifier, UserProfile>(
  () => UserProfileNotifier(),
);
