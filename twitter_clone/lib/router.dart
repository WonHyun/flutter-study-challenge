import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/screens/activity/activity_screen.dart';
import 'package:twitter_clone/screens/home/home_screen.dart';
import 'package:twitter_clone/screens/main/main_screen.dart';
import 'package:twitter_clone/screens/profile/profile_screen.dart';
import 'package:twitter_clone/screens/search/search_screen.dart';
import 'package:twitter_clone/screens/setting/privacy/privacy_screen.dart';
import 'package:twitter_clone/screens/setting/setting_screen.dart';
import 'package:twitter_clone/util/url_util.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: HomeScreen.routePath,
  redirect: (context, state) {
    if (state.matchedLocation == "/") {
      return HomeScreen.routePath;
    }
    return null;
  },
  routes: [
    ShellRoute(
      parentNavigatorKey: _rootNavigatorKey,
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          name: HomeScreen.routeName,
          path: HomeScreen.routePath,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: Searchscreen.routeName,
          path: Searchscreen.routePath,
          builder: (context, state) => const Searchscreen(),
        ),
        GoRoute(
          name: ActivityScreen.routeName,
          path: ActivityScreen.routePath,
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          name: ProfileScreen.routeName,
          path: ProfileScreen.routePath,
          builder: (context, state) {
            final initTab = state.uri.queryParameters["show"];
            return ProfileScreen(
              initTab: convToInitTabFromUrlQuery(initTab),
            );
          },
        ),
        GoRoute(
          name: SettingScreen.routeName,
          path: SettingScreen.routePath,
          builder: (context, state) => const SettingScreen(),
          routes: [
            GoRoute(
              name: PrivacyScreen.routeName,
              path: PrivacyScreen.routePath,
              builder: (context, state) => const PrivacyScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
