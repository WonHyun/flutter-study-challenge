import 'package:twitter_clone/global/enum.dart';

class MainScreenState {
  final MainScreenType currentScreen;
  final bool isShowBottomSheet;

  const MainScreenState({
    required this.currentScreen,
    this.isShowBottomSheet = false,
  });

  MainScreenState copyWith({
    MainScreenType? currentScreen,
    bool? isShowBottomSheet,
  }) {
    return MainScreenState(
      currentScreen: currentScreen ?? this.currentScreen,
      isShowBottomSheet: isShowBottomSheet ?? this.isShowBottomSheet,
    );
  }
}
