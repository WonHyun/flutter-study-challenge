import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/global/color.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/strings.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/providers/notifiers/user_info_notifier.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/screens/common/policy_guide_text.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/twitter_app_bar.dart';
import 'package:twitter_clone/screens/sign_up/confirmation_code_screen.dart';
import 'package:twitter_clone/screens/sign_up/personalize_agreement_screen.dart';
import 'package:twitter_clone/screens/sign_up/widgets/bottom_date_picker_bar.dart';
import 'package:twitter_clone/screens/sign_up/widgets/user_info_text_field.dart';
import 'package:twitter_clone/util/valid_util.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({
    super.key,
    this.initUserInfo,
  });

  final User? initUserInfo;

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthController;

  bool _isShowDatePicker = false;
  bool _isNextActive = false;
  bool _isReadyToSignUp = false;

  final DateTime _initialDate =
      DateTime.now().subtract(const Duration(days: 365 * 12));

  void _onScaffoldTap(BuildContext context) {
    FocusScope.of(context).unfocus();
    setState(() {
      _isShowDatePicker = false;
    });
  }

  void _onNextTap(BuildContext context) {
    final notifier = ref.watch(userInfoProvider.notifier);
    notifier.updateUserName(_nameController.text);
    notifier.updateEmail(_emailController.text);
    notifier
        .updateBirthDate(DateFormat("MMMM d, y").parse(_birthController.text));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PersonalizeAgreementScreen(),
      ),
    );
  }

  void _onSignUpTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ConfirmationCodeScreen()));
  }

  void _onDateChanged(DateTime date, UserInfoNotifier notifier) {
    notifier.updateBirthDate(date);
    setState(() {
      _birthController.value =
          TextEditingValue(text: DateFormat("MMMM d, y").format(date));
    });
  }

  void _onTapBirthdayField() {
    setState(() {
      _isShowDatePicker = true;
    });
  }

  void _isNextValidator() {
    if (FormValidator.nameValidator(_nameController.text) == null &&
        FormValidator.emailValidator(_emailController.text) == null &&
        FormValidator.birthDateValidator(_birthController.text) == null) {
      _isNextActive = true;
    } else {
      _isNextActive = false;
    }
  }

  void _initTextFieldController() {
    _nameController =
        TextEditingController(text: widget.initUserInfo?.userName);
    _emailController = TextEditingController(
        text: widget.initUserInfo?.email ?? widget.initUserInfo?.phoneNum);
    _birthController = TextEditingController(
        text: widget.initUserInfo?.birthDate != null
            ? DateFormat("MMMM d, y").format(widget.initUserInfo!.birthDate!)
            : null);

    _nameController.addListener(() {
      ref.watch(userInfoProvider.notifier).updateUserName(_nameController.text);
      setState(() => _isNextValidator());
    });
    _emailController.addListener(() {
      ref.watch(userInfoProvider.notifier).updateEmail(_emailController.text);
      setState(() => _isNextValidator());
    });
    _birthController.addListener(() {
      setState(() => _isNextValidator());
    });
  }

  @override
  void initState() {
    super.initState();
    _initTextFieldController();
    if (widget.initUserInfo != null) {
      _isReadyToSignUp =
          widget.initUserInfo?.agreementStatus[PolicyType.personalize] ?? false;
    }
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
    final userNotifier = ref.watch(userInfoProvider.notifier);
    return GestureDetector(
      onTap: () => _onScaffoldTap(context),
      child: Scaffold(
        appBar: TwitterAppBar(
          isUseCancelLeading: !_isReadyToSignUp,
          isUseBackArrowLeading: _isReadyToSignUp,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
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
                          isEnabled: !_isReadyToSignUp,
                          textInputType: TextInputType.name,
                          labelText: "Name",
                          guideText: "Name",
                          floatingLabelText: "Name",
                          controller: _nameController,
                          validator: FormValidator.nameValidator,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: UserInfoTextField(
                          isEnabled: !_isReadyToSignUp,
                          textInputType: TextInputType.emailAddress,
                          labelText: "Phone number or email address",
                          guideText: "Phone number or email address",
                          floatingLabelText: "Email",
                          controller: _emailController,
                          validator: FormValidator.emailValidator,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: _isReadyToSignUp ? null : _onTapBirthdayField,
                          child: UserInfoTextField(
                            textInputType: TextInputType.datetime,
                            labelText: "Date of birth",
                            guideText: "Date of birth",
                            floatingLabelText: "Date of birth",
                            controller: _birthController,
                            validator: FormValidator.birthDateValidator,
                            isEnabled: false,
                          ),
                        ),
                      ),
                      if (_isReadyToSignUp) const SizedBox(height: 100),
                      PolicyGuideText(
                          mdText: _isReadyToSignUp
                              ? userAgreementGuideTextFull
                              : dateOfBirthPolicyGuideText),
                    ],
                  ),
                ),
              ),
            ),
            Builder(
              builder: (context) {
                if (_isReadyToSignUp) {
                  return Positioned(
                    bottom: 30,
                    left: 30,
                    right: 30,
                    child: RoundedButton(
                      text: "Sign up",
                      fontColor: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      backgroundColor: ThemeColors.twitterColor,
                      onTap: () => _onSignUpTap(context),
                    ),
                  );
                } else {
                  return Positioned(
                    bottom: 30,
                    left: 0,
                    right: 30,
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
                  );
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomDatePickerBar(
          showDatePicker: _isShowDatePicker,
          onDateChanged: (date) => _onDateChanged(date, userNotifier),
          initialDate: _initialDate,
        ),
      ),
    );
  }
}
