import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SlashHeartIcon extends StatelessWidget {
  const SlashHeartIcon({
    super.key,
    this.size = 18,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: FaIcon(
              FontAwesomeIcons.heart,
              size: size * 0.9,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
          Positioned(
            left: 0,
            top: 1,
            child: FaIcon(
              FontAwesomeIcons.slash,
              size: size,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: FaIcon(
              FontAwesomeIcons.slash,
              size: size,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
        ],
      ),
    );
  }
}
