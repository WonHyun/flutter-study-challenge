import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/media_item.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/util/generate_util.dart';

class PostingNotifier extends AsyncNotifier<Post> {
  void updateContent(String content) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        content: content,
      ),
    );
  }

  void updateMedia(List<MediaItem> media) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        media: media,
      ),
    );
  }

  void updateIsAllowedComment(bool isAllowedComment) {
    if (state.value == null) return;
    state = AsyncData(
      state.value!.copyWith(
        isAllowedComment: isAllowedComment,
      ),
    );
  }

  void completePosting() {
    if (state.value == null) return;
    final postNotifier = ref.watch(postProvider.notifier);

    state = const AsyncLoading();
    state = AsyncData(
      state.value!.copyWith(
        timestamp: DateTime.now(),
      ),
    );

    //TODO: will be posting to server
    postNotifier.addPost(state.value!);
  }

  void resetPostingInfo() {
    state = AsyncData(Post.empty());
  }

  void clearContent() {
    updateContent("");
    updateMedia([]);
  }

  void addMedias(List<MediaItem> medias) {
    if (state.value == null) return;
    updateMedia([...?state.value!.media, ...medias]);
  }

  void removeMedia(MediaItem item) {
    if (state.value == null) return;
    updateMedia(
      state.value!.media
              ?.where((media) => media.mediaId != item.mediaId)
              .toList() ??
          [],
    );
  }

  @override
  FutureOr<Post> build() {
    final user = ref.read(userProvider).value;
    return Post.empty().copyWith(
      postId: uuid.v4(),
      authorId: user?.userId ?? "",
      authorName: user?.userName ?? "",
      authorImgPath: user?.avatarPath ?? "",
      isCertificatedUser: user?.isCertificatedUser ?? false,
      isAllowedComment: true,
    );
  }
}

final postingProvider = AsyncNotifierProvider<PostingNotifier, Post>(
  () => PostingNotifier(),
);
