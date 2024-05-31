class MovieDetailInfo {
  final bool adult, video;
  final int budget, id, revenue, runtime, voteCount;
  final double popularity, voteAverage;

  final Map<String, dynamic> belongsToCollection;

  final List<dynamic> productionCompanies,
      productionCountries,
      spokenLanguages,
      originCountry,
      genres;
  final String hompage,
      imdbId,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      status,
      tagline,
      title;

  final String imgBaseUrl = "https://image.tmdb.org/t/p/w500";

  MovieDetailInfo.fromJson(Map<String, dynamic> json)
      : adult = json["adult"] ?? false,
        video = json["video"] ?? false,
        id = json["id"] ?? 0,
        voteCount = json["vote_count"] ?? 0,
        popularity = (json["popularity"] ?? 0 as num).toDouble(),
        voteAverage = (json["vote_average"] ?? 0 as num).toDouble(),
        originalLanguage = json["original_language"] ?? "",
        originalTitle = json["original_title"] ?? "",
        overview = json["overview"] ?? "",
        posterPath = json["poster_path"] ?? "",
        releaseDate = json["release_date"] ?? "",
        revenue = json["revenue"] ?? 0,
        runtime = json["runtime"] ?? 0,
        belongsToCollection = json["belongs_to_collection"] ?? {},
        productionCompanies = json["production_companies"] ?? [],
        productionCountries = json["production_countries"] ?? [],
        spokenLanguages = json["spoken_languages"] ?? [],
        originCountry = json["origin_country"] ?? [],
        hompage = json["hompage"] ?? "",
        imdbId = json["imdb_id"] ?? "",
        status = json["status"] ?? "",
        tagline = json["tagline"] ?? "",
        genres = json["genres"] ?? [],
        budget = json["budget"] ?? 0,
        title = json["title"] ?? "";

  String getImgUrl() {
    return "$imgBaseUrl/$posterPath";
  }
}
