import 'package:flutter/material.dart';
import 'package:simple_calendar/utils/date_util.dart';

class LabelTime extends StatelessWidget {
  const LabelTime({
    super.key,
    required this.labelText,
    required this.time,
    this.timeColor,
    this.onTap,
  });

  final String labelText;
  final DateTime time;
  final Color? timeColor;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(width: 20),
          Text(
            getHHMM(time),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
