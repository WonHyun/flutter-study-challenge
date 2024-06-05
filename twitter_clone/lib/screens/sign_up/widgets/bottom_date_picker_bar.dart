import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomDatePickerBar extends StatelessWidget {
  const BottomDatePickerBar({
    super.key,
    required this.showDatePicker,
    required this.onDateChanged,
    required this.initialDate,
  });

  final bool showDatePicker;
  final Function(DateTime) onDateChanged;
  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: showDatePicker ? 200 : 0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: onDateChanged,
        initialDateTime: initialDate,
        maximumDate: initialDate,
      ),
    );
  }
}
