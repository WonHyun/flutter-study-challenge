import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/screens/home/components/certification_mark.dart';
import 'package:twitter_clone/screens/home/layouts/post_more_action_modal.dart';
import 'package:twitter_clone/util/date_util.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.post,
  });

  final Post post;

  void _showModalBottomSheet(BuildContext context, Post post) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (context) {
        return PostMoreActionModal(post: post);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    maxLines: 1,
                    post.authorName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              if (post.isCertificatedUser)
                const Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CertificationMark(),
                  ),
                ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              getTimeAgoFormat(post.timestamp),
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .inverseSurface
                    .withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 14),
            GestureDetector(
              onTap: () => _showModalBottomSheet(context, post),
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
