import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/providers/states/main_screen_state.dart';

class MainScreenNotifier extends StateNotifier<MainScreenState> {
  MainScreenNotifier(super.state);

  void updateShowBottomSheet(bool isShow) {
    state = state.copyWith(isShowBottomSheet: isShow);
  }

  void updateCurrentScreen(MainScreenType currentScreen) {
    state = state.copyWith(currentScreen: currentScreen);
  }
}
