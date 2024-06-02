class MovieInfo {
  final bool adult, video;
  final List<dynamic> genreIds;
  final int id, voteCount;
  final double popularity, voteAverage;
  final String backdropPath,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      title;

  MovieInfo.fromJson(Map<String, dynamic> json)
      : adult = json["adult"] ?? false,
        video = json["video"] ?? false,
        genreIds = json["genre_ids"] ?? [],
        id = json["id"] ?? 0,
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
