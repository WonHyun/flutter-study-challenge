import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';
import 'package:twitter_clone/screens/login/login_screen.dart';

class ThreadAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ThreadAppBar({
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
          onTap: () => context.goNamed(LoginScreen.routeName),
        ),
      );
    }
    if (isUseBackArrowLeading) {
      return GestureDetector(
        onTap: context.pop,
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
          FontAwesomeIcons.threads,
          size: 32,
        ),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
