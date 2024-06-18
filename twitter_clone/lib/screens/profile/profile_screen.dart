import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/common/horizontal_divider.dart';
import 'package:twitter_clone/screens/home/layouts/post_view.dart';
import 'package:twitter_clone/screens/profile/components/persistent_tab_bar_header.dart';
import 'package:twitter_clone/screens/profile/layouts/user_profile_header.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userInfoProvider);
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              surfaceTintColor: Colors.transparent,
              pinned: true,
              leading: Center(
                child: FaIcon(FontAwesomeIcons.globe),
              ),
              actions: [
                FaIcon(
                  FontAwesomeIcons.instagram,
                  size: 30,
                ),
                SizedBox(width: 20),
                FaIcon(
                  FontAwesomeIcons.gripLines,
                  size: 30,
                ),
                SizedBox(width: 20),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: UserProfileHeader(user: userState.userInfo),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentTabBarHeader(
                child: TabBar(
                  labelPadding: const EdgeInsets.symmetric(vertical: 10),
                  labelColor: Theme.of(context).colorScheme.inverseSurface,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  unselectedLabelColor: Colors.grey.shade500,
                  dividerColor: Colors.grey.shade300,
                  indicatorColor: Theme.of(context).colorScheme.inverseSurface,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 1.0,
                  tabs: const [
                    Text("Threads"),
                    Text("Replies"),
                  ],
                ),
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: [
            ProfileThreadsListView(),
            ProfileRepliesListView(),
          ],
        ),
      ),
    );
  }
}

class ProfileRepliesListView extends ConsumerWidget {
  const ProfileRepliesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postProvider);
    return ListView.separated(
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
    );
  }
}

class ProfileThreadsListView extends ConsumerWidget {
  const ProfileThreadsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postProvider);
    return ListView.separated(
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
    );
  }
}
