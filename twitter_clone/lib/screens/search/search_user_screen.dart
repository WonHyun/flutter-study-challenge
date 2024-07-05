import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/providers/notifiers/search_user_notifier.dart';
import 'package:twitter_clone/screens/search/layouts/search_user_list_view.dart';
import 'package:twitter_clone/screens/search/search_post_screen.dart';

class SearchUserScreen extends ConsumerStatefulWidget {
  const SearchUserScreen({super.key});

  static const routeName = "search";
  static const routePath = "/search";

  @override
  ConsumerState<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends ConsumerState<SearchUserScreen> {
  final TextEditingController _keywordController = TextEditingController();

  void _onSumitted(String value) {
    context.pushNamed(SearchPostScreen.routeName, extra: value);
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          suffixMode: OverlayVisibilityMode.editing,
                          suffix: GestureDetector(
                            onTap: () => _keywordController.clear(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Icon(
                                FontAwesomeIcons.solidCircleXmark,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          onSubmitted: _onSumitted,
                          onChanged: (value) => ref
                              .read(searchUserProvider.notifier)
                              .onUpdateKeywords(value),
                          controller: _keywordController,
                          placeholder: "Search",
                          placeholderStyle:
                              TextStyle(color: Colors.grey.shade500),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SearchUserListView(),
            ),
          ],
        ),
      ),
    );
  }
}
