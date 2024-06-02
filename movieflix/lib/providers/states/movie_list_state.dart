import 'package:movieflix/global/enum.dart';
import 'package:movieflix/models/movie_info.dart';

class MovieListState {
  final MovieListType movieListType;
  final List<MovieInfo> movies;
  final bool isLoading;
  final String? errorMsg;

  const MovieListState({
    required this.movieListType,
    this.movies = const [],
    this.isLoading = true,
    this.errorMsg,
  });

  MovieListState copyWith({
    List<MovieInfo>? movies,
    bool? isLoading,
    String? errorMsg,
  }) {
    return MovieListState(
      movieListType: movieListType,
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
