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
            title: FaIcon(
              FontAwesomeIcons.threads,
              color: Theme.of(context).colorScheme.inverseSurface,
              size: 36,
            ),
          ),
        ),
        SizedBox(
          height: 500,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: testPosts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: PostView(
                  post: testPosts[index],
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
        ),
      ],
    );
  }
}
