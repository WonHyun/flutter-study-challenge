import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    super.key,
    this.text,
    this.color = Colors.grey,
    this.thickness = 1,
  });

  final String? text;
  final Color color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
        Offstage(
          offstage: text == null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              text ?? "",
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}
