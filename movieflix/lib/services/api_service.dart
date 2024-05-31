import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_detail_info.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/utils/api_endpoints.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  static Future<List<MovieModel>> getMovies(Endpoint endpoint) async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/${endpointValues[endpoint]}");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(res.body);
      for (var movie in movies["results"]) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailInfo> getMovieInfo(
      Endpoint endpoint, int movieId) async {
    final url = Uri.parse("$baseUrl/${endpointValues[endpoint]}?id=$movieId");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final Map<String, dynamic> movieInfo = jsonDecode(res.body);
      return MovieDetailInfo.fromJson(movieInfo);
    }
    throw Error();
  }
}
