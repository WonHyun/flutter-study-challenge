import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/test/mock.dart';

class TodoAttendeesListView extends StatelessWidget {
  const TodoAttendeesListView({
    super.key,
    required this.todo,
    this.max = 3,
  });

  final Todo todo;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(todo.attendees.length, (index) {
        final isMe = todo.attendees[index] == userInfo.userName;
        if (index < max) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              isMe ? "ME" : todo.attendees[index].toUpperCase(),
              style: TextStyle(
                color: isMe ? Colors.black : Colors.black38,
                fontSize: 14,
              ),
            ),
          );
        } else if (index == max) {
          return Text(
            "+${todo.attendees.length - max}",
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 14,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
