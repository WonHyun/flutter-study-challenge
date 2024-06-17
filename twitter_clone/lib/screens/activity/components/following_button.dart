import 'package:flutter/material.dart';
import 'package:twitter_clone/global/color.dart';

class FollowingButton extends StatelessWidget {
  const FollowingButton({
    super.key,
    this.onTap,
    this.isAlreadyFollowing = false,
  });

  final Function()? onTap;
  final bool isAlreadyFollowing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: 90,
        height: 30,
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isAlreadyFollowing
              ? Theme.of(context).colorScheme.surface
              : ThemeColors.twitterColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.5,
            color: isAlreadyFollowing
                ? Colors.grey.shade500
                : ThemeColors.twitterColor,
          ),
        ),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isAlreadyFollowing
                  ? Colors.grey.shade500
                  : Theme.of(context).colorScheme.surface,
            ),
            child: const Text("Following"),
          ),
        ),
      ),
    );
  }
}
