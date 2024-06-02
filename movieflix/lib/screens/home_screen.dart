import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieflix/global/colors.dart';
import 'package:movieflix/global/api_endpoints.dart';
import 'package:movieflix/widgets/layout/movie_poster_list_view.dart';

import '../widgets/component/tab_title.dart';
import '../widgets/layout/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onMenuTap() => _scaffoldKey.currentState?.openDrawer();
  void _onScaffoldTap() => _scaffoldKey.currentState?.closeDrawer();

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
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
                MoviePosterListView(
                  width: 300,
                  height: 200,
                  isShowTitle: true,
                  isRanked: true,
                  endpoint: Endpoint.popular,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TabTitle(title: "Now in Cinemas"),
                ),
                MoviePosterListView(
                  width: 150,
                  height: 150,
                  isShowTitle: true,
                  endpoint: Endpoint.nowPlaying,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TabTitle(title: "Coming soon"),
                ),
                MoviePosterListView(
                  width: 150,
                  height: 150,
                  isShowTitle: true,
                  endpoint: Endpoint.comingSoon,
                ),
              ],
            ),
          ),
        ),
        drawer: const HomeDrawer(),
      ),
    );
  }
}
