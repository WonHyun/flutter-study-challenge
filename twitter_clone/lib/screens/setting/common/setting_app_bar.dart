import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingAppBar extends StatelessWidget {
  const SettingAppBar({
    super.key,
    required this.title,
    required this.onTapLeading,
  });

  final String title;
  final Function() onTapLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leadingWidth: 100,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: onTapLeading,
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 15),
            FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 18,
            ),
            SizedBox(width: 5),
            Text(
              "Back",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
