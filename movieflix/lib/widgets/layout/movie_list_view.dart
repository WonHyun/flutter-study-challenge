import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflix/models/movie_info.dart';
import 'package:movieflix/providers/notifiers/movie_list_notifier.dart';
import 'package:movieflix/providers/providers.dart';
import 'package:movieflix/providers/states/movie_list_state.dart';
import 'package:movieflix/screens/movie_detail_info_screen.dart';
import 'package:movieflix/utils/date_util.dart';
import 'package:movieflix/utils/path_util.dart';
import 'package:movieflix/widgets/component/card_button.dart';
import 'package:movieflix/widgets/component/rank_label.dart';

class MovieListView extends ConsumerStatefulWidget {
  const MovieListView({
    super.key,
    required this.width,
    required this.height,
    required this.moviesState,
    required this.moviesNotifier,
    this.isShowTitle = true,
    this.isRanked = false,
    this.isShowDDay = false,
    this.isSlide = false,
  });

  final double width;
  final double height;
  final bool isShowTitle;
  final bool isRanked;
  final bool isShowDDay;
  final bool isSlide;
  final MovieListState moviesState;
  final MovieListNotifier moviesNotifier;

  @override
  ConsumerState<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends ConsumerState<MovieListView> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;

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
      final diffDay =
          getDateDiff(DateTime.now().toString(), targetDateString) ?? 0;
      return diffDay < 0 ? "D$diffDay" : "Released";
    } catch (err) {
      return "";
    }
  }

  void _startSlide() {
    const scrollDuration = Duration(seconds: 2);
    const scrollAmount = 100.0;

    _timer = Timer.periodic(scrollDuration, (timer) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.offset + scrollAmount,
          duration: scrollDuration,
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isSlide) {
      _startSlide();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recentlyNotifier = ref.watch(recentlyViewedProvider.notifier);
    return SizedBox(
      height: widget.isShowTitle ? widget.height + 80 : widget.height + 20,
      child: Builder(
        builder: (context) {
          if (!widget.moviesState.isLoading &&
              widget.moviesState.errorMsg == null) {
            return ListView.builder(
              controller: _controller,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount:
                  widget.isSlide ? null : widget.moviesState.movies.length,
              itemBuilder: (context, rawIndex) {
                final index = rawIndex % widget.moviesState.movies.length;
                final movie = widget.moviesState.movies[index];
                final dday = _getDDay(movie.releaseDate);
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 5,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CardButton(
                            width: widget.width,
                            height: widget.height,
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
                              offstage: !widget.isRanked,
                              child: RankLabel(rank: (index + 1).toString()),
                            ),
                          ),
                          Positioned(
                            left: -5,
                            top: -5,
                            child: Offstage(
                                offstage: !widget.isShowDDay,
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
                        offstage: !widget.isShowTitle,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: widget.width,
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
          } else if (widget.moviesState.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
                child: Text(widget.moviesState.errorMsg ??
                    "Can't loading this movie list!"));
          }
        },
      ),
    );
  }
}
