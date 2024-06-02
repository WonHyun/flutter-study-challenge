import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflix/global/enum.dart';
import 'package:movieflix/global/theme.dart';
import 'package:movieflix/providers/notifiers/movie_list_notifier.dart';
import 'package:movieflix/providers/notifiers/theme_notifier.dart';
import 'package:movieflix/providers/states/movie_list_state.dart';
import 'package:movieflix/providers/states/theme_state.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier(theme: MovieflixTheme.dark);
});

final popularMoviesProvider =
    StateNotifierProvider<MovieListNotifier, MovieListState>((ref) {
  return MovieListNotifier(
      const MovieListState(movieListType: MovieListType.popular));
});

final nowPlayingMoviesProvider =
    StateNotifierProvider<MovieListNotifier, MovieListState>((ref) {
  return MovieListNotifier(
      const MovieListState(movieListType: MovieListType.nowPlaying));
});

final comingSoonMoviesProvider =
    StateNotifierProvider<MovieListNotifier, MovieListState>((ref) {
  return MovieListNotifier(
      const MovieListState(movieListType: MovieListType.comingSoon));
});
