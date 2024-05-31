import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieflix/global/extensions.dart';

class MovieRatingBar extends StatelessWidget {
  const MovieRatingBar({
    super.key,
    required this.voteAverage,
  });

  final double voteAverage;

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
      ],
    );
  }
}
