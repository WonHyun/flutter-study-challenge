import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/color.dart';
import 'package:twitter_clone/global/path.dart';
import 'package:twitter_clone/global/strings.dart';
import 'package:twitter_clone/screens/common/horizontal_divider.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';
import 'package:twitter_clone/screens/common/user_agreement_guide.dart';
import 'package:twitter_clone/screens/login/widgets/logo_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: const FaIcon(
                FontAwesomeIcons.twitter,
                color: twitterColor,
              ),
              centerTitle: true,
            ),
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
                LogoButton(
                  logo: SvgPicture.asset(
                    googleLogoPath,
                    width: 22,
                  ),
                  guideText: "Continue with Google",
                  onTap: () => {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: LogoButton(
                    logo: const FaIcon(FontAwesomeIcons.apple, size: 24),
                    guideText: "Continue with Apple",
                    onTap: () => {},
                  ),
                ),
                HorizontalDivider(text: "or", color: Colors.grey.shade300),
                LogoButton(
                  guideText: "Create account",
                  isInversedColor: true,
                  onTap: () => {},
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: UserAgreementGuide(
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
