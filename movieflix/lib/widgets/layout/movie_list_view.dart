import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  });

  final double width;
  final double height;
  final bool isShowTitle;
  final bool isRanked;
  final MovieListState moviesState;
  final MovieListNotifier moviesNotifier;

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
                var movie = moviesState.movies[index];
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
                            onTap: () {
                              recentlyNotifier.addMovieAtFirst(movie);
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
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
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
