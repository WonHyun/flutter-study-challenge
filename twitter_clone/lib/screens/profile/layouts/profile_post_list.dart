import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/common/horizontal_divider.dart';
import 'package:twitter_clone/screens/home/layouts/post_view.dart';

class ProfilePostList extends StatelessWidget {
  const ProfilePostList({
    super.key,
    required this.tabType,
  });

  final ProfileTab tabType;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final postState = ref.watch(postProvider);
      return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          itemCount: postState.posts.length,
          itemBuilder: (context, index) {
            return PostView(
              post: postState.posts[index],
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
    });
  }
}
