import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/widgets/todo_attendees_list_view.dart';
import 'package:simple_calendar/widgets/todo_time_view.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;
  final VoidCallback? onTap;

  const TodoCard({
    super.key,
    required this.todo,
    this.onTap,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30);
    return Container(
      decoration: BoxDecoration(
        color: widget.todo.labelColor,
        borderRadius: borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TodoTimeView(todo: widget.todo),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.todo.title.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 50,
                          height: 0.9,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TodoAttendeesListView(todo: widget.todo),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
