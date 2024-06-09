import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/twitter_app_bar.dart';
import 'package:twitter_clone/screens/sign_up/interests_screen.dart';
import 'package:twitter_clone/screens/sign_up/widgets/screen_guide_text.dart';
import 'package:twitter_clone/screens/sign_up/widgets/user_info_text_field.dart';
import 'package:twitter_clone/util/valid_util.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  bool _isNextActive = false;

  void _onNextTap(BuildContext context) {
    //TODO: need to password submit logic.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
      (route) => false,
    );
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
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: const TwitterAppBar(),
        body: Stack(
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
                isActive: _isNextActive,
                fontColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                onTap: () => _onNextTap(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
