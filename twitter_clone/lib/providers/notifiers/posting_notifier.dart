import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/media_item.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/repository/post_repository.dart';
import 'package:twitter_clone/util/generate_util.dart';

class PostingNotifier extends AsyncNotifier<Post> {
  late final PostRepository _repository;

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

  Future<void> completePosting() async {
    if (state.value == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final newPost = state.value!.copyWith(timestamp: DateTime.now());
      await _repository.createPost(newPost);
      return newPost;
    });
  }

  @override
  FutureOr<Post> build() {
    final user = ref.read(userProvider).value;

    _repository = ref.read(postRepo);

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
