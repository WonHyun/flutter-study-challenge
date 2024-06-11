import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/screens/common/horizontal_divider.dart';
import 'package:twitter_clone/screens/home/widgets/post_view.dart';
import 'package:twitter_clone/tests/mock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: FaIcon(
              FontAwesomeIcons.threads,
              color: Theme.of(context).colorScheme.inverseSurface,
              size: 36,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: PostMock.testPosts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Expanded(
                child: PostView(
                  post: PostMock.testPosts[index],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: HorizontalDivider(
              color: Colors.grey.shade200,
            ),
          ),
        ),
      ],
    );
  }
}
