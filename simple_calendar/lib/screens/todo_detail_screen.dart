import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';

class TodoDetailScreen extends StatefulWidget {
  const TodoDetailScreen({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.todo.title),
      ),
      body: Column(
        children: [
          Text(widget.todo.title),
          Text(widget.todo.description),
          Text(widget.todo.startTime.toString()),
          Text(widget.todo.endTime.toString()),
          Text(widget.todo.labelColor.toString()),
        ],
      ),
    );
  }
}
