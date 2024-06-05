import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/strings.dart';
import 'package:twitter_clone/screens/common/policy_guide_text.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/twitter_app_bar.dart';

class PersonalizeAgreementScreen extends StatefulWidget {
  const PersonalizeAgreementScreen({
    super.key,
    required this.isAgree,
    required this.onAgreementChanged,
  });

  final bool isAgree;
  final Function(bool) onAgreementChanged;

  @override
  State<PersonalizeAgreementScreen> createState() =>
      _PersonalizeAgreementScreenState();
}

class _PersonalizeAgreementScreenState
    extends State<PersonalizeAgreementScreen> {
  late bool _isAgree;

  void _onBackTap(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _isAgree = widget.isAgree;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TwitterAppBar(
        leading: GestureDetector(
          onTap: () => _onBackTap(context),
          child: const Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(FontAwesomeIcons.arrowLeft, size: 24)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(
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
                      value: _isAgree,
                      onChanged: (value) => setState(() {
                        _isAgree = value;
                        widget.onAgreementChanged(value);
                      }),
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
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: RoundedButton(
                text: "Next",
                isActive: _isAgree,
                fontColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                onTap: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
