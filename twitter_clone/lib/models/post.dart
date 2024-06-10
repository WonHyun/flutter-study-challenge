import 'package:twitter_clone/models/base/media_item.dart';
import 'package:twitter_clone/models/comment.dart';

class Post {
  final String postId;
  final String authorId;
  final String content;
  final List<MediaItem>? media;
  final DateTime? timestamp;
  final bool isLiked;
  final List<Comment> comments;
  final int likes;
  final int shares;

  const Post({
    required this.postId,
    required this.authorId,
    required this.content,
    this.media = const [],
    this.timestamp,
    this.isLiked = false,
    this.comments = const [],
    this.likes = 0,
    this.shares = 0,
  });
}
