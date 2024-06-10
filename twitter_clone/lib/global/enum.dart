import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum LoginType {
  google,
  apple,
}

enum PolicyType {
  personalize,
}

enum MainScreenType {
  home,
  search,
  post,
  likes,
  user,
}

extension MainScreenIcon on MainScreenType {
  IconData get selectedIcon {
    switch (this) {
      case MainScreenType.home:
        return FontAwesomeIcons.house;
      case MainScreenType.search:
        return FontAwesomeIcons.magnifyingGlass;
      case MainScreenType.post:
        return FontAwesomeIcons.penToSquare;
      case MainScreenType.likes:
        return FontAwesomeIcons.solidHeart;
      case MainScreenType.user:
        return FontAwesomeIcons.solidUser;
    }
  }

  IconData get unselectedIcon {
    switch (this) {
      case MainScreenType.home:
        return FontAwesomeIcons.house;
      case MainScreenType.search:
        return FontAwesomeIcons.magnifyingGlass;
      case MainScreenType.post:
        return FontAwesomeIcons.penToSquare;
      case MainScreenType.likes:
        return FontAwesomeIcons.heart;
      case MainScreenType.user:
        return FontAwesomeIcons.user;
    }
  }
}
