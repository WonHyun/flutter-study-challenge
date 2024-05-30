import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/widgets/common/color_animated_button.dart';
import 'package:simple_calendar/widgets/todo_list/todo_card.dart';

class TodoList extends StatefulWidget {
  const TodoList({
    super.key,
    required this.todoList,
    required this.selectedDay,
    required this.onAddTap,
    required this.onTodoTap,
  });

  final List<Todo> todoList;
  final DateTime selectedDay;
  final Function(BuildContext, DateTime) onAddTap;
  final Function(BuildContext, Todo) onTodoTap;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return widget.todoList.isEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorAnimatedButton(
                  text: "Let's Create!",
                  width: 350,
                  height: 60,
                  color: Theme.of(context).colorScheme.primary,
                  onTap: () => widget.onAddTap(context, widget.selectedDay),
                ),
              ],
            ),
          )
        : Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 50),
              itemCount: widget.todoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: TodoCard(
                    todo: widget.todoList[index],
                    onTap: () =>
                        widget.onTodoTap(context, widget.todoList[index]),
                  ),
                );
              },
            ),
          );
  }
}
