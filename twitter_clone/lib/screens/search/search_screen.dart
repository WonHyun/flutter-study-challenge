import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/providers/notifiers/search_notifier.dart';
import 'package:twitter_clone/screens/search/components/search_user_list_item.dart';

class Searchscreen extends ConsumerStatefulWidget {
  const Searchscreen({super.key});

  static const routeName = "search";
  static const routePath = "/search";

  @override
  ConsumerState<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends ConsumerState<Searchscreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchNotifier = ref.read(searchProvider.notifier);
    return Material(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 100,
              floating: true,
              centerTitle: false,
              surfaceTintColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CupertinoTextField(
                    onChanged: (value) => searchNotifier.searchUsers(value),
                    controller: _controller,
                    placeholder: "Search",
                    placeholderStyle: TextStyle(color: Colors.grey.shade500),
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      final searchState = ref.watch(searchProvider);
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
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 15),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
