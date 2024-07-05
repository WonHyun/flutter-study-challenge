import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/notifiers/search_user_notifier.dart';
import 'package:twitter_clone/screens/search/components/search_user_list_item.dart';

class SearchUserListView extends ConsumerWidget {
  const SearchUserListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Builder(
          builder: (context) {
            final searchState = ref.watch(searchUserProvider);
            if (searchState.isLoading) {
              return const CupertinoActivityIndicator();
            } else if (searchState.value != null &&
                searchState.value!.userResult.isNotEmpty) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: false,
                itemCount: searchState.value?.userResult.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 15),
                    child: SearchUserListItem(
                      user: searchState.value!.userResult[index],
                    ),
                  );
                },
              );
            } else {
              return Text(
                "Cannot Found '${searchState.value?.keyword}' user",
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
