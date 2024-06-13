import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/comment.dart';
import 'package:twitter_clone/providers/providers.dart';

class ManyCircleAvatar extends StatelessWidget {
  const ManyCircleAvatar({
    super.key,
    required this.comments,
  });

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final userState = ref.watch(userInfoProvider);
          switch (comments.length) {
            case 0:
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 15,
                      foregroundImage:
                          NetworkImage(userState.userInfo.userImgPath ?? ""),
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
                      foregroundImage: NetworkImage(comments[0].authorImgPath),
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
                        foregroundImage:
                            NetworkImage(comments[1].authorImgPath),
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
                        foregroundImage:
                            NetworkImage(comments[0].authorImgPath),
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
                      foregroundImage: NetworkImage(comments[0].authorImgPath),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: CircleAvatar(
                      radius: 8,
                      foregroundImage: NetworkImage(comments[1].authorImgPath),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 15,
                    child: CircleAvatar(
                      radius: 6,
                      foregroundImage: NetworkImage(comments[2].authorImgPath),
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
