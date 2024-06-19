import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/extensions.dart';
import 'package:twitter_clone/screens/setting/common/setting_app_bar.dart';
import 'package:twitter_clone/screens/setting/common/slash_heart_icon.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({
    super.key,
  });

  static const routeName = "privacy";
  static const routePath = "/privacy";

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _isPrivateProfile = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SettingAppBar(
              title: "Privacy",
              onTapLeading: () => context.pop(),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.5,
              height: 0,
            ),
            SwitchListTile.adaptive(
              activeColor: Colors.black,
              value: _isPrivateProfile,
              onChanged: (value) => setState(() {
                _isPrivateProfile = value;
              }),
              secondary: FaIcon(
                PrivacyMenu.private.menuIcon,
                size: 18,
              ),
              title: Text(
                PrivacyMenu.private.menuText,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            ...PrivacyMenu.values.map(
              (value) {
                if (value == PrivacyMenu.private) {
                  return const SizedBox.shrink();
                }
                return ListTile(
                  onTap: () => {},
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (value == PrivacyMenu.mentions) ...[
                        Text(
                          "Everyone",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: 14,
                        color: Colors.grey.shade500,
                      ),
                    ],
                  ),
                );
              },
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.5,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Other privacy settings",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: FaIcon(
                          FontAwesomeIcons.arrowUpRightFromSquare,
                          size: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () => {},
              leading: const FaIcon(
                FontAwesomeIcons.circleXmark,
                size: 18,
              ),
              title: const Text(
                "Blocked profiles",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: FaIcon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                size: 14,
                color: Colors.grey.shade500,
              ),
            ),
            ListTile(
              onTap: () => {},
              leading: const SlashHeartIcon(),
              title: const Text(
                "Hide likes",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: FaIcon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                size: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
