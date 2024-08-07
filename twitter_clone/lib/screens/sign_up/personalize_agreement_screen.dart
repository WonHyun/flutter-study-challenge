import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/breakpoint.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/strings.dart';
import 'package:twitter_clone/models/user_profile.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/screens/common/policy_guide_text.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/thread_app_bar.dart';
import 'package:twitter_clone/screens/sign_up/create_account_screen.dart';

class PersonalizeAgreementScreen extends ConsumerWidget {
  const PersonalizeAgreementScreen({
    super.key,
  });

  void _onNextTap(BuildContext context, UserProfile userInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateAccountScreen(initUserInfo: userInfo),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);
    return Scaffold(
      appBar: const ThreadAppBar(isUseBackArrowLeading: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: ScreenWidth.sm),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Customize your experience",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Track where you see Twitter content across the web",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            CupertinoSwitch(
                              value: userState.value?.agreementStatus[
                                      PolicyType.personalize] ??
                                  false,
                              onChanged: (value) =>
                                  userNotifier.updateAgreementStatus(
                                      PolicyType.personalize, value),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        PolicyGuideText(
                          mdText: userAgreementGuideTextMiddle,
                          fontSize: 12,
                          fontColor: Theme.of(context)
                              .colorScheme
                              .inverseSurface
                              .withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: RoundedButton(
                    text: "Next",
                    isActive: userState
                            .value?.agreementStatus[PolicyType.personalize] ??
                        false,
                    fontColor: Theme.of(context).colorScheme.surface,
                    backgroundColor:
                        Theme.of(context).colorScheme.inverseSurface,
                    onTap: () => _onNextTap(context, userState.value!),
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
