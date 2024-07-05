import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/models/user_profile.dart';

class SearchState {
  final List<UserProfile> userResult;
  final List<Post> postResult;
  final String keyword;
  final List<String> recentlyKeyword;

  const SearchState({
    this.userResult = const [],
    this.postResult = const [],
    this.keyword = "",
    this.recentlyKeyword = const [],
  });

  SearchState copyWith({
    List<UserProfile>? userResult,
    List<Post>? postResult,
    String? keyword,
    List<String>? recentlyKeyword,
  }) {
    return SearchState(
      userResult: userResult ?? this.userResult,
      postResult: postResult ?? this.postResult,
      keyword: keyword ?? this.keyword,
      recentlyKeyword: recentlyKeyword ?? this.recentlyKeyword,
    );
  }
}
