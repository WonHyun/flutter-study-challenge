import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/providers/notifiers/post_notifier.dart';
import 'package:twitter_clone/screens/common/horizontal_divider.dart';
import 'package:twitter_clone/screens/home/layouts/post_view.dart';

class ProfilePostList extends ConsumerWidget {
  const ProfilePostList({
    super.key,
    required this.tabType,
  });

  final ProfileTab tabType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(postProvider).when(
          data: (post) {
            if (post.isEmpty) {
              return Center(
                child: Text(
                  "No ${tabType.name}.",
                  style: const TextStyle(color: Colors.grey),
                ),
              );
            } else {
              return ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: post.length,
                  itemBuilder: (context, index) {
                    return PostView(
                      post: post[index],
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: HorizontalDivider(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              );
            }
          },
          error: (err, stack) => Center(
            child: Text("error: $err"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
