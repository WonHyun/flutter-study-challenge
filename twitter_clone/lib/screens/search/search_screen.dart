import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/screens/search/components/search_user_list_item.dart';
import 'package:twitter_clone/tests/mock.dart';

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
    return Column(
      children: [
        AppBar(
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            "Search",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 26,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CupertinoTextField(
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
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: UserMock.users.length,
          itemBuilder: (context, index) {
            final user = UserMock.users[index];
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 15,
                ),
                child: SearchUserListItem(user: user),
              ),
            );
          },
        ),
      ],
    );
  }
}
