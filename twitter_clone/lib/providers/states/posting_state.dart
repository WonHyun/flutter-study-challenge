import 'package:twitter_clone/models/post.dart';

class PostingState {
  final Post post;

  const PostingState({
    required this.post,
  });

  PostingState copyWith({
    Post? post,
  }) {
    return PostingState(
      post: post ?? this.post,
    );
  }
}
