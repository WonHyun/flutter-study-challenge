import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflix/models/movie_info.dart';
import 'package:movieflix/providers/notifiers/movie_list_notifier.dart';
import 'package:movieflix/providers/providers.dart';
import 'package:movieflix/providers/states/movie_list_state.dart';
import 'package:movieflix/screens/movie_detail_info_screen.dart';
import 'package:movieflix/utils/path_util.dart';
import 'package:movieflix/widgets/component/card_button.dart';
import 'package:movieflix/widgets/component/rank_label.dart';

class MovieListView extends ConsumerWidget {
  const MovieListView({
    super.key,
    required this.width,
    required this.height,
    required this.moviesState,
    required this.moviesNotifier,
    this.isShowTitle = true,
    this.isRanked = false,
    this.isShowDDay = false,
  });

  final double width;
  final double height;
  final bool isShowTitle;
  final bool isRanked;
  final bool isShowDDay;
  final MovieListState moviesState;
  final MovieListNotifier moviesNotifier;

  void _onMovieTap(
    BuildContext context,
    MovieInfo movie,
    Function(MovieInfo) callback,
  ) {
    callback(movie);
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MovieDetailInfoScreen(
          movieId: movie.movieId,
          posterPath: movie.posterPath,
        ),
      ),
    );
  }

  String _getDDay(String targetDateString) {
    try {
      final now = DateTime.now();
      final releaseDate = DateTime.parse(targetDateString);
      final diffDay = now.difference(releaseDate).inDays;
      return diffDay < 0 ? "D$diffDay" : "Released";
    } catch (err) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyNotifier = ref.watch(recentlyViewedProvider.notifier);
    return SizedBox(
      height: isShowTitle ? height + 80 : height + 20,
      child: Builder(
        builder: (context) {
          if (!moviesState.isLoading && moviesState.errorMsg == null) {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              scrollDirection: Axis.horizontal,
              itemCount: moviesState.movies.length,
              itemBuilder: (context, index) {
                final movie = moviesState.movies[index];
                final dday = _getDDay(movie.releaseDate);
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
                            imgUrl: getImgUrl(movie.posterPath),
                            onTap: () => _onMovieTap(
                              context,
                              movie,
                              recentlyNotifier.addMovieAtFirst,
                            ),
                          ),
                          Positioned(
                            left: -5,
                            top: -5,
                            child: Offstage(
                              offstage: !isRanked,
                              child: RankLabel(rank: (index + 1).toString()),
                            ),
                          ),
                          Positioned(
                            left: -5,
                            top: -5,
                            child: Offstage(
                                offstage: !isShowDDay,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    dday,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Offstage(
                        offstage: !isShowTitle,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: width,
                            child: Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (moviesState.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
                child: Text(
                    moviesState.errorMsg ?? "Can't loading this movie list!"));
          }
        },
      ),
    );
  }
}
