import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/home/components/many_circle_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Jane",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "jane_mobbin",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "threads.net",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text("Plant enthusiast!"),
                            const Row(
                              children: [
                                ManyCircleAvatar(
                                  imgPaths: [],
                                ),
                                Text("2 followers"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RoundedButton(
                          onTap: () => {},
                          text: "Edit profile",
                          height: 40,
                          fontWeight: FontWeight.w500,
                          borderRadius: 10,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RoundedButton(
                          onTap: () => {},
                          text: "Share profile",
                          height: 40,
                          fontWeight: FontWeight.w500,
                          borderRadius: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: PersistentTabBarHeader(),
            pinned: true,
          ),
        ],
      ),
    );
  }
}

class PersistentTabBarHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBar(
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
    );
  }

  @override
  double get maxExtent => 42;

  @override
  double get minExtent => 42;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
