import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/notifiers/search_post_notifier.dart';
import 'package:twitter_clone/screens/common/horizontal_divider.dart';
import 'package:twitter_clone/screens/common/type_list_item.dart';
import 'package:twitter_clone/screens/home/layouts/post_view.dart';

class SearchPostListView extends ConsumerWidget {
  const SearchPostListView({
    super.key,
    required this.keyword,
  });

  final String keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: TypeListItem(
                  text: "Popular",
                  isSelected: true,
                  onTap: () => {},
                  height: 40,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TypeListItem(
                  text: "Recently",
                  isSelected: false,
                  onTap: () => {},
                  height: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Builder(
          builder: (context) {
            final searchState = ref.watch(searchPostProvider(keyword));
            if (searchState.isLoading) {
              return const CupertinoActivityIndicator();
            } else if (searchState.value != null &&
                searchState.value!.postResult.isNotEmpty) {
              final posts = searchState.value!.postResult;
              return ListView.separated(
                shrinkWrap: true,
                primary: false,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostView(
                    post: posts[index],
                  );
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: HorizontalDivider(
                    color: Colors.grey.shade200,
                  ),
                ),
              );
            } else {
              return Text(
                "Cannot Found '${searchState.value?.keyword}' posts",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
