import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/utils/date_util.dart';

class TodoTimeView extends StatelessWidget {
  const TodoTimeView({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          getTimeString(todo.startAt.hour),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        Text(
          getTimeString(todo.startAt.minute),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            height: 0.9,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: Container(
            width: 1,
            height: 26,
            color: Colors.black,
          ),
        ),
        Text(
          getTimeString(todo.endAt.hour),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        Text(
          getTimeString(todo.endAt.minute),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            height: 0.9,
          ),
        ),
      ],
    );
  }
}
