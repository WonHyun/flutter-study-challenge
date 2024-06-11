import 'package:flutter/material.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/screens/home/widgets/author_profile_image.dart';
import 'package:twitter_clone/screens/home/widgets/many_circle_avatar.dart';
import 'package:twitter_clone/screens/home/widgets/post_action_buttons.dart';
import 'package:twitter_clone/screens/home/widgets/post_header.dart';
import 'package:twitter_clone/screens/home/widgets/post_media_list_view.dart';

class PostView extends StatelessWidget {
  const PostView({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 12,
          top: 50,
          bottom: 50,
          child: VerticalDivider(
            thickness: 1.5,
            color: Colors.grey.shade300,
          ),
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthorProfileImage(
                  imgPath: post.authorImgPath,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostHeader(post: post),
                      const SizedBox(height: 5),
                      Text(
                        post.content,
                        style: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 10),
                      if (post.media != null)
                        PostMediaListView(medias: post.media!),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: PostActionButtons(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ManyCircleAvatar(comments: post.comments),
                const SizedBox(width: 10),
                Text(
                  "${post.comments.length} replies · ${post.likes} likes",
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .inverseSurface
                        .withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}