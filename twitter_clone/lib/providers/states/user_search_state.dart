import 'package:twitter_clone/models/user.dart';

class UserSearchState {
  final List<User> result;
  final String keyword;
  final List<String> recentlyKeyword;
  final bool isSearching;

  const UserSearchState({
    this.result = const [],
    this.keyword = "",
    this.recentlyKeyword = const [],
    this.isSearching = false,
  });

  UserSearchState copyWith({
    List<User>? result,
    String? keyword,
    List<String>? recentlyKeyword,
    bool? isSearching,
  }) {
    return UserSearchState(
      result: result ?? this.result,
      keyword: keyword ?? this.keyword,
      recentlyKeyword: recentlyKeyword ?? this.recentlyKeyword,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
