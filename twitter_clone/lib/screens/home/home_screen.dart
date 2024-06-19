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

  static const routeName = "home";
  static const routePath = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postProvider);
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: FaIcon(
              FontAwesomeIcons.threads,
              color: Theme.of(context).colorScheme.inverseSurface,
              size: 36,
            ),
          ),
          SliverToBoxAdapter(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              primary: false,
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
          ),
        ],
      ),
    );
  }
}
