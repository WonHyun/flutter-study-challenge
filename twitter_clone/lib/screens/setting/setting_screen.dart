import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/providers/notifiers/login_notifier.dart';
import 'package:twitter_clone/providers/notifiers/setting_notifier.dart';
import 'package:twitter_clone/screens/common/adaptive_dialog_action.dart';
import 'package:twitter_clone/screens/login/login_screen.dart';
import 'package:twitter_clone/screens/setting/common/setting_app_bar.dart';
import 'package:twitter_clone/screens/setting/common/theme_mode_selector.dart';
import 'package:twitter_clone/screens/setting/privacy/privacy_screen.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({
    super.key,
  });

  static const routeName = "setting";
  static const routePath = "/setting";

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  Future<void> _onLogout() async {
    await ref.read(loginProvider.notifier).logout();

    if (ref.read(loginProvider).hasError) {
      final erroMsg = ref.read(loginProvider).error as FirebaseException;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            content: Text(erroMsg.message ?? "Something is wrong"),
          ),
        );
      }
    } else if (mounted) {
      context.goNamed(LoginScreen.routeName);
    }
  }

  Future<void> _onLogActionTap(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text("Confirm Logout"),
          content: const Text(
            "Are you sure you want to log out?",
          ),
          actions: [
            AdaptiveDialogAction(
                context: context,
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Not yet",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                )),
            AdaptiveDialogAction(
                context: context,
                onPressed: () async {
                  await _onLogout();
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )),
          ],
        );
      },
    );
  }

  void _onTapMenu(BuildContext context, SettingMenu menu) {
    switch (menu) {
      case SettingMenu.friends:
      case SettingMenu.notifications:
        return;
      case SettingMenu.privacy:
        context.pushNamed(PrivacyScreen.routeName);
        return;
      case SettingMenu.account:
      case SettingMenu.help:
        return;
      case SettingMenu.about:
        showAboutDialog(
          context: context,
          applicationName: "Thread Clone",
          applicationVersion: "0.1-beta",
          applicationLegalese: "MIT license",
        );
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    return Consumer(builder: (context, ref, child) {
      final settingState = ref.watch(settingProvider);
      final settingNotifier = ref.read(settingProvider.notifier);
      return Material(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingAppBar(
                title: "Settings",
                onTapLeading: () => context.pop(),
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 0.5,
                height: 0,
              ),
              ...SettingMenu.values.map(
                (value) => ListTile(
                  onTap: () => _onTapMenu(context, value),
                  leading: Icon(
                    value.menuIcon,
                    size: 18,
                  ),
                  title: Text(
                    value.menuText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.palette,
                  size: 18,
                ),
                title: const Text(
                  "Theme Mode",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                trailing: ThemeModeSelector(
                  onThemeChanged: settingNotifier.updateThemeMode,
                  currentThemeMode: settingState.themeMode,
                ),
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 0.5,
                height: 0,
              ),
              ListTile(
                onTap: () => _onLogActionTap(context),
                title: const Text(
                  "Log out",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                trailing: loginState.isLoading
                    ? const CupertinoActivityIndicator(radius: 10)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
