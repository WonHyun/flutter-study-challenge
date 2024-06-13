import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthorProfileImage extends StatelessWidget {
  const AuthorProfileImage({
    super.key,
    required this.imgPath,
  });

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                imgPath,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: const FaIcon(
                FontAwesomeIcons.circlePlus,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
