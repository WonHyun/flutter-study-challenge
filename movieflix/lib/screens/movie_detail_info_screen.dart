import 'package:flutter/material.dart';
import 'package:movieflix/global/enum.dart';
import 'package:movieflix/models/movie_detail_info.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/utils/path_util.dart';
import '../widgets/layout/movie_detail_info_body.dart';

class MovieDetailInfoScreen extends StatelessWidget {
  MovieDetailInfoScreen({
    super.key,
    required this.movieId,
    required this.posterPath,
  });

  final int movieId;
  final String posterPath;

  late final Future<MovieDetailInfo> movieInfo =
      ApiService.getMovieInfo(Endpoint.movieInfo, movieId);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                getImgUrl(posterPath),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: movieInfo,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapShot.hasData) {
              var movieInfo = snapShot.data!;
              return MovieDetailInfoBody(movieInfo: movieInfo);
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Can't find this movie info."),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
