import 'package:flutter/material.dart';

class SettingState {
  final ThemeMode themeMode;
  final bool isPrivateProfile;

  const SettingState({
    this.themeMode = ThemeMode.system,
    this.isPrivateProfile = false,
  });

  SettingState copyWith({
    ThemeMode? themeMode,
    bool? isPrivateProfile,
  }) {
    return SettingState(
      themeMode: themeMode ?? this.themeMode,
      isPrivateProfile: isPrivateProfile ?? this.isPrivateProfile,
    );
  }
}
