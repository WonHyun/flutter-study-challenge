import 'package:movieflix/utils/generate_util.dart';

class MovieInfo {
  final String id;
  final bool adult, video;
  final List<dynamic> genreIds;
  final int movieId, voteCount;
  final double popularity, voteAverage;
  final String backdropPath,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      title;

  MovieInfo.fromJson(Map<String, dynamic> json)
      : id = uuid.v4(),
        adult = json["adult"] ?? false,
        video = json["video"] ?? false,
        genreIds = json["genre_ids"] ?? [],
        movieId = json["id"] ?? 0,
        voteCount = json["vote_count"] ?? 0,
        popularity = (json["popularity"] ?? 0 as num).toDouble(),
        voteAverage = (json["vote_average"] ?? 0 as num).toDouble(),
        backdropPath = json["backdrop_path"] ?? "",
        originalLanguage = json["original_language"] ?? "",
        originalTitle = json["original_title"] ?? "",
        overview = json["overview"] ?? "",
        posterPath = json["poster_path"] ?? "",
        releaseDate = json["release_date"] ?? "",
        title = json["title"] ?? "";
}
