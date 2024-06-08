import 'package:flutter/material.dart';

class ScreenGuideText extends StatelessWidget {
  const ScreenGuideText({
    super.key,
    this.title = "",
    this.guideText = "",
  });

  final String title;
  final String guideText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          guideText,
          style: TextStyle(
            color:
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.7),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
