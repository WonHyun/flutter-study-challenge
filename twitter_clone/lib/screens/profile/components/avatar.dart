import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/models/user_profile.dart';
import 'package:twitter_clone/providers/notifiers/avatar_notifier.dart';

class Avatar extends ConsumerWidget {
  const Avatar({
    super.key,
    required this.user,
    this.size = 28,
  });

  final UserProfile user;
  final double size;

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return isLoading
        ? Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const CircularProgressIndicator.adaptive(),
          )
        : GestureDetector(
            onTap: () => _onAvatarTap(ref),
            child: CircleAvatar(
              radius: size,
              foregroundImage: NetworkImage(user.avatarPath ?? ""),
              child: Text(user.userName?.substring(0, 2) ?? ""),
            ),
          );
  }
}
