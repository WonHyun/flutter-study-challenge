import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/screens/common/adaptive_dialog_action.dart';
import 'package:twitter_clone/screens/setting/common/setting_app_bar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
  });

  static const routeName = "setting";
  static const routePath = "/setting";

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isLoading = false;
  bool _isAlreadyLogin = true;

  //TODO: will be remove, This is for test
  Future<void> _onLogout() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      _isAlreadyLogin = !_isAlreadyLogin;
    });
  }

  Future<void> _onLogActionTap(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(_isAlreadyLogin ? "Confirm Logout" : "Login"),
          content: Text(
            _isAlreadyLogin ? "Are you sure you want to log out?" : "Do login",
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
                onPressed: () {
                  Navigator.pop(context);
                  _onLogout();
                },
                child: Text(
                  _isAlreadyLogin ? "Logout" : "Login",
                  style: const TextStyle(
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
    return SingleChildScrollView(
      child: Column(
        children: [
          SettingAppBar(
            title: "Settings",
            onTapLeading: () => {},
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 0.5,
            height: 0,
          ),
          ...SettingMenu.values.map(
            (value) => ListTile(
              onTap: () => _onTapMenu(context, value),
              leading: FaIcon(
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
          Divider(
            color: Colors.grey.shade300,
            thickness: 0.5,
            height: 0,
          ),
          ListTile(
            onTap: () => _onLogActionTap(context),
            title: Text(
              _isAlreadyLogin ? "Log out" : "Log in",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
            trailing: _isLoading
                ? const CupertinoActivityIndicator(radius: 10)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}