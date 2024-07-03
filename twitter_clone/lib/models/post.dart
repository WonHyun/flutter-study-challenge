import 'package:twitter_clone/models/base/media_item.dart';
import 'package:twitter_clone/models/comment.dart';

class Post {
  final String postId;
  final String authorId;
  final String authorName;
  final String authorImgPath;
  final bool isCertificatedUser;
  final String content;
  final List<MediaItem>? media;
  final DateTime? timestamp;
  final bool isLiked;
  final List<Comment> comments;
  final int likes;
  final int shares;
  final bool isAllowedComment;
  final int commentTotalCounts;

  const Post({
    required this.postId,
    required this.authorId,
    this.authorName = "",
    this.authorImgPath = "",
    this.isCertificatedUser = false,
    this.content = "",
    this.media = const [],
    this.timestamp,
    this.isLiked = false,
    this.comments = const [],
    this.likes = 0,
    this.shares = 0,
    this.isAllowedComment = true,
    this.commentTotalCounts = 0,
  });

  Post copyWith({
    String? postId,
    String? authorId,
    String? authorName,
    String? authorImgPath,
    bool? isCertificatedUser,
    String? content,
    List<MediaItem>? media,
    DateTime? timestamp,
    bool? isLiked,
    List<Comment>? comments,
    int? likes,
    int? shares,
    bool? isAllowedComment,
    int? commentTotalCounts,
  }) {
    return Post(
      postId: postId ?? this.postId,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorImgPath: authorImgPath ?? this.authorImgPath,
      isCertificatedUser: isCertificatedUser ?? this.isCertificatedUser,
      content: content ?? this.content,
      media: media ?? this.media,
      timestamp: timestamp ?? this.timestamp,
      isLiked: isLiked ?? this.isLiked,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares,
      isAllowedComment: isAllowedComment ?? this.isAllowedComment,
      commentTotalCounts: commentTotalCounts ?? this.commentTotalCounts,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'postId': postId,
  //     'authorId': authorId,
  //     'authorName': authorName,
  //     'authorImgPath': authorImgPath,
  //     'isCertificatedUser': isCertificatedUser,
  //     'content': content,
  //     'media': media?.map((m) => m.toJson()).toList(),
  //     'timestamp': timestamp?.toIso8601String(),
  //     'isLiked': isLiked,
  //     'comments': comments.map((c) => c.toJson()).toList(),
  //     'likes': likes,
  //     'shares': shares,
  //     'isAllowedComment': isAllowedComment,
  //     'commentTotalCounts': commentTotalCounts,
  //   };
  // }

  // Post fromJson(Map<String, dynamic> json) {
  //   return Post(
  //     postId: json['postId'],
  //     authorId: json['authorId'],
  //     authorName: json['authorName'],
  //     authorImgPath: json['authorImgPath'],
  //     isCertificatedUser: json['isCertificatedUser'],
  //     content: json['content'],
  //     media: json['media'] != null
  //         ? List<MediaItem>.from(
  //             json['media'].map((m) => MediaItem.fromJson(m)))
  //         : null,
  //     timestamp:
  //         json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
  //     isLiked: json['isLiked'],
  //     comments:
  //         List<Comment>.from(json['comments'].map((c) => Comment.fromJson(c))),
  //     likes: json['likes'],
  //     shares: json['shares'],
  //     isAllowedComment: json['isAllowedComment'],
  //     commentTotalCounts: json['commentTotalCounts'],
  //   );
  // }
}
