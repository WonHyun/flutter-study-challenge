import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/providers/notifiers/post_notifier.dart';
import 'package:twitter_clone/screens/home/layouts/post_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  static const routeName = "home";
  static const routePath = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(postProvider).when(
          data: (post) {
            return Material(
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
                      itemCount: post.length,
                      itemBuilder: (context, index) {
                        return PostView(post: post[index]);
                      },
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                    ),
                  ),
                ],
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
