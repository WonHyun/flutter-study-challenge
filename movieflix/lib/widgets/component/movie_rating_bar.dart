import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieflix/global/extensions.dart';

class MovieRatingBar extends StatelessWidget {
  const MovieRatingBar({
    super.key,
    required this.voteAverage,
    required this.voteCount,
  });

  final double voteAverage;
  final int voteCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          minRating: 0,
          initialRating: (voteAverage / 2).roundToHalf(),
          allowHalfRating: true,
          ignoreGestures: false,
          direction: Axis.horizontal,
          itemSize: 26,
          itemCount: 5,
          itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {},
        ),
        const SizedBox(width: 10),
        Text(
          "(${(voteAverage / 2).truncateToFirstDecimal()})",
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 30),
        const FaIcon(
          FontAwesomeIcons.users,
          color: Colors.white,
          size: 18,
        ),
        const SizedBox(width: 10),
        Text(
          "$voteCount",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
