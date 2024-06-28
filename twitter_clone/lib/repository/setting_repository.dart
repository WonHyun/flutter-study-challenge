import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:twitter_clone/global/enum.dart';

class SettingRepository {
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await Hive.box(BoxName.settings.name).put(
      UserSetting.themeMode.name,
      themeMode.index,
    );
  }

  Future<void> setPrivateProfileMode(bool isPrivateProfile) async {
    await Hive.box(BoxName.settings.name).put(
      UserSetting.privateProfile.name,
      isPrivateProfile,
    );
  }

  ThemeMode getThemeMode() {
    final themeModeIndex =
        Hive.box(BoxName.settings.name).get(UserSetting.themeMode.name) ??
            ThemeMode.system.index;
    return ThemeMode.values[themeModeIndex];
  }

  bool getPrivateProfileMode() {
    final isPrivateProfileMode =
        Hive.box(BoxName.settings.name).get(UserSetting.privateProfile.name) ??
            false;
    return isPrivateProfileMode;
  }
}
