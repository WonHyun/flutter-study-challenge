import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieflix/models/movie_detail_info.dart';
import 'package:movieflix/widgets/component/custom_button.dart';
import 'package:movieflix/widgets/component/more_rich_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/movie_rating_bar.dart';

class MovieDetailInfoBody extends StatelessWidget {
  const MovieDetailInfoBody({
    super.key,
    required this.movieInfo,
  });

  final MovieDetailInfo movieInfo;

  String getGenres() {
    String genreStr = "";
    for (var genre in movieInfo.genres) {
      genreStr = "${genreStr + genre["name"]},";
    }
    return genreStr.substring(0, genreStr.length - 1);
  }

  String getRunningTime() {
    var runtime = Duration(minutes: movieInfo.runtime).toString().split(":");
    return "${runtime[0]}h ${runtime[1]}min";
  }

  Future<void> launchTicketUrl() async {
    final url = Uri.parse("https://www.google.com/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Back to list",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    movieInfo.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  MovieRatingBar(
                    voteAverage: movieInfo.voteAverage,
                    voteCount: movieInfo.voteCount,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${getRunningTime()} | ${getGenres()}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Storyline",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 10),
                  MoreRichText(text: movieInfo.overview),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(text: "Buy ticket", onTap: launchTicketUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
