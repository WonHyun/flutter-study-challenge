import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/global/breakpoint.dart';
import 'package:twitter_clone/global/path.dart';
import 'package:twitter_clone/global/strings.dart';
import 'package:twitter_clone/screens/common/horizontal_divider.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';
import 'package:twitter_clone/screens/common/policy_guide_text.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/thread_app_bar.dart';
import 'package:twitter_clone/screens/login/email_login_screen.dart';
import 'package:twitter_clone/screens/sign_up/create_account_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  static const String routeName = "login";
  static const String routePath = "/login";

  void _onSignUpTap(BuildContext context) {
    context.pushNamed(CreateAccountScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailLoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThreadAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: ScreenWidth.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Flexible(
                  flex: 2,
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
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedButton(
                        leading: const FaIcon(FontAwesomeIcons.solidEnvelope,
                            size: 24),
                        text: "Continue with Email",
                        onTap: () => _onEmailTap(context),
                      ),
                      const SizedBox(height: 10),
                      RoundedButton(
                        leading: SvgPicture.asset(
                          googleLogoPath,
                          width: 22,
                        ),
                        text: "Continue with Google",
                        onTap: () => {},
                      ),
                      const SizedBox(height: 10),
                      RoundedButton(
                        leading: const FaIcon(FontAwesomeIcons.apple, size: 24),
                        text: "Continue with Apple",
                        onTap: () => {},
                      ),
                      const SizedBox(height: 10),
                      HorizontalDivider(
                          text: "or", color: Colors.grey.shade300),
                      RoundedButton(
                        text: "Create account",
                        fontColor: Theme.of(context).colorScheme.surface,
                        backgroundColor:
                            Theme.of(context).colorScheme.inverseSurface,
                        onTap: () => _onSignUpTap(context),
                      ),
                    ],
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: PolicyGuideText(
                      mdText: userAgreementGuideTextShort,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                      children: [
                        const TextSpan(text: "Have no an account? "),
                        WidgetSpan(
                          child: LinkedText(
                            onTap: () => _onSignUpTap(context),
                            text: "Sign up",
                            fontSize: 14,
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
        ),
      ),
    );
  }
}
