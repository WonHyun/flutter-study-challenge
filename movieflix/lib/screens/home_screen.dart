import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieflix/global/colors.dart';
import 'package:movieflix/global/enum.dart';
import 'package:movieflix/global/theme.dart';
import 'package:movieflix/providers/notifiers/movie_list_notifier.dart';
import 'package:movieflix/providers/providers.dart';
import 'package:movieflix/providers/states/movie_list_state.dart';
import 'package:movieflix/widgets/component/tab_title.dart';
import 'package:movieflix/widgets/layout/home_drawer.dart';
import 'package:movieflix/widgets/layout/movie_list_view.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({
    super.key,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onMenuTap() => _scaffoldKey.currentState?.openDrawer();
  void _onScaffoldTap() => _scaffoldKey.currentState?.closeDrawer();

  Future<void> _onRefresh(BuildContext context, WidgetRef ref) async {
    _getMoviesNotifier(context, ref, MovieListType.popular).fetchMovieList();
    _getMoviesNotifier(context, ref, MovieListType.nowPlaying).fetchMovieList();
    _getMoviesNotifier(context, ref, MovieListType.comingSoon).fetchMovieList();
  }

  MovieListState _getMoviesState(
      BuildContext context, WidgetRef ref, MovieListType type) {
    switch (type) {
      case MovieListType.popular:
        return ref.watch(popularMoviesProvider);
      case MovieListType.nowPlaying:
        return ref.watch(nowPlayingMoviesProvider);
      case MovieListType.comingSoon:
        return ref.watch(comingSoonMoviesProvider);
      case MovieListType.recentlyViewed:
        return ref.watch(recentlyViewedProvider);
    }
  }

  MovieListNotifier _getMoviesNotifier(
      BuildContext context, WidgetRef ref, MovieListType type) {
    switch (type) {
      case MovieListType.popular:
        return ref.watch(popularMoviesProvider.notifier);
      case MovieListType.nowPlaying:
        return ref.watch(nowPlayingMoviesProvider.notifier);
      case MovieListType.comingSoon:
        return ref.watch(comingSoonMoviesProvider.notifier);
      case MovieListType.recentlyViewed:
        return ref.watch(recentlyViewedProvider.notifier);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: const Text("MOVIEFLIX",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: ThemeColors.movieflixPrimary,
              )),
          leading: GestureDetector(
            onTap: _onMenuTap,
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.bars,
                size: 24,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: themeState.theme == MovieflixTheme.dark
              ? BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomCenter,
                    radius: 0.8,
                    stops: const [0.2, 0.5, 0.75, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.purple.shade400,
                      Colors.pink.shade400,
                      Colors.transparent,
                    ],
                  ),
                )
              : BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomCenter,
                    radius: 0.8,
                    stops: const [0.2, 0.5, 0.75, 1.0],
                    colors: [
                      Colors.white,
                      Colors.purple.shade100,
                      Colors.pink.shade100,
                      Colors.white,
                    ],
                  ),
                ),
          child: RefreshIndicator(
            onRefresh: () async => _onRefresh(context, ref),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TabTitle(title: "Popular Movies"),
                    ),
                    MovieListView(
                      width: 300,
                      height: 200,
                      isRanked: true,
                      moviesState:
                          _getMoviesState(context, ref, MovieListType.popular),
                      moviesNotifier: _getMoviesNotifier(
                          context, ref, MovieListType.popular),
                    ),
                    Offstage(
                      offstage: _getMoviesState(
                              context, ref, MovieListType.recentlyViewed)
                          .movies
                          .isEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: TabTitle(title: "Recently Viewed"),
                          ),
                          MovieListView(
                            width: 150,
                            height: 150,
                            isShowTitle: false,
                            moviesState: _getMoviesState(
                                context, ref, MovieListType.recentlyViewed),
                            moviesNotifier: _getMoviesNotifier(
                                context, ref, MovieListType.recentlyViewed),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TabTitle(title: "Now in Cinemas"),
                    ),
                    MovieListView(
                      width: 150,
                      height: 150,
                      moviesState: _getMoviesState(
                          context, ref, MovieListType.nowPlaying),
                      moviesNotifier: _getMoviesNotifier(
                          context, ref, MovieListType.nowPlaying),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TabTitle(title: "Coming soon"),
                    ),
                    MovieListView(
                      width: 150,
                      height: 150,
                      isShowDDay: true,
                      moviesState: _getMoviesState(
                          context, ref, MovieListType.comingSoon),
                      moviesNotifier: _getMoviesNotifier(
                          context, ref, MovieListType.comingSoon),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer: const HomeDrawer(),
      ),
    );
  }
}
