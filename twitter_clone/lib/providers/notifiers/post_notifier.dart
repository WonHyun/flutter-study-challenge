import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/providers/states/post_state.dart';

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier(super.state);

  void updatePosts(List<Post> posts) {
    state = state.copyWith(posts: posts);
  }

  void addPost(Post post) {
    final newPosts = [post, ...state.posts, post];
    updatePosts(newPosts);
  }
}