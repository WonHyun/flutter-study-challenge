import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostActionButtons extends StatelessWidget {
  const PostActionButtons({
    super.key,
  });

  final double itemPadding = 15;
  final double iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(FontAwesomeIcons.heart, size: iconSize),
        SizedBox(width: itemPadding),
        FaIcon(FontAwesomeIcons.comment, size: iconSize),
        SizedBox(width: itemPadding),
        FaIcon(FontAwesomeIcons.retweet, size: iconSize),
        SizedBox(width: itemPadding),
        FaIcon(FontAwesomeIcons.paperPlane, size: iconSize),
      ],
    );
  }
}
