import 'package:flutter/material.dart';
import 'package:simple_calendar/global/values.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/widgets/calendar/calendar_list_item.dart';

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
