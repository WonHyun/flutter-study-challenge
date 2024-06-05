import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/color.dart';

class TwitterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TwitterAppBar({
    super.key,
    this.leading,
  });

  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: leading,
        title: const FaIcon(
          FontAwesomeIcons.twitter,
          color: ThemeColors.twitterColor,
        ),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
