import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/color.dart';
import 'package:twitter_clone/global/enum.dart';

class ActivityTypeIcon extends StatelessWidget {
  const ActivityTypeIcon({
    super.key,
    required this.type,
    this.size = 18,
  });

  final ActivityType type;
  final double size;

  Color _colorSelector(ActivityType type) {
    switch (type) {
      case ActivityType.all:
        return Colors.black;
      case ActivityType.replies:
        return ActivityIconColors.mentionColor;
      case ActivityType.mentions:
        return ActivityIconColors.mentionColor;
      case ActivityType.verified:
        return ActivityIconColors.mentionColor;
      case ActivityType.follow:
        return ActivityIconColors.followColor;
      case ActivityType.like:
        return ActivityIconColors.likeColor;
      case ActivityType.repost:
        return ActivityIconColors.repostColor;
      case ActivityType.quote:
        return Colors.black;
    }
  }

  IconData _iconSelector(ActivityType type) {
    switch (type) {
      case ActivityType.all:
        return FontAwesomeIcons.a;
      case ActivityType.replies:
        return FontAwesomeIcons.reply;
      case ActivityType.mentions:
        return FontAwesomeIcons.threads;
      case ActivityType.verified:
        return FontAwesomeIcons.check;
      case ActivityType.follow:
        return FontAwesomeIcons.solidUser;
      case ActivityType.like:
        return FontAwesomeIcons.solidHeart;
      case ActivityType.repost:
        return FontAwesomeIcons.share;
      case ActivityType.quote:
        return FontAwesomeIcons.quoteLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _colorSelector(type),
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
          width: 1.5,
        ),
      ),
      child: Center(
        child: FaIcon(
          _iconSelector(type),
          size: size * 0.5,
          color: Colors.white,
        ),
      ),
    );
  }
}
