import 'package:flutter/material.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';

class PostingModalBottomPanel extends StatelessWidget {
  const PostingModalBottomPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          right: 20,
          left: 20,
          top: 20,
          bottom: context.viewInsetsBottom <= 50
              ? 50
              : context.viewInsetsBottom + 20,
        ),
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinkedText(
              text: "Anyone can reply",
              color:
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.8),
            ),
            LinkedText(
              text: "Post",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}