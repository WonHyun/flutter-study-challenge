import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/utils/date_util.dart';
import 'package:simple_calendar/widgets/common/label_time.dart';

class DateControllPanel extends StatefulWidget {
  const DateControllPanel({
    super.key,
    required this.todo,
    required this.minuteInterval,
    required this.minimumDate,
    required this.onChangeDate,
  });

  final Todo todo;
  final int minuteInterval;
  final DateTime minimumDate;
  final Function({
    required DateTime startAt,
    required DateTime endAt,
  }) onChangeDate;

  @override
  State<DateControllPanel> createState() => _DateControllPanelState();
}

class _DateControllPanelState extends State<DateControllPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            getYYYYMMDD(widget.todo.startTime),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LabelTime(
            labelText: "Start At",
            time: widget.todo.startTime,
            timeColor: widget.todo.labelColor,
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: widget.todo.startTime,
                    minimumDate: widget.minimumDate,
                    onDateTimeChanged: (newDateTime) => widget.onChangeDate(
                      startAt: newDateTime,
                      endAt: newDateTime,
                    ),
                    minuteInterval: widget.minuteInterval,
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LabelTime(
            labelText: "End At",
            time: widget.todo.endTime,
            timeColor: widget.todo.labelColor,
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: widget.todo.startTime,
                    minimumDate: widget.todo.startTime,
                    maximumDate: DateTime(
                      widget.todo.startTime.year,
                      widget.todo.startTime.month,
                      widget.todo.startTime.day,
                      23,
                      60 - widget.minuteInterval,
                    ),
                    onDateTimeChanged: (newDateTime) => widget.onChangeDate(
                      startAt: widget.todo.startTime,
                      endAt: newDateTime,
                    ),
                    minuteInterval: widget.minuteInterval,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
