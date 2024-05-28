import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/screens/todo_detail_screen.dart';
import 'package:simple_calendar/widgets/todo_card.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todoList,
  });

  final List<Todo> todoList;

  void _onSelectTodo(BuildContext context, Todo todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoDetailScreen(todo: todo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: Text(
                    "+ Let's create TODO!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  onPressed: () => {},
                ),
              ],
            ),
          )
        : Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 50),
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: TodoCard(
                    todo: todoList[index],
                    onTap: () => _onSelectTodo(context, todoList[index]),
                  ),
                );
              },
            ),
          );
  }
}
