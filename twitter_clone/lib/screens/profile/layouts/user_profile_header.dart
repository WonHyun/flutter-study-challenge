import 'package:flutter/material.dart';
import 'package:twitter_clone/models/user_profile.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/home/components/many_circle_avatar.dart';

import '../components/avatar.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    super.key,
    required this.user,
  });

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName ?? "",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        user.displayUserId ?? "",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .inverseSurface
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "threads.net",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .inverseSurface
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ManyCircleAvatar(
                        imgPaths: user.followers
                            .sublist(
                                0,
                                user.followers.length > 2
                                    ? 2
                                    : user.followers.length)
                            .map((user) => user.avatarPath ?? "")
                            .toList(),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${user.followerTotalCounts} followers",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Avatar(user: user),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RoundedButton(
                onTap: () => {},
                text: "Edit profile",
                height: 35,
                fontWeight: FontWeight.w500,
                borderRadius: 10,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RoundedButton(
                onTap: () => {},
                text: "Share profile",
                height: 35,
                fontWeight: FontWeight.w500,
                borderRadius: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
