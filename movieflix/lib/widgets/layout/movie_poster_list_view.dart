import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/screens/movie_detail_info_screen.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/utils/api_endpoints.dart';
import 'package:movieflix/widgets/component/card_button.dart';

import '../component/rank_label.dart';

class MoviePosterListView extends StatelessWidget {
  MoviePosterListView({
    super.key,
    required this.width,
    required this.height,
    this.isShowTitle = false,
    this.isRanked = false,
    required this.endpoint,
  });

  final double width;
  final double height;
  final bool isShowTitle;
  final bool isRanked;
  final Endpoint endpoint;

  late final Future<List<MovieModel>> movies = ApiService.getMovies(endpoint);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isShowTitle ? height + 80 : height + 20,
      child: FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var movie = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CardButton(
                            width: width,
                            height: height,
                            imgUrl: movie.getImgUrl(),
                            callback: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => MovieDetailInfoScreen(
                                    movieId: movie.id,
                                  ),
                                ),
                              )
                            },
                          ),
                          Positioned(
                            left: -5,
                            top: -5,
                            child: Offstage(
                              offstage: !isRanked,
                              child: RankLabel(rank: (index + 1).toString()),
                            ),
                          ),
                        ],
                      ),
                      isShowTitle
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SizedBox(
                                width: width,
                                child: Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
