import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/providers/notifiers/search_post_notifier.dart';
import 'package:twitter_clone/screens/search/layouts/search_post_list_view.dart';

class SearchPostScreen extends ConsumerStatefulWidget {
  const SearchPostScreen({
    super.key,
    required this.keyword,
  });

  static const routeName = "posts";
  static const routePath = "posts";

  final String keyword;

  @override
  ConsumerState<SearchPostScreen> createState() => _SearchPostScreenState();
}

class _SearchPostScreenState extends ConsumerState<SearchPostScreen> {
  late final TextEditingController _keywordController =
      TextEditingController(text: widget.keyword);

  void _onClear() {
    _keywordController.clear();
    ref.read(searchPostProvider(widget.keyword).notifier).onUpdateKeywords("");
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
              automaticallyImplyLeading: false,
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
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(FontAwesomeIcons.arrowLeft),
                        ),
                      ),
                      Expanded(
                        child: CupertinoTextField(
                          suffixMode: OverlayVisibilityMode.editing,
                          suffix: GestureDetector(
                            onTap: _onClear,
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
                          onChanged: (value) => ref
                              .read(searchPostProvider(widget.keyword).notifier)
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
            SliverToBoxAdapter(
              child: SearchPostListView(keyword: widget.keyword),
            ),
          ],
        ),
      ),
    );
  }
}
