import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/activity/activity_screen.dart';
import 'package:twitter_clone/screens/home/home_screen.dart';
import 'package:twitter_clone/screens/main/widgets/bottom_navigation_tab.dart';
import 'package:twitter_clone/screens/posting/posting_modal.dart';
import 'package:twitter_clone/screens/profile/profile_screen.dart';
import 'package:twitter_clone/screens/search/search_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const MainNavigaionBar(),
    );
  }
}

class MainNavigaionBar extends ConsumerWidget {
  const MainNavigaionBar({super.key});

  String _getRoutePath(MainScreenType type) {
    switch (type) {
      case MainScreenType.home:
        return HomeScreen.routePath;
      case MainScreenType.search:
        return Searchscreen.routePath;
      case MainScreenType.activity:
        return ActivityScreen.routePath;
      case MainScreenType.user:
        return ProfileScreen.routePath;
      case MainScreenType.posting:
        return HomeScreen.routePath;
    }
  }

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
      context.go(_getRoutePath(MainScreenType.home));
    } else {
      screenNotifier.updateCurrentScreen(type);
      context.go(_getRoutePath(type));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState = ref.watch(mainScreenProvider);
    return BottomAppBar(
      height: 70,
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
    );
  }
}
