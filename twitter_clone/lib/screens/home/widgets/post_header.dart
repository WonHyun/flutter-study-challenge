import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/screens/home/widgets/certification_mark.dart';
import 'package:twitter_clone/util/date_util.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              post.authorName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 5),
            if (post.isCertificatedUser) const CertificationMark(),
          ],
        ),
        Row(
          children: [
            Text(
              getTimeAgoFormat(post.timestamp),
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .inverseSurface
                    .withOpacity(0.4),
              ),
            ),
            const SizedBox(width: 14),
            GestureDetector(
              onTap: () => {},
              child: const FaIcon(
                FontAwesomeIcons.ellipsis,
                size: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
