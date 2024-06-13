import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/providers/states/post_state.dart';

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier(super.state);

  void updatePosts(List<Post> posts) {
    state = state.copyWith(posts: posts);
  }

  void toggleLike(String postId) {
    //TODO: will be send like info to server
    updatePosts(
      state.posts.map(
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

  void addPost(Post post) {
    final newPosts = [post, ...state.posts];
    updatePosts(newPosts);
  }

  void hidePost(Post post) {
    final newPosts = state.posts.where((e) => e.postId != post.postId).toList();
    updatePosts(newPosts);
  }

  void reportPost(Post post, String reason) {
    //TODO: send report
    hidePost(post);
  }
}
