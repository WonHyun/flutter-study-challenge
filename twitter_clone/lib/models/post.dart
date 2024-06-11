import 'package:twitter_clone/models/base/media_item.dart';
import 'package:twitter_clone/models/comment.dart';

class Post {
  final String postId;
  final String authorId;
  final String authorName;
  final String content;
  final List<MediaItem>? media;
  final DateTime? timestamp;
  final bool isLiked;
  final List<Comment> comments;
  final int likes;
  final int shares;
  final bool isCertificatedUser;
  final String authorImgPath;

  const Post({
    required this.postId,
    required this.authorId,
    required this.content,
    this.authorName = "",
    this.media = const [],
    this.timestamp,
    this.isLiked = false,
    this.comments = const [],
    this.likes = 0,
    this.shares = 0,
    this.isCertificatedUser = false,
    this.authorImgPath = "",
  });
}
