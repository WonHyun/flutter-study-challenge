import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';

class PostingModalAppBar extends StatelessWidget {
  const PostingModalAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: Center(
        child: LinkedText(
          text: "Cancel",
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.inverseSurface,
          onTap: () => Navigator.pop(context),
        ),
      ),
      title: const Text(
        "New thread",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
