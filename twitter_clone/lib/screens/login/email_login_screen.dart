import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/global/breakpoint.dart';
import 'package:twitter_clone/providers/notifiers/login_notifier.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/thread_app_bar.dart';
import 'package:twitter_clone/screens/home/home_screen.dart';
import 'package:twitter_clone/screens/sign_up/create_account_screen.dart';
import 'package:twitter_clone/screens/sign_up/widgets/user_info_text_field.dart';
import 'package:twitter_clone/util/valid_util.dart';

class EmailLoginScreen extends ConsumerStatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  ConsumerState<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends ConsumerState<EmailLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isNextActive = false;

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

  Future<void> _onLoginTap() async {
    await ref.read(loginProvider.notifier).loginWithEmail(
          _emailController.text,
          _passwordController.text,
        );

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
      context.goNamed(HomeScreen.routeName);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const ThreadAppBar(isUseBackArrowLeading: true),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: ScreenWidth.sm),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Flexible(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Log in with Email or Phone number",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Form(
                      key: _formKey,
                      onChanged: _isNextValidator,
                      child: Column(
                        children: [
                          UserInfoTextField(
                            controller: _emailController,
                            isEnabled: true,
                            textInputType: TextInputType.emailAddress,
                            labelText: "Phone number or email address",
                            guideText: "Phone number or email address",
                            floatingLabelText: "Email",
                            validator: FormValidator.emailValidator,
                            onSaved: (value) => {},
                          ),
                          const SizedBox(height: 10),
                          UserInfoTextField(
                            controller: _passwordController,
                            labelText: "Password",
                            floatingLabelText: "Password",
                            validator: FormValidator.passwordValidator,
                            guideText: "More than 8 characters",
                            isObscure: true,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(height: 26),
                          RoundedButton(
                            centerWidget: loginState.isLoading
                                ? const CupertinoActivityIndicator()
                                : null,
                            text: "Log in",
                            onTap: _onLoginTap,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            fontColor: Colors.white,
                            isActive: _isNextActive && !loginState.isLoading,
                          ),
                          const SizedBox(height: 20),
                          LinkedText(
                            text: "Forgot password?",
                            color: Theme.of(context).colorScheme.inverseSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "Create new acctount",
                    onTap: () =>
                        context.pushNamed(CreateAccountScreen.routeName),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.meta,
                            size: 22,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Meta",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
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
      ),
    );
  }
}
