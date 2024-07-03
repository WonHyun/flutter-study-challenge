import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/repository/authentication_repository.dart';

class SignUpNotifier extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(String email, String password) async {
    final user = ref.read(userProvider.notifier);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.signUp(
          email,
          password,
        );
        await user.createProfile(userCredential);
      },
    );
  }
}

final signUpProvider = AsyncNotifierProvider<SignUpNotifier, void>(
  () => SignUpNotifier(),
);
