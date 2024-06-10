import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: AppBar(
            title: FaIcon(
              FontAwesomeIcons.threads,
              color: Theme.of(context).colorScheme.inverseSurface,
              size: 36,
            ),
          ),
        ),
      ],
    );
  }
}
