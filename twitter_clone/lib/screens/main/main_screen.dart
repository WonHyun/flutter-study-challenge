import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/activity/activity_screen.dart';
import 'package:twitter_clone/screens/home/home_screen.dart';
import 'package:twitter_clone/screens/main/widgets/bottom_navigation_tab.dart';
import 'package:twitter_clone/screens/posting/posting_modal.dart';
import 'package:twitter_clone/screens/search/search_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  Future<void> _onChangeScreens(
    BuildContext context,
    WidgetRef ref,
    MainScreenType type,
  ) async {
    final screenNotifier = ref.watch(mainScreenProvider.notifier);
    if (type == MainScreenType.posting) {
      await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        context: context,
        builder: (context) {
          return const PostingModal();
        },
      );
      ref.watch(postingProvider.notifier).resetPostingInfo();
      screenNotifier.updateCurrentScreen(MainScreenType.home);
    } else {
      screenNotifier.updateCurrentScreen(type);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState = ref.watch(mainScreenProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: screenState.currentScreen == MainScreenType.home
                ? const HomeScreen()
                : const SizedBox.shrink(),
          ),
          SliverToBoxAdapter(
            child: screenState.currentScreen == MainScreenType.search
                ? const Searchscreen()
                : const SizedBox.shrink(),
          ),
          SliverToBoxAdapter(
            child: screenState.currentScreen == MainScreenType.activity
                ? const ActivityScreen()
                : const SizedBox.shrink(),
          ),
          SliverToBoxAdapter(
            child: screenState.currentScreen == MainScreenType.user
                ? Container()
                : const SizedBox.shrink(),
          ),
        ],
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
                    onTap: () => _onChangeScreens(context, ref, type),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
