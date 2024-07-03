import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/providers/notifiers/post_notifier.dart';
import 'package:twitter_clone/screens/common/drag_handle.dart';

class PostMoreActionList extends ConsumerWidget {
  const PostMoreActionList({
    super.key,
    required this.post,
    required this.onTapReport,
  });

  final Post post;
  final Function() onTapReport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postNotifier = ref.read(postProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
        bottom: 50,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DragHandle(),
          const SizedBox(height: 15),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade100
                  : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        onTap: () => {},
                        title: const Text(
                          "Unfollow",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () => {},
                        title: const Text(
                          "Mute",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Positioned.fill(
                    child: Divider(thickness: 0.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade100
                  : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        onTap: () {
                          postNotifier.hidePost(post);
                          Navigator.pop(context);
                        },
                        title: const Text(
                          "Hide",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: onTapReport,
                        title: const Text(
                          "Report",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Positioned.fill(
                    child: Divider(thickness: 0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
