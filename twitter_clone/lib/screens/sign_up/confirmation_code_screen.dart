import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/color.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/twitter_app_bar.dart';
import 'package:twitter_clone/screens/sign_up/password_screen.dart';
import 'package:twitter_clone/screens/sign_up/widgets/pin_text_field.dart';
import 'package:twitter_clone/screens/sign_up/widgets/screen_guide_text.dart';

class ConfirmationCodeScreen extends ConsumerStatefulWidget {
  const ConfirmationCodeScreen({super.key});

  @override
  ConsumerState<ConfirmationCodeScreen> createState() =>
      _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState
    extends ConsumerState<ConfirmationCodeScreen> {
  void _onScaffoldTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
      (route) => false,
    );
  }

  void _onEmailResend() {}

  @override
  void initState() {
    super.initState();
    //TODO: email send logic
  }

  @override
  Widget build(BuildContext context) {
    final userInfoState = ref.watch(userInfoProvider);
    final pinVerifyState = ref.watch(pinVerifyProvider);
    final pinVerifyNotifier = ref.watch(pinVerifyProvider.notifier);
    return PopScope(
      onPopInvoked: (didPop) => pinVerifyNotifier.resetVerifyState(),
      child: GestureDetector(
        onTap: () => _onScaffoldTap(context),
        child: Scaffold(
          appBar: const TwitterAppBar(isUseBackArrowLeading: true),
          body: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenGuideText(
                          title: "We sent you a code",
                          guideText:
                              "Enter it below to verify\n${userInfoState.userInfo.email}.",
                        ),
                        const SizedBox(height: 20),
                        PinTextField(
                          onSubmit: (pin) => pinVerifyNotifier.verifyPin(pin),
                          isEnabled: !pinVerifyState.isVerifying &&
                              !pinVerifyState.isVerified,
                        ),
                        const SizedBox(height: 20),
                        Consumer(
                          builder: (context, ref, child) {
                            if (pinVerifyState.isVerifying) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            } else if (pinVerifyState.isVerified) {
                              return const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  color: ThemeColors.verifyColor,
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!pinVerifyState.isVerifying &&
                        !pinVerifyState.isVerified)
                      LinkedText(
                        text: "Didn't receive email?",
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        onTap: _onEmailResend,
                      ),
                    const SizedBox(height: 20),
                    RoundedButton(
                      text: "Next",
                      isActive: pinVerifyState.isVerified,
                      centerWidget: pinVerifyState.isVerifying
                          ? const CupertinoActivityIndicator()
                          : null,
                      fontColor: Theme.of(context).colorScheme.surface,
                      backgroundColor:
                          Theme.of(context).colorScheme.inverseSurface,
                      onTap: () => _onNextTap(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
