import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/profile/components/persistent_tab_bar_header.dart';
import 'package:twitter_clone/screens/profile/layouts/profile_replies_list_view.dart';
import 'package:twitter_clone/screens/profile/layouts/profile_threads_list_view.dart';
import 'package:twitter_clone/screens/profile/layouts/user_profile_header.dart';
import 'package:twitter_clone/screens/setting/setting_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    super.key,
  });

  static const routeName = "profile";
  static const routePath = "/profile";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userInfoProvider);
    return Material(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                pinned: true,
                leading: const Center(
                  child: FaIcon(FontAwesomeIcons.globe),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => {},
                    child: const FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => context.push(SettingScreen.routePath),
                    child: const FaIcon(
                      FontAwesomeIcons.gripLines,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
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
                    indicatorColor:
                        Theme.of(context).colorScheme.inverseSurface,
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
      ),
    );
  }
}
