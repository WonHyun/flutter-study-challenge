import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_detail_info.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/utils/api_endpoints.dart';
import '../widgets/layout/movie_detail_info_body.dart';

class MovieDetailInfoScreen extends StatefulWidget {
  const MovieDetailInfoScreen({
    super.key,
    required this.movieId,
  });

  final int movieId;

  @override
  State<MovieDetailInfoScreen> createState() => _MovieDetailInfoScreenState();
}

class _MovieDetailInfoScreenState extends State<MovieDetailInfoScreen> {
  late final Future<MovieDetailInfo> movieInfo;

  @override
  void initState() {
    super.initState();
    movieInfo = ApiService.getMovieInfo(Endpoint.movieInfo, widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: movieInfo,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot.hasData) {
            var movieInfo = snapShot.data!;
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        movieInfo.getImgUrl(),
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.7,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: MovieDetailInfoBody(movieInfo: movieInfo),
                ),
              ],
            );
          } else {
            return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}
