import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/debouncer.dart';
import 'package:twitter_clone/providers/states/user_search_state.dart';
import 'package:twitter_clone/repository/search_repository.dart';

class SearchNotifier extends AsyncNotifier<SearchState> {
  late final SearchRepository _repository;
  late final StreamSubscription _subscription;

  void onUpdateKeywords(String keyword) {
    state = const AsyncValue.loading();
    ref.read(searchDebouncer).add(keyword);
  }

  Future<void> searchUsers(String keyword) async {
    if (state.value == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _repository.searchUsers(keyword);
      return state.value!.copyWith(
        userResult: [...result],
      );
    });
  }

  Future<void> searchPosts(String keyword) async {
    if (state.value == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _repository.searchPosts(keyword);
      return state.value!.copyWith(
        postResult: [...result],
      );
    });
  }

  @override
  FutureOr<SearchState> build() async {
    _repository = ref.read(searchRepo);

    _subscription = ref.read(searchDebouncer).stream.listen((keyword) {
      searchUsers(keyword);
    });
    ref.onDispose(_subscription.cancel);

    return const SearchState().copyWith(
      userResult: await _repository.searchUsers(""),
      keyword: "",
    );
  }
}

final searchProvider = AsyncNotifierProvider<SearchNotifier, SearchState>(
  () => SearchNotifier(),
);

final searchDebouncer = Provider(
  (ref) => Debouncer(const Duration(seconds: 1)),
);
