import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/base/media_item.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/providers/notifiers/post_notifier.dart';
import 'package:twitter_clone/providers/states/posting_state.dart';

class PostingNotifier extends StateNotifier<PostingState> {
  PostingNotifier({
    required PostingState state,
    required this.notifier,
  }) : super(state);

  final PostNotifier notifier;

  void updatePost(Post post) {
    state = state.copyWith(post: post);
  }

  void updateContent(String content) {
    updatePost(
      state.post.copyWith(
        content: content,
      ),
    );
  }

  void updateMedia(List<MediaItem> media) {
    updatePost(
      state.post.copyWith(
        media: media,
      ),
    );
  }

  void updateIsAllowedComment(bool isAllowedComment) {
    updatePost(
      state.post.copyWith(
        isAllowedComment: isAllowedComment,
      ),
    );
  }

  void updateTimestamp(DateTime timestamp) {
    updatePost(
      state.post.copyWith(
        timestamp: timestamp,
      ),
    );
  }

  void completePosting() {
    updateTimestamp(DateTime.now());
    //TODO: will be posting to server
    notifier.addPost(state.post);
  }

  void resetPostingInfo() {
    updateContent("");
    updateMedia([]);
    updateIsAllowedComment(true);
  }
}
