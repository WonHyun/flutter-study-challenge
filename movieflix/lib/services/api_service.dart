import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/global/enum.dart';
import 'package:movieflix/global/url.dart';
import 'package:movieflix/models/movie_detail_info.dart';
import 'package:movieflix/models/movie_info.dart';

class ApiService {
  static Future<List<MovieInfo>> getMovies(Endpoint endpoint) async {
    try {
      List<MovieInfo> movieInstances = [];
      final url = Uri.parse("$baseUrl/${endpointValues[endpoint]}");
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final Map<String, dynamic> movies = jsonDecode(res.body);
        for (var movie in movies["results"]) {
          movieInstances.add(MovieInfo.fromJson(movie));
        }
        return movieInstances;
      }
      throw Error();
    } catch (err) {
      throw Error();
    }
  }

  static Future<MovieDetailInfo> getMovieInfo(
    Endpoint endpoint,
    int movieId,
  ) async {
    try {
      final url = Uri.parse("$baseUrl/${endpointValues[endpoint]}?id=$movieId");
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final Map<String, dynamic> movieInfo = jsonDecode(res.body);
        return MovieDetailInfo.fromJson(movieInfo);
      }
      throw Error();
    } catch (err) {
      throw Error();
    }
  }
}
