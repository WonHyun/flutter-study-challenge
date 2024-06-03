import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/common/linked_text.dart';

class UserAgreementGuideProto extends StatelessWidget {
  const UserAgreementGuideProto({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w300,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontWeight: fontWeight,
          fontSize: fontSize,
          height: 1.3,
        ),
        children: [
          const TextSpan(text: "By signing up, your agree to our "),
          WidgetSpan(
            child: LinkedText(
              text: "Terms",
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
          const TextSpan(text: ", "),
          WidgetSpan(
            child: LinkedText(
              text: "Privacy Policy",
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
          const TextSpan(text: ", and "),
          WidgetSpan(
            child: LinkedText(
              text: "Cookie Use",
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
          const TextSpan(text: "."),
        ],
      ),
    );
  }
}
