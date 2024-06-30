import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/global/breakpoint.dart';
import 'package:twitter_clone/providers/notifiers/sign_up_notifier.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/thread_app_bar.dart';
import 'package:twitter_clone/screens/sign_up/interests_screen.dart';
import 'package:twitter_clone/screens/sign_up/widgets/screen_guide_text.dart';
import 'package:twitter_clone/screens/sign_up/widgets/user_info_text_field.dart';
import 'package:twitter_clone/util/valid_util.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  bool _isNextActive = false;

  Future<void> _onNextTap() async {
    final email = ref.read(userInfoProvider).userInfo.email;
    await ref.read(signUpProvider.notifier).signUp(email!, _controller.text);
    if (ref.read(signUpProvider).hasError) {
      final erroMsg = ref.read(signUpProvider).error as FirebaseException;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            content: Text(erroMsg.message ?? "Something is wrong"),
          ),
        );
      }
    } else if (mounted) {
      context.goNamed(InterestsScreen.routeName);
    }
  }

  void _isNextValidator() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isNextActive = true;
      });
    } else {
      setState(() {
        _isNextActive = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const ThreadAppBar(),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: ScreenWidth.sm),
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          const ScreenGuideText(
                            title: "You'll need a password",
                            guideText: "Make sure it's 8 characters or more.",
                          ),
                          const SizedBox(height: 20),
                          Form(
                            onChanged: _isNextValidator,
                            key: _formKey,
                            child: UserInfoTextField(
                              controller: _controller,
                              labelText: "Password",
                              floatingLabelText: "Password",
                              validator: FormValidator.passwordValidator,
                              guideText: "More than 8 characters",
                              isObscure: true,
                              textInputType: TextInputType.text,
                            ),
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
                  child: RoundedButton(
                    text: "Next",
                    centerWidget: signUpState.isLoading
                        ? const CupertinoActivityIndicator()
                        : null,
                    isActive: _isNextActive && !signUpState.isLoading,
                    fontColor: Theme.of(context).colorScheme.surface,
                    backgroundColor:
                        Theme.of(context).colorScheme.inverseSurface,
                    onTap: () => _onNextTap(),
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
