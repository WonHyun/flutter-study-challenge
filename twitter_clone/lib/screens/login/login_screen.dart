import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/path.dart';
import 'package:twitter_clone/global/strings.dart';
import 'package:twitter_clone/screens/common/horizontal_divider.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';
import 'package:twitter_clone/screens/common/policy_guide_text.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/twitter_app_bar.dart';
import 'package:twitter_clone/screens/sign_up/create_account_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  void _onSignUpTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateAccountScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TwitterAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 130),
              child: Center(
                child: Text(
                  "See What's happening in the world right now.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  leading: SvgPicture.asset(
                    googleLogoPath,
                    width: 22,
                  ),
                  text: "Continue with Google",
                  onTap: () => {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: RoundedButton(
                    leading: const FaIcon(FontAwesomeIcons.apple, size: 24),
                    text: "Continue with Apple",
                    onTap: () => {},
                  ),
                ),
                HorizontalDivider(text: "or", color: Colors.grey.shade300),
                RoundedButton(
                  text: "Create account",
                  fontColor: Theme.of(context).colorScheme.surface,
                  backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                  onTap: () => _onSignUpTap(context),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: PolicyGuideText(
                mdText: userAgreementGuideTextShort,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: RichText(
                textAlign: TextAlign.start,
                text: const TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                  children: [
                    TextSpan(text: "Have an account already? "),
                    WidgetSpan(
                      child: LinkedText(
                        text: "Log in",
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
