import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_calendar/global/values.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/utils/date_util.dart';

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({
    super.key,
    required this.onChangeDay,
    required this.selectedDay,
    required this.todoList,
  });

  final Function(DateTime) onChangeDay;
  final DateTime selectedDay;
  final List<Todo> todoList;

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${weekday[today.weekday]} ${today.day}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dayList.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: CalendarListItem(
                    currentDay: dayList[index],
                    selectedDay: widget.selectedDay,
                    onTap: widget.onChangeDay,
                    todoList: widget.todoList,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

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
    final hasTodo = todoList.lastIndexWhere(
                (todo) => isSameDay(todo.startTime, currentDay)) <
            0
        ? false
        : true;
    return GestureDetector(
      onTap: () => onTap(currentDay),
      child: isToday
          ? Row(
              children: [
                Text(
                  "TODAY",
                  style: TextStyle(
                    fontSize: isSelectedDay ? 46 : 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.lens,
                    color: currentColor,
                    size: 12,
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                hasTodo
                    ? Positioned(
                        top: 16,
                        left: 0,
                        right: 0,
                        child: Icon(
                          Icons.lens,
                          color: currentColor,
                          size: 8,
                        ),
                      )
                    : const SizedBox.shrink(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    DateFormat("dd").format(currentDay),
                    style: TextStyle(fontSize: 30, color: currentColor),
                  ),
                ),
              ],
            ),
    );
  }
}
