import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/enum.dart';

extension MainScreenIcon on MainScreenType {
  IconData get selectedIcon {
    switch (this) {
      case MainScreenType.home:
        return FontAwesomeIcons.house;
      case MainScreenType.search:
        return FontAwesomeIcons.magnifyingGlass;
      case MainScreenType.posting:
        return FontAwesomeIcons.penToSquare;
      case MainScreenType.activity:
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
      case MainScreenType.posting:
        return FontAwesomeIcons.penToSquare;
      case MainScreenType.activity:
        return FontAwesomeIcons.heart;
      case MainScreenType.user:
        return FontAwesomeIcons.user;
    }
  }
}

extension ActivityTypeExtension on ActivityType {
  String get labelName {
    switch (this) {
      case ActivityType.all:
        return "All";
      case ActivityType.replies:
        return "Replies";
      case ActivityType.mentions:
        return "Mentions";
      case ActivityType.verified:
        return "Verified";
      case ActivityType.follow:
        return "Follow";
      case ActivityType.like:
        return "Like";
      case ActivityType.repost:
        return "Repost";
      case ActivityType.quote:
        return "Quote";
    }
  }
}

extension SettingMenuExtension on SettingMenu {
  IconData get menuIcon {
    switch (this) {
      case SettingMenu.friends:
        return FontAwesomeIcons.userPlus;
      case SettingMenu.notifications:
        return FontAwesomeIcons.bell;
      case SettingMenu.privacy:
        return FontAwesomeIcons.lock;
      case SettingMenu.account:
        return FontAwesomeIcons.circleUser;
      case SettingMenu.help:
        return FontAwesomeIcons.lifeRing;
      case SettingMenu.about:
        return FontAwesomeIcons.circleInfo;
    }
  }

  String get menuText {
    switch (this) {
      case SettingMenu.friends:
        return "Follow and invite friends";
      case SettingMenu.notifications:
        return "Notifications";
      case SettingMenu.privacy:
        return "Privacy";
      case SettingMenu.account:
        return "Account";
      case SettingMenu.help:
        return "Help";
      case SettingMenu.about:
        return "About";
    }
  }
}

extension PrivacyMenuExtension on PrivacyMenu {
  IconData get menuIcon {
    switch (this) {
      case PrivacyMenu.private:
        return FontAwesomeIcons.lock;
      case PrivacyMenu.mentions:
        return FontAwesomeIcons.threads;
      case PrivacyMenu.muted:
        return FontAwesomeIcons.bellSlash;
      case PrivacyMenu.hiddenWords:
        return FontAwesomeIcons.eyeSlash;
      case PrivacyMenu.followerProfiles:
        return FontAwesomeIcons.users;
    }
  }

  String get menuText {
    switch (this) {
      case PrivacyMenu.private:
        return "Private profile";
      case PrivacyMenu.mentions:
        return "Mentions";
      case PrivacyMenu.muted:
        return "Muted";
      case PrivacyMenu.hiddenWords:
        return "Hidden Words";
      case PrivacyMenu.followerProfiles:
        return "Profiles you follow";
    }
  }
}

extension DoubleExtension on double {
  double truncateToFirstDecimal() {
    return (this * 10).toInt() / 10.0;
  }

  double roundToHalf() {
    return (this * 2).round() / 2.0;
  }
}

extension ContextExtension on BuildContext {
  double width(double widthSize) {
    return MediaQuery.of(this).size.width * widthSize;
  }

  double height(double heightSize) {
    return MediaQuery.of(this).size.height * heightSize;
  }

  double get deviceWidth {
    return MediaQuery.of(this).size.width;
  }

  double get deviceHeight {
    return MediaQuery.of(this).size.height;
  }

  Orientation get deviceOrientation {
    return MediaQuery.of(this).orientation;
  }

  double get statusBarHeight {
    return MediaQuery.of(this).padding.top;
  }

  double get viewPaddingBottom {
    return MediaQuery.of(this).padding.bottom;
  }

  Brightness get platformBrightness {
    return MediaQuery.of(this).platformBrightness;
  }

  double get viewInsetsBottom {
    return MediaQuery.of(this).viewInsets.bottom;
  }
}
