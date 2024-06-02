import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflix/global/enum.dart';
import 'package:movieflix/models/movie_info.dart';
import 'package:movieflix/providers/states/movie_list_state.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/utils/date_util.dart';

class MovieListNotifier extends StateNotifier<MovieListState> {
  MovieListNotifier(super.state) {
    fetchMovieList();
  }

  Future<void> fetchMovieList() async {
    try {
      updateLoading(true);
      late final List<MovieInfo> movies;
      switch (state.movieListType) {
        case MovieListType.popular:
          movies = await ApiService.getMovies(Endpoint.popular);
        case MovieListType.nowPlaying:
          movies = await ApiService.getMovies(Endpoint.nowPlaying);
        case MovieListType.comingSoon:
          movies = await ApiService.getMovies(Endpoint.comingSoon);
          movies.sort(
              (e1, e2) => getDateDiff(e2.releaseDate, e1.releaseDate) ?? 0);
        case MovieListType.recentlyViewed:
          movies = [];
      }
      updateMovies(movies);
      updateLoading(false);
    } catch (err) {
      print(err);
      updateErrorMsg(err.toString());
      updateLoading(false);
    }
  }

  void updateMovies(List<MovieInfo> movies) {
    state = state.copyWith(movies: movies);
  }

  void updateLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void updateErrorMsg(String? errorMsg) {
    state = state.copyWith(errorMsg: errorMsg);
  }

  void addMovieAtFirst(MovieInfo movieInfo) {
    if (state.movies
            .indexWhere((element) => element.movieId == movieInfo.movieId) <
        0) {
      state = state.copyWith(movies: [movieInfo, ...state.movies]);
    }
  }

  void clearAllMovies() {
    state = state.copyWith(movies: []);
  }
}
