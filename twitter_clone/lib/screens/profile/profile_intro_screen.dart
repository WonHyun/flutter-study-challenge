import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/profile/profile_screen.dart';
import 'package:twitter_clone/screens/setting/privacy/privacy_screen.dart';
import 'package:twitter_clone/screens/setting/setting_screen.dart';

class ProfileIntroScreen extends StatefulWidget {
  const ProfileIntroScreen({super.key});

  @override
  State<ProfileIntroScreen> createState() => _ProfileIntroScreenState();
}

class _ProfileIntroScreenState extends State<ProfileIntroScreen> {
  final PageController _controller = PageController();

  void _changePage(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      children: [
        ProfileScreen(
          onTapSettings: () => _changePage(1),
        ),
        SettingScreen(
          onTapBack: () => _changePage(0),
          onTapPrivacy: () => _changePage(2),
        ),
        PrivacyScreen(
          onTapBack: () => _changePage(1),
        ),
      ],
    );
  }
}
