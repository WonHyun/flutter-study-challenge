import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/color.dart';

class CertificationMark extends StatelessWidget {
  const CertificationMark({
    super.key,
    this.size = 12,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FaIcon(
          FontAwesomeIcons.certificate,
          color: ThemeColors.twitterColor,
          size: size,
        ),
        Positioned.fill(
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.check,
              color: Colors.white,
              size: size / 2,
            ),
          ),
        ),
      ],
    );
  }
}
