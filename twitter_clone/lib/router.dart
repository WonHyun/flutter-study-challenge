import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/models/user_profile.dart';
import 'package:twitter_clone/repository/authentication_repository.dart';
import 'package:twitter_clone/screens/activity/activity_screen.dart';
import 'package:twitter_clone/screens/home/home_screen.dart';
import 'package:twitter_clone/screens/login/login_screen.dart';
import 'package:twitter_clone/screens/main/main_screen.dart';
import 'package:twitter_clone/screens/profile/profile_screen.dart';
import 'package:twitter_clone/screens/search/search_post_screen.dart';
import 'package:twitter_clone/screens/search/search_user_screen.dart';
import 'package:twitter_clone/screens/setting/privacy/privacy_screen.dart';
import 'package:twitter_clone/screens/setting/setting_screen.dart';
import 'package:twitter_clone/screens/sign_up/create_account_screen.dart';
import 'package:twitter_clone/screens/sign_up/interests_screen.dart';
import 'package:twitter_clone/util/url_util.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: HomeScreen.routePath,
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != CreateAccountScreen.routePath &&
              state.matchedLocation != LoginScreen.routePath) {
            return LoginScreen.routePath;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routePath,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: CreateAccountScreen.routeName,
          path: CreateAccountScreen.routePath,
          builder: (context, state) {
            final extra = state.extra;
            return CreateAccountScreen(
              initUserInfo:
                  extra != null && extra is UserProfile ? extra : null,
            );
          },
        ),
        GoRoute(
          name: InterestsScreen.routeName,
          path: InterestsScreen.routePath,
          builder: (context, state) => const InterestsScreen(),
        ),
        ShellRoute(
          parentNavigatorKey: _rootNavigatorKey,
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            late MainScreenType type;
            switch (state.matchedLocation) {
              case HomeScreen.routePath:
                type = MainScreenType.home;
              case SearchUserScreen.routePath:
                type = MainScreenType.search;
              case ActivityScreen.routePath:
                type = MainScreenType.activity;
              case ProfileScreen.routePath:
              default:
                type = MainScreenType.user;
            }
            return MainScreen(
              type: type,
              child: child,
            );
          },
          routes: [
            GoRoute(
              name: HomeScreen.routeName,
              path: HomeScreen.routePath,
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              name: SearchUserScreen.routeName,
              path: SearchUserScreen.routePath,
              builder: (context, state) => const SearchUserScreen(),
              routes: [
                GoRoute(
                  path: SearchPostScreen.routePath,
                  name: SearchPostScreen.routeName,
                  builder: (context, state) {
                    final keyword = state.extra as String?;
                    return SearchPostScreen(keyword: keyword ?? "");
                  },
                ),
              ],
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
  },
);
