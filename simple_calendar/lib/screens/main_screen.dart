import 'package:flutter/material.dart';
import 'package:simple_calendar/global/colors.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/screens/todo_edit_screen.dart';
import 'package:simple_calendar/test/mock.dart';
import 'package:simple_calendar/utils/date_util.dart';
import 'package:simple_calendar/widgets/home_app_bar.dart';
import 'package:simple_calendar/widgets/home_calendar.dart';
import 'package:simple_calendar/widgets/home_drawer_menu.dart';
import 'package:simple_calendar/widgets/todo_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isDarktheme = true;
  DateTime _selectedDay = DateTime.now();
  late final List<Todo> _todoList;

  void _onAddTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TodoEditScreen(),
      ),
    );
  }

  void _onUserTap() => _scaffoldKey.currentState?.openDrawer();
  void _onScaffoldTap() => _scaffoldKey.currentState?.closeDrawer();
  void _onChangeDay(DateTime day) => setState(() => _selectedDay = day);
  void _toggleTheme() => setState(() => _isDarktheme = !_isDarktheme);

  List<Todo> _getSelectedDaysTodoList() => _todoList
      .where((todo) => isSameDay(todo.startTime, _selectedDay))
      .toList();

  @override
  void initState() {
    super.initState();
    todos.sort((a, b) => a.startTime.compareTo(b.startTime));
    _todoList = todos;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarktheme
          ? ThemeData(
              colorScheme: const ColorScheme.dark(
                primary: ThemeColors.primary,
              ),
            )
          : ThemeData(
              colorScheme: const ColorScheme.light(
                primary: ThemeColors.primary,
              ),
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
                TodoList(todoList: _getSelectedDaysTodoList()),
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
