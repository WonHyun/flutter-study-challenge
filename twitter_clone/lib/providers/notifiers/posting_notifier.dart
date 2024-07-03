import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/base/media_item.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/providers/states/posting_state.dart';
import 'package:twitter_clone/util/generate_util.dart';

class PostingNotifier extends StateNotifier<PostingState> {
  PostingNotifier({
    required PostingState state,
    required this.ref,
  }) : super(state);

  final Ref ref;

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

  void updatePostId(String postId) {
    updatePost(
      state.post.copyWith(
        postId: postId,
      ),
    );
  }

  void completePosting() {
    final userInfo = ref.watch(userProvider).value;
    final postNotifier = ref.watch(postProvider.notifier);

    state = state.copyWith(
      post: state.post.copyWith(
        postId: uuid.v4(),
        authorId: userInfo?.userId,
        authorName: userInfo?.userName,
        authorImgPath: userInfo?.avatarPath,
        isCertificatedUser: userInfo?.isCertificatedUser,
        timestamp: DateTime.now(),
      ),
    );

    //TODO: will be posting to server
    postNotifier.addPost(state.post);
  }

  void resetPostingInfo() {
    updateContent("");
    updateMedia([]);
    updateIsAllowedComment(true);
  }

  void clearContent() {
    updateContent("");
    updateMedia([]);
  }

  void addMedias(List<MediaItem> medias) {
    updateMedia([...?state.post.media, ...medias]);
  }

  void removeMedia(MediaItem item) {
    updateMedia(
      state.post.media
              ?.where((media) => media.mediaId != item.mediaId)
              .toList() ??
          [],
    );
  }
}
