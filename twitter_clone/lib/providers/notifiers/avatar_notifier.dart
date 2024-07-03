import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/repository/authentication_repository.dart';
import 'package:twitter_clone/repository/user_profile_repository.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserProfileRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        final url = await _repository.uploadAvatar(file, fileName);
        await ref.read(userProvider.notifier).onAvatarUpload(url);
      },
    );
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
