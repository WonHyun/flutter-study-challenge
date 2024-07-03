import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/repository/post_repository.dart';

class PostNotifier extends AsyncNotifier<List<Post>> {
  List<Post> _posts = [];
  late final PostRepository _repository;

  @override
  FutureOr<List<Post>> build() async {
    _repository = ref.read(postRepo);
    _posts = await _fetchPosts(lastItemTimestamp: null);
    return _posts;
  }

  Future<List<Post>> _fetchPosts({
    DateTime? lastItemTimestamp,
  }) async {
    final result = await _repository.fetchPosts(
      lastItemTimestamp: lastItemTimestamp,
    );
    final videos = result.docs
        .map(
          (doc) => Post.fromJson(doc.data()),
        )
        .toList();
    return videos;
  }

  void toggleLike(String postId) {
    //TODO: will be send like info to server
    if (state.value != null) return;
    state = AsyncData(
      state.value!.map(
        (post) {
          if (post.postId == postId) {
            return post.copyWith(
              isLiked: !post.isLiked,
              likes: !post.isLiked ? post.likes + 1 : post.likes - 1,
            );
          }
          return post;
        },
      ).toList(),
    );
  }

  void hidePost(Post post) {
    if (state.value != null) return;
    state =
        AsyncData(state.value!.where((e) => e.postId != post.postId).toList());
    _posts = state.value!;
  }

  void reportPost(Post post, String reason) {
    //TODO: send report
    hidePost(post);
  }

  Future<void> fetchNextPosts() async {
    final nextPosts =
        await _fetchPosts(lastItemTimestamp: _posts.last.timestamp);
    state = AsyncValue.data([..._posts, ...nextPosts]);
  }

  Future<void> refresh() async {
    final posts = await _fetchPosts(lastItemTimestamp: null);
    _posts = posts;
    state = AsyncValue.data(posts);
  }
}

final postProvider = AsyncNotifierProvider<PostNotifier, List<Post>>(
  () => PostNotifier(),
);
