import 'package:flutter/material.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/activity.dart';

class ActivityContentText extends StatelessWidget {
  const ActivityContentText({
    super.key,
    required this.activity,
  });

  final Activity activity;

  bool _isUseContentText(Activity activity) {
    switch (activity.type) {
      case ActivityType.all:
      case ActivityType.replies:
      case ActivityType.verified:
      case ActivityType.follow:
      case ActivityType.like:
      case ActivityType.quote:
        return false;
      case ActivityType.repost:
      case ActivityType.mentions:
        return true;
    }
  }

  String _getGuideText(Activity activity) {
    switch (activity.type) {
      case ActivityType.all:
      case ActivityType.quote:
      case ActivityType.verified:
      case ActivityType.replies:
        return "";
      case ActivityType.mentions:
        return "Mentioned you";
      case ActivityType.follow:
        return "Followed you";
      case ActivityType.like:
      case ActivityType.repost:
        return activity.originalPostContent;
    }
  }

  String _getContentText(Activity activity) {
    switch (activity.type) {
      case ActivityType.all:
      case ActivityType.replies:
      case ActivityType.verified:
      case ActivityType.follow:
      case ActivityType.like:
      case ActivityType.quote:
        return "";
      case ActivityType.mentions:
      case ActivityType.repost:
        return activity.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getGuideText(activity),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w300,
          ),
        ),
        if (_isUseContentText(activity))
          Text(
            _getContentText(activity),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
      ],
    );
  }
}
