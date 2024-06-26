import 'package:flutter/material.dart';
import 'package:simple_calendar/global/colors.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/screens/todo_screen.dart';
import 'package:simple_calendar/utils/date_util.dart';
import 'package:simple_calendar/widgets/calendar/home_calendar.dart';
import 'package:simple_calendar/widgets/home/home_app_bar.dart';
import 'package:simple_calendar/widgets/home/home_drawer_menu.dart';
import 'package:simple_calendar/widgets/todo_list/todo_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isDarktheme = true;
  DateTime _selectedDay = DateTime.now();
  final List<Todo> _todoList = [];

  void _onAddTap(BuildContext context, DateTime selectedDay) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => TodoScreen(
          todo: Todo(startTime: selectedDay, endTime: selectedDay),
          onSaveTodo: _onSaveTodo,
          onRemoveTodo: _onRemoveTodo,
          isNewTodo: true,
        ),
      ),
    );
  }

  void _onTodoTap(BuildContext context, Todo todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => TodoScreen(
          todo: todo,
          onSaveTodo: _onSaveTodo,
          onRemoveTodo: _onRemoveTodo,
        ),
      ),
    );
  }

  void _onUserTap() => _scaffoldKey.currentState?.openDrawer();
  void _onScaffoldTap() => _scaffoldKey.currentState?.closeDrawer();
  void _onChangeDay(DateTime day) => setState(() => _selectedDay = day);
  void _toggleTheme() => setState(() => _isDarktheme = !_isDarktheme);

  List<Todo> _getSelectedDaysTodoList() =>
      _todoList.where((todo) => isSameDay(todo.startAt, _selectedDay)).toList();

  void _onSaveTodo(Todo todo) {
    final index = _todoList.indexWhere((element) => element.id == todo.id);
    if (index < 0) {
      _todoList.add(todo);
    } else {
      _todoList[index] = todo;
    }
    setState(() {
      _todoList.sort((a, b) => a.startAt.compareTo(b.startAt));
    });
  }

  void _onRemoveTodo(Todo todo) {
    setState(() {
      _todoList.removeWhere((element) => element.id == todo.id);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarktheme
          ? ThemeData(
              colorScheme: const ColorScheme.dark(primary: ThemeColors.primary),
            )
          : ThemeData(
              colorScheme:
                  const ColorScheme.light(primary: ThemeColors.primary),
            ),
      home: GestureDetector(
        onTap: _onScaffoldTap,
        child: Scaffold(
          key: _scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: HomeAppBar(
                    onAddTap: _onAddTap,
                    onUserTap: _onUserTap,
                    selectedDay: _selectedDay,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HomeCalendar(
                    onChangeDay: _onChangeDay,
                    selectedDay: _selectedDay,
                    todoList: _todoList,
                  ),
                ),
                TodoList(
                  todoList: _getSelectedDaysTodoList(),
                  selectedDay: _selectedDay,
                  onAddTap: _onAddTap,
                  onTodoTap: _onTodoTap,
                )
              ],
            ),
          ),
          drawer: HomeDrawerMenu(
            isDarkTheme: _isDarktheme,
            onChangeTheme: _toggleTheme,
          ),
        ),
      ),
    );
  }
}
