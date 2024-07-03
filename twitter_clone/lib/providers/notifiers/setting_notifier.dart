import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/states/setting_state.dart';
import 'package:twitter_clone/repository/setting_repository.dart';

class SettingNotifier extends Notifier<SettingState> {
  final SettingRepository repository;

  SettingNotifier({required this.repository});

  void updateThemeMode(ThemeMode themeMode) {
    if (state.themeMode != themeMode) {
      repository.setThemeMode(themeMode);
      state = state.copyWith(themeMode: themeMode);
    }
  }

  void updatePrivacyProfile(bool isPrivateProfile) {
    if (state.isPrivateProfile != isPrivateProfile) {
      repository.setPrivateProfileMode(isPrivateProfile);
      state = state.copyWith(isPrivateProfile: isPrivateProfile);
    }
  }

  @override
  SettingState build() {
    return SettingState(
      themeMode: repository.getThemeMode(),
      isPrivateProfile: repository.getPrivateProfileMode(),
    );
  }
}

final settingProvider = NotifierProvider<SettingNotifier, SettingState>(
  () => SettingNotifier(
    repository: SettingRepository(),
  ),
);
