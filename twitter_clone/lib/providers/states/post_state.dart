import 'package:twitter_clone/models/post.dart';

class PostState {
  final List<Post> posts;

  const PostState({
    this.posts = const [],
  });

  PostState copyWith({
    List<Post>? posts,
  }) {
    return PostState(
      posts: posts ?? this.posts,
    );
  }
}
