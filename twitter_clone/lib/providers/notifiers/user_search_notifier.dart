import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/user_profile.dart';
import 'package:twitter_clone/providers/states/user_search_state.dart';
import 'package:twitter_clone/util/generate_util.dart';

class UserSearchNotifier extends StateNotifier<UserSearchState> {
  UserSearchNotifier(super.state);

  void updateResult(List<UserProfile> result) {
    state = state.copyWith(result: result);
  }

  void updateKeyword(String keyword) {
    state = state.copyWith(keyword: keyword);
  }

  void updateRecentlyKeyword(List<String> recentlyKeyword) {
    state = state.copyWith(recentlyKeyword: recentlyKeyword);
  }

  void updateIsSearching(bool isSearching) {
    state = state.copyWith(isSearching: isSearching);
  }

  void addRecentlyKeyword(String keyword) {
    updateRecentlyKeyword([keyword, ...state.recentlyKeyword]);
  }

  Future<void> searchUser(String keyword) async {
    //TODO: should to search from server
    updateKeyword(keyword);
    updateIsSearching(true);
    await Future.delayed(const Duration(seconds: 1));
    updateResult(
      UserGenerator.getRandomUsers(userCount: 100)
          .where(
            (user) =>
                user.displayUserId != null &&
                    user.displayUserId!.contains(keyword) ||
                (user.userName?.contains(keyword) ?? false),
          )
          .toList(),
    );
    updateIsSearching(false);
    // addRecentlyKeyword(keyword);
  }
}
