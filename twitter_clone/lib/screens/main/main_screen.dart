import 'package:flutter/material.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/screens/home/home_screen.dart';
import 'package:twitter_clone/screens/main/widgets/bottom_navigation_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainScreenType _currentScreen = MainScreenType.home;

  void _onTapNav(MainScreenType type) => setState(() => _currentScreen = type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Offstage(
            offstage: _currentScreen != MainScreenType.home,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _currentScreen != MainScreenType.search,
            child: Container(),
          ),
          Offstage(
            offstage: _currentScreen != MainScreenType.post,
            child: Container(),
          ),
          Offstage(
            offstage: _currentScreen != MainScreenType.likes,
            child: Container(),
          ),
          Offstage(
            offstage: _currentScreen != MainScreenType.user,
            child: Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: MainScreenType.values
                .map(
                  (type) => BottomNavigationTab(
                    selectedIcon: type.selectedIcon,
                    unselectedIcon: type.unselectedIcon,
                    isSelected: _currentScreen == type,
                    onTap: () => _onTapNav(type),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
