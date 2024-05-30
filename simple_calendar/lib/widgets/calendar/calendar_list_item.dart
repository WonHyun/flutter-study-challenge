import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/utils/date_util.dart';
import 'package:simple_calendar/widgets/common/sized_dot.dart';

class CalendarListItem extends StatelessWidget {
  const CalendarListItem({
    super.key,
    required this.currentDay,
    required this.selectedDay,
    required this.onTap,
    required this.todoList,
  });

  final DateTime currentDay;
  final DateTime selectedDay;
  final Function(DateTime) onTap;
  final List<Todo> todoList;

  @override
  Widget build(BuildContext context) {
    final isToday = isSameDay(currentDay, DateTime.now());
    final isSelectedDay = isSameDay(currentDay, selectedDay);
    final currentColor = isSelectedDay ? const Color(0xFFB22580) : Colors.grey;
    final hasTodo =
        todoList.lastIndexWhere((todo) => isSameDay(todo.startAt, currentDay)) <
                0
            ? false
            : true;
    return GestureDetector(
      onTap: () => onTap(currentDay),
      child: isToday
          ? Row(
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 100),
                  style: TextStyle(
                    fontSize: isSelectedDay ? 46 : 30,
                    fontWeight:
                        isSelectedDay ? FontWeight.w600 : FontWeight.w300,
                  ),
                  child: const Text("TODAY"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedDot(
                    size: isSelectedDay ? 12 : 8,
                    color: currentColor,
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                if (hasTodo)
                  Positioned(
                    top: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedDot(
                        size: isSelectedDay ? 4 : 6,
                        color: currentColor,
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 100),
                    style: TextStyle(
                      fontSize: isSelectedDay ? 40 : 30,
                      color: currentColor,
                    ),
                    child: Text(DateFormat("dd").format(currentDay)),
                  ),
                ),
              ],
            ),
    );
  }
}
