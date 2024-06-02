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
  final ScrollController _controller = ScrollController();
  final List<GlobalKey> _keys =
      List.generate(dayList.length, (index) => GlobalKey());

  Future<void> _scrollToCurrentItem(int index) async {
    if (_keys[index].currentContext != null) {
      RenderBox box =
          _keys[index].currentContext?.findRenderObject() as RenderBox;

      double itemSize = box.size.width;
      double targetOffset = itemSize * (index.toDouble() - 2);
      double maxScrollExtent = _controller.position.maxScrollExtent;

      if (targetOffset < 0) {
        await _controller.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else if (targetOffset > maxScrollExtent) {
        await _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        await _controller.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${weekday[today.weekday - 1]} ${today.day}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: dayList.length,
            itemBuilder: (context, index) {
              return Align(
                key: _keys[index],
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: CalendarListItem(
                    currentDay: dayList[index],
                    selectedDay: widget.selectedDay,
                    onTap: (date) {
                      widget.onChangeDay(date);
                      _scrollToCurrentItem(index);
                    },
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
