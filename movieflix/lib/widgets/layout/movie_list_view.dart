import 'package:flutter/material.dart';
import 'package:movieflix/providers/notifiers/movie_list_notifier.dart';
import 'package:movieflix/providers/states/movie_list_state.dart';
import 'package:movieflix/screens/movie_detail_info_screen.dart';
import 'package:movieflix/utils/path_util.dart';
import 'package:movieflix/widgets/component/card_button.dart';
import 'package:movieflix/widgets/component/rank_label.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    super.key,
    required this.width,
    required this.height,
    required this.state,
    required this.notifier,
    this.isShowTitle = true,
    this.isRanked = false,
  });

  final double width;
  final double height;
  final bool isShowTitle;
  final bool isRanked;
  final MovieListState state;
  final MovieListNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isShowTitle ? height + 80 : height + 20,
      child: Builder(
        builder: (context) {
          if (!state.isLoading && state.errorMsg == null) {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              scrollDirection: Axis.horizontal,
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                var movie = state.movies[index];
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
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => MovieDetailInfoScreen(
                                    movieId: movie.id,
                                    posterPath: movie.posterPath,
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
          } else if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
                child:
                    Text(state.errorMsg ?? "Can't loading this movie list!"));
          }
        },
      ),
    );
  }
}
