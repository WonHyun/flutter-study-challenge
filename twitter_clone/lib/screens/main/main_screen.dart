import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/home/home_screen.dart';
import 'package:twitter_clone/screens/main/widgets/bottom_navigation_tab.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState = ref.watch(mainScreenProvider);
    final screenNotifier = ref.watch(mainScreenProvider.notifier);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Offstage(
              offstage: screenState.currentScreen != MainScreenType.home,
              child: const HomeScreen(),
            ),
            Offstage(
              offstage: screenState.currentScreen != MainScreenType.search,
              child: Container(),
            ),
            Offstage(
              offstage: screenState.currentScreen != MainScreenType.post,
              child: Container(),
            ),
            Offstage(
              offstage: screenState.currentScreen != MainScreenType.likes,
              child: Container(),
            ),
            Offstage(
              offstage: screenState.currentScreen != MainScreenType.user,
              child: Container(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: MainScreenType.values
                .map(
                  (type) => BottomNavigationTab(
                    selectedIcon: type.selectedIcon,
                    unselectedIcon: type.unselectedIcon,
                    isSelected: screenState.currentScreen == type,
                    onTap: () => screenNotifier.updateCurrentScreen(type),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
