import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/common/horizontal_divider.dart';
import 'package:twitter_clone/screens/home/layouts/post_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: FaIcon(
              FontAwesomeIcons.threads,
              color: Theme.of(context).colorScheme.inverseSurface,
              size: 36,
            ),
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          itemCount: postState.posts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Expanded(
                child: PostView(
                  post: postState.posts[index],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: HorizontalDivider(
              color: Colors.grey.shade200,
            ),
          ),
        ),
      ],
    );
  }
}
