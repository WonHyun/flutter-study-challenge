import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/utils/date_util.dart';
import 'package:simple_calendar/widgets/common/color_animated_button.dart';
import 'package:simple_calendar/widgets/common/label_selector.dart';
import 'package:simple_calendar/widgets/todo_edit/attendees_input.dart';
import 'package:simple_calendar/widgets/todo_edit/date_controll_panel.dart';
import 'package:simple_calendar/widgets/todo_edit/todo_info_edit.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    super.key,
    required this.todo,
    required this.onSaveTodo,
    required this.onRemoveTodo,
    this.isNewTodo = false,
  });

  final Todo todo;
  final Function(Todo) onSaveTodo;
  final Function(Todo) onRemoveTodo;
  final bool isNewTodo;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final minuteInterval = 5;

  late final DateTime _minimumDate;
  late Todo _todo;

  void updateTodo({
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? attendees,
    Color? labelColor,
  }) {
    setState(() {
      _todo = _todo.copyWith(
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        attendees: attendees,
        labelColor: labelColor,
      );
    });
  }

  void _onScaffoldTap() => FocusScope.of(context).unfocus();

  void _onChangeTitle(String title) {
    updateTodo(title: title);
  }

  void _onChangeDescription(String description) {
    updateTodo(description: description);
  }

  void _onChangeDate({
    required DateTime startAt,
    required DateTime endAt,
  }) {
    updateTodo(startTime: startAt, endTime: endAt);
  }

  void _onAttendeeSubmit(String name) {
    final newAttendees = [..._todo.attendees, name];
    updateTodo(attendees: newAttendees);
  }

  void _onAttendeeRemove(int index) {
    final newAttendees = [..._todo.attendees];
    newAttendees.removeAt(index);
    updateTodo(attendees: newAttendees);
  }

  void _onTodoSubmit() {
    final title = _todo.title == "" ? "No Title" : _todo.title;
    final description =
        _todo.description == "" ? "No Description" : _todo.description;
    updateTodo(title: title, description: description);
    widget.onSaveTodo(_todo);
    Navigator.pop(context);
  }

  void _onRemoveTodo(Todo todo) {
    widget.onRemoveTodo(todo);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    _todo = widget.todo;
    final now = adjustNow(DateTime.now(), minuteInterval);
    _minimumDate = getDateTimeFromYearsToMinute(now);

    if (widget.isNewTodo) {
      final startAt =
          _todo.startAt.isBefore(_minimumDate) ? _minimumDate : _todo.startAt;

      final endAt = startAt;

      updateTodo(startTime: startAt, endTime: endAt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: const Text("TODO"),
          actions: [
            IconButton(
              onPressed: () => _onRemoveTodo(_todo),
              icon: const Icon(Icons.delete_outline),
            )
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                  bottom: 80,
                ),
                child: Column(
                  children: [
                    TodoInfoEdit(
                      todo: _todo,
                      onChangeTitle: _onChangeTitle,
                      onChangeDescription: _onChangeDescription,
                    ),
                    const SizedBox(height: 30),
                    DateControllPanel(
                      todo: _todo,
                      minuteInterval: minuteInterval,
                      minimumDate: _minimumDate,
                      onChangeDate: _onChangeDate,
                    ),
                    AttendeesEditPanel(
                      todo: _todo,
                      onAttendeeSubmit: _onAttendeeSubmit,
                      onAttendeeRemove: _onAttendeeRemove,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Choose a Label",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: LabelSelector(
                          onChangeLabelColor: (color) =>
                              updateTodo(labelColor: color)),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ColorAnimatedButton(
                  text: "Save",
                  width: 350,
                  height: 60,
                  color: _todo.labelColor,
                  onTap: _onTodoSubmit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
