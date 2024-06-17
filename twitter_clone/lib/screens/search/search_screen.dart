import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/search/components/search_user_list_item.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Consumer(
        builder: (context, ref, child) {
          final searchState = ref.watch(searchProvider);
          final searchNotifier = ref.watch(searchProvider.notifier);
          return CustomScrollView(
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
                      onChanged: (value) => searchNotifier.searchUser(value),
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
                        if (searchState.isSearching) {
                          return const CupertinoActivityIndicator();
                        } else if (searchState.result.isNotEmpty) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: searchState.result.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, left: 15),
                                child: SearchUserListItem(
                                    user: searchState.result[index]),
                              );
                            },
                          );
                        } else {
                          return Text(
                            "Cannot Found '${searchState.keyword}' user",
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
          );
        },
      ),
    );
  }
}
