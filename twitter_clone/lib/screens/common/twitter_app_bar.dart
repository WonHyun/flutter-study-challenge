import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/color.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';

class TwitterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TwitterAppBar({
    super.key,
    this.leading,
    this.isUseBackArrowLeading = false,
    this.isUseCancelLeading = false,
  });

  final Widget? leading;
  final bool isUseCancelLeading;
  final bool isUseBackArrowLeading;

  Widget? _getLeading(BuildContext context) {
    if (isUseCancelLeading) {
      return Center(
        child: LinkedText(
          text: "Cancel",
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.inverseSurface,
          onTap: () => Navigator.pop(context),
        ),
      );
    }
    if (isUseBackArrowLeading) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Align(
            alignment: Alignment.centerLeft,
            child: FaIcon(FontAwesomeIcons.arrowLeft, size: 24)),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: _getLeading(context),
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
