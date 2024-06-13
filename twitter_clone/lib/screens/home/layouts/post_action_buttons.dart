import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/models/post.dart';

class PostActionButtons extends ConsumerWidget {
  const PostActionButtons({
    super.key,
    required this.post,
  });

  final Post post;
  final double itemPadding = 15;
  final double iconSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        FaIcon(FontAwesomeIcons.heart, size: iconSize),
        SizedBox(width: itemPadding),
        if (post.isAllowedComment)
          Row(
            children: [
              FaIcon(FontAwesomeIcons.comment, size: iconSize),
              SizedBox(width: itemPadding),
            ],
          ),
        FaIcon(FontAwesomeIcons.retweet, size: iconSize),
        SizedBox(width: itemPadding),
        FaIcon(FontAwesomeIcons.paperPlane, size: iconSize),
      ],
    );
  }
}
