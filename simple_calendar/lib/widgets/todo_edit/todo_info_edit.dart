import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';

class TodoInfoEdit extends StatefulWidget {
  const TodoInfoEdit({
    super.key,
    required this.todo,
    required this.onChangeTitle,
    required this.onChangeDescription,
  });

  final Todo todo;
  final Function(String title) onChangeTitle;
  final Function(String description) onChangeDescription;

  @override
  State<TodoInfoEdit> createState() => _TodoInfoEditState();
}

class _TodoInfoEditState extends State<TodoInfoEdit> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    _titleController.text = widget.todo.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(fontSize: 20),
            border: InputBorder.none,
          ),
          onChanged: (title) => widget.onChangeTitle(title),
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            hintText: "Description",
            hintStyle: TextStyle(fontSize: 20),
            border: InputBorder.none,
          ),
          maxLines: 3,
          onChanged: (description) => widget.onChangeDescription(description),
        ),
      ],
    );
  }
}
