import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/providers/notifiers/posting_notifier.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';

class PostingModalBottomPanel extends ConsumerStatefulWidget {
  const PostingModalBottomPanel({
    super.key,
  });

  @override
  ConsumerState<PostingModalBottomPanel> createState() =>
      _PostingModalBottomPanelState();
}

class _PostingModalBottomPanelState
    extends ConsumerState<PostingModalBottomPanel> {
  Future<void> _onPostTap(WidgetRef ref) async {
    FocusScope.of(context).unfocus();
    await ref.read(postingProvider.notifier).completePosting();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final postingState = ref.watch(postingProvider);
    final postingNotifier = ref.read(postingProvider.notifier);
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
              onTap: () => postingNotifier.updateIsAllowedComment(
                  !(postingState.value?.isAllowedComment ?? true)),
              text: postingState.value?.isAllowedComment ?? true
                  ? "Anyone can reply"
                  : "Not allowed reply",
              color:
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.8),
            ),
            LinkedText(
              onTap: (postingState.value?.content.isEmpty ?? true) ||
                      postingState.isLoading
                  ? null
                  : () => _onPostTap(ref),
              text: "Post",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: (postingState.value?.content.isEmpty ?? true) ||
                      postingState.isLoading
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
