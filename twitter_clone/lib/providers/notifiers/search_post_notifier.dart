import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/debouncer.dart';
import 'package:twitter_clone/providers/states/user_search_state.dart';
import 'package:twitter_clone/repository/search_repository.dart';

class SearchPostNotifier extends FamilyAsyncNotifier<SearchState, String> {
  late final SearchRepository _repository;
  late final StreamSubscription _subscription;

  void onUpdateKeywords(String keyword) {
    state = const AsyncValue.loading();
    ref.read(searchPostDebouncer).add(keyword);
  }

  Future<void> searchPosts(String keyword) async {
    if (state.value == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _repository.searchPosts(keyword);
      return state.value!.copyWith(
        postResult: [...result],
        recentlyKeyword: [...state.value!.recentlyKeyword, keyword],
      );
    });
  }

  @override
  FutureOr<SearchState> build(String arg) async {
    _repository = ref.read(searchRepo);

    _subscription = ref.read(searchPostDebouncer).stream.listen((keyword) {
      searchPosts(keyword);
    });
    ref.onDispose(_subscription.cancel);

    return const SearchState().copyWith(
      postResult: await _repository.searchPosts(arg),
      keyword: "",
    );
  }
}

final searchPostProvider =
    AsyncNotifierProvider.family<SearchPostNotifier, SearchState, String>(
  () => SearchPostNotifier(),
);

final searchPostDebouncer = Provider(
  (ref) => Debouncer(const Duration(seconds: 1)),
);
