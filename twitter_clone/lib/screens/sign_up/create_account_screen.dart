import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/color.dart';
import 'package:twitter_clone/global/strings.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';
import 'package:twitter_clone/screens/common/policy_guide_text.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _isNameValid = false;
  final TextEditingController _nameController = TextEditingController();

  void _onCancelTap(BuildContext context) {
    Navigator.pop(context);
  }

  void _onScaffoldTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  String? _isEmailValid(String? email) {
    if (email == null || email.isEmpty) return "Enter your email.";
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return "Not valid email.";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      if (_nameController.text.isNotEmpty) {
        setState(() {
          _isNameValid = true;
        });
      } else {
        setState(() {
          _isNameValid = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onScaffoldTap(context),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: AppBar(
              leading: Center(
                child: LinkedText(
                  text: "Cancel",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.inverseSurface,
                  onTap: () => _onCancelTap(context),
                ),
              ),
              title: const FaIcon(
                FontAwesomeIcons.twitter,
                color: ThemeColors.twitterColor,
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                const Text("Create your account"),
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: ThemeColors.twitterColor),
                  decoration: InputDecoration(
                    label: const Text("Name"),
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface),
                    hintText: "Name",
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: Offstage(
                      offstage: !_isNameValid,
                      child: const FaIcon(
                        FontAwesomeIcons.solidCircleCheck,
                        color: ThemeColors.verifyColor,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                const TextField(),
                const TextField(),
                const PolicyGuideText(mdText: dateOfBirthPolicyGuideText),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: RoundedButton(
                width: 80,
                height: 40,
                text: "Next",
                fontColor: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w600,
                backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                isActive: false,
                onTap: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
