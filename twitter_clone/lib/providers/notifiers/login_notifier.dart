import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/repository/authentication_repository.dart';

class LoginNotifier extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> loginWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _authRepo.login(email, password);
        ref.read(userProvider.notifier).fetchUserProfile();
      },
    );
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _authRepo.logout();
        ref.read(userProvider.notifier).resetUserInfo();
      },
    );
  }
}

final loginProvider = AsyncNotifierProvider<LoginNotifier, void>(
  () => LoginNotifier(),
);
