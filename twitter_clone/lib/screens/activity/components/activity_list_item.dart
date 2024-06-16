import 'package:flutter/material.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/activity.dart';
import 'package:twitter_clone/screens/activity/components/activity_content_text.dart';
import 'package:twitter_clone/screens/activity/components/activity_type_icon.dart';
import 'package:twitter_clone/screens/activity/components/following_button.dart';
import 'package:twitter_clone/screens/home/components/certification_mark.dart';
import 'package:twitter_clone/util/date_util.dart';

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({
    super.key,
    required this.activity,
    required this.onDismissed,
  });

  final Activity activity;
  final Function(Activity) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(activity.activityId),
      onDismissed: (direction) => onDismissed(activity),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 3),
                child: CircleAvatar(
                  radius: 16,
                  foregroundImage: NetworkImage(
                    activity.user.userImgPath ?? "",
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ActivityTypeIcon(type: activity.type),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 4,
                              child: Text(
                                activity.user.userId,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (activity.user.isCertificatedUser ?? false)
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: CertificationMark(),
                              ),
                            const SizedBox(width: 5),
                            Flexible(
                              flex: 1,
                              child: Text(
                                getTimeAgoFormat(activity.timestamp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ActivityContentText(activity: activity),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  if (activity.type == ActivityType.follow)
                    const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: FollowingButton(isAlreadyFollowing: true),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
