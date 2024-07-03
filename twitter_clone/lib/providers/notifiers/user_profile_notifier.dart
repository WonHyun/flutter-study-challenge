import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/user_profile.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/repository/authentication_repository.dart';
import 'package:twitter_clone/repository/user_profile_repository.dart';

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

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final profile = ref.read(userInfoProvider).userInfo.copyWith(
          userId: credential.user?.uid,
          email: credential.user?.email,
          avatarPath: credential.user?.photoURL,
          createdAt: DateTime.now(),
        );
    await _userRepository.createProfile(profile);
    state = AsyncData(profile);
  }

  Future<void> updateUserProfileInfo(Map<String, dynamic> data) async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWithMap(map: data));
    await _userRepository.updateProfileInfo(state.value!.userId, data);
  }
}

final userProvider = AsyncNotifierProvider<UserProfileNotifier, UserProfile>(
  () => UserProfileNotifier(),
);
