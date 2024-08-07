import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';

class ManyCircleAvatar extends ConsumerWidget {
  const ManyCircleAvatar({
    super.key,
    required this.imgPaths,
  });

  final List<String> imgPaths;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Builder(
        builder: (context) {
          switch (imgPaths.length) {
            case 0:
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 15,
                      foregroundImage: userState.value == null ||
                              userState.value!.avatarPath!.isEmpty
                          ? null
                          : NetworkImage(userState.value?.avatarPath ?? ""),
                    ),
                  ),
                ],
              );
            case 1:
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 15,
                      foregroundImage: NetworkImage(imgPaths[0]),
                    ),
                  ),
                ],
              );
            case 2:
              return Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        radius: 10,
                        foregroundImage: NetworkImage(imgPaths[1]),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: CircleAvatar(
                        radius: 10,
                        foregroundImage: NetworkImage(imgPaths[0]),
                      ),
                    ),
                  ),
                ],
              );
            default:
              return Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      foregroundImage: NetworkImage(imgPaths[0]),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: CircleAvatar(
                      radius: 8,
                      foregroundImage: NetworkImage(imgPaths[1]),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 15,
                    child: CircleAvatar(
                      radius: 6,
                      foregroundImage: NetworkImage(imgPaths[2]),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
