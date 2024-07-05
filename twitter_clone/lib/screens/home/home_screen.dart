import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twitter_clone/providers/notifiers/post_notifier.dart';
import 'package:twitter_clone/screens/home/layouts/post_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  static const routeName = "home";
  static const routePath = "/home";

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final RefreshController _controller =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(postProvider).when(
          data: (post) {
            return Material(
              child: SmartRefresher(
                controller: _controller,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: () async {
                  await ref.read(postProvider.notifier).refresh();
                  _controller.refreshCompleted();
                },
                onLoading: () async {
                  await ref.read(postProvider.notifier).fetchNextPosts();
                  _controller.loadComplete();
                },
                child: post.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.threads,
                            size: 36,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "We have no threads today.\nlet's show your days.",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    : CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            centerTitle: true,
                            surfaceTintColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            title: FaIcon(
                              FontAwesomeIcons.threads,
                              color:
                                  Theme.of(context).colorScheme.inverseSurface,
                              size: 36,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: post.length,
                              itemBuilder: (context, index) {
                                return PostView(post: post[index]);
                              },
                              separatorBuilder: (context, index) =>
                                  const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            );
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
