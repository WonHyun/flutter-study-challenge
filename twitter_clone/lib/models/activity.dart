import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/user.dart';

class Activity {
  final String activityId;
  final ActivityType type;
  final DateTime timestamp;
  final User user;
  final String content;
  final String originalPostContent;

  const Activity({
    required this.activityId,
    required this.type,
    required this.timestamp,
    required this.user,
    this.content = "",
    this.originalPostContent = "",
  });

  Activity copyWith({
    String? activityId,
    ActivityType? type,
    DateTime? timestamp,
    User? user,
    String? content,
    String? originalPostContent,
  }) {
    return Activity(
      activityId: activityId ?? this.activityId,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      user: user ?? this.user,
      content: content ?? this.content,
      originalPostContent: originalPostContent ?? this.originalPostContent,
    );
  }
}
