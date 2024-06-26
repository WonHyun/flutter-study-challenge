import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';

class PostingModalBottomPanel extends ConsumerWidget {
  const PostingModalBottomPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postingState = ref.watch(postingProvider);
    final postingNotifier = ref.watch(postingProvider.notifier);
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
              onTap: () => postingNotifier
                  .updateIsAllowedComment(!postingState.post.isAllowedComment),
              text: postingState.post.isAllowedComment
                  ? "Anyone can reply"
                  : "Not allowed reply",
              color:
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.8),
            ),
            LinkedText(
              onTap: postingState.post.content.isEmpty
                  ? null
                  : () {
                      postingNotifier.completePosting();
                      Navigator.pop(context);
                    },
              text: "Post",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: postingState.post.content.isEmpty
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
