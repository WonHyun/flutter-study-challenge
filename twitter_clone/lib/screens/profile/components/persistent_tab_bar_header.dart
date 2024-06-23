import 'package:flutter/material.dart';

class PersistentTabBarHeader extends SliverPersistentHeaderDelegate {
  final TabBar child;
  final Color backgroundColor;

  PersistentTabBarHeader({
    required this.child,
    required this.backgroundColor,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: SizedBox.expand(child: child),
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant PersistentTabBarHeader oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor;
  }
}
