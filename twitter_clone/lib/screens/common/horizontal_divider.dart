import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    super.key,
    this.text,
    this.color,
    this.thickness = 1,
  });

  final String? text;
  final Color? color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: color ??
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
            thickness: thickness,
          ),
        ),
        if (text != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              text ?? "",
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        Expanded(
          child: Divider(
            color: color ??
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}
