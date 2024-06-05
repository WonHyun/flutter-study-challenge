import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/global/strings.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';
import 'package:twitter_clone/screens/common/policy_guide_text.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/twitter_app_bar.dart';
import 'package:twitter_clone/screens/sign_up/personalize_agreement_screen.dart';
import 'package:twitter_clone/screens/sign_up/widgets/bottom_date_picker_bar.dart';
import 'package:twitter_clone/screens/sign_up/widgets/user_info_text_field.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

  bool _isShowDatePicker = false;
  bool _isNextActive = false;
  bool _isPersonalizeAgree = true;

  final DateTime _initialDate =
      DateTime.now().subtract(const Duration(days: 365 * 12));

  void _onCancelTap(BuildContext context) {
    Navigator.pop(context);
  }

  void _onScaffoldTap(BuildContext context) {
    FocusScope.of(context).unfocus();
    setState(() {
      _isShowDatePicker = false;
    });
  }

  void _onNextTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalizeAgreementScreen(
          isAgree: _isPersonalizeAgree,
          onAgreementChanged: _onAgreementChanged,
        ),
      ),
    );
  }

  void _onAgreementChanged(bool isAgree) {
    _isPersonalizeAgree = isAgree;
  }

  void _onDateChanged(DateTime date) {
    final formattedDate = DateFormat("MMMM d, y").format(date);
    setState(() {
      _birthController.value = TextEditingValue(text: formattedDate);
    });
  }

  void _onTapBirthdayField() {
    setState(() {
      _isShowDatePicker = true;
    });
  }

  String? _isNameValidator(String? name) {
    if (name == null || name.isEmpty) return "Enter your Name.";
    return null;
  }

  String? _isEmailValidator(String? email) {
    if (email == null || email.isEmpty) return "Enter your email.";
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return "Not valid email.";
    }
    return null;
  }

  String? _isBirthValidator(String? date) {
    if (date == null || date.isEmpty) return "Enter your Birthday.";
    return null;
  }

  void _isNextValidator() {
    setState(() {
      if (_isNameValidator(_nameController.text) == null &&
          _isEmailValidator(_emailController.text) == null &&
          _isBirthValidator(_birthController.text) == null) {
        _isNextActive = true;
      } else {
        _isNextActive = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      _isNextValidator();
    });

    _emailController.addListener(() {
      _isNextValidator();
    });

    _birthController.addListener(() {
      _isNextValidator();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onScaffoldTap(context),
      child: Scaffold(
        appBar: TwitterAppBar(
          leading: Center(
            child: LinkedText(
              text: "Cancel",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.inverseSurface,
              onTap: () => _onCancelTap(context),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: UserInfoTextField(
                      textInputType: TextInputType.name,
                      labelText: "Name",
                      guideText: "Name",
                      floatingLabelText: "Name",
                      controller: _nameController,
                      validator: _isNameValidator,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: UserInfoTextField(
                      textInputType: TextInputType.emailAddress,
                      labelText: "Phone number or email address",
                      guideText: "Phone number or email address",
                      floatingLabelText: "Email",
                      controller: _emailController,
                      validator: _isEmailValidator,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: _onTapBirthdayField,
                      child: UserInfoTextField(
                        textInputType: TextInputType.datetime,
                        labelText: "Date of birth",
                        guideText: "Date of birth",
                        floatingLabelText: "Date of birth",
                        controller: _birthController,
                        validator: _isBirthValidator,
                        isEnabled: false,
                      ),
                    ),
                  ),
                  const PolicyGuideText(mdText: dateOfBirthPolicyGuideText),
                ],
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Offstage(
                      offstage: true,
                      child: Text(
                        "Use Phone instead",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                    RoundedButton(
                      width: 65,
                      height: 35,
                      text: "Next",
                      fontColor: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      backgroundColor:
                          Theme.of(context).colorScheme.inverseSurface,
                      isActive: _isNextActive,
                      onTap: () => _onNextTap(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomDatePickerBar(
          showDatePicker: _isShowDatePicker,
          onDateChanged: _onDateChanged,
          initialDate: _initialDate,
        ),
      ),
    );
  }
}
