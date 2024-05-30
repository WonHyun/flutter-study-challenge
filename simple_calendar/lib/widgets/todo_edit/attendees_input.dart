import 'package:flutter/material.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/widgets/todo_edit/attendee_list_item.dart';

class AttendeesEditPanel extends StatefulWidget {
  const AttendeesEditPanel({
    super.key,
    required this.todo,
    required this.onAttendeeSubmit,
    required this.onAttendeeRemove,
  });

  final Todo todo;
  final Function(String name) onAttendeeSubmit;
  final Function(int index) onAttendeeRemove;

  @override
  State<AttendeesEditPanel> createState() => _AttendeesEditPanelState();
}

class _AttendeesEditPanelState extends State<AttendeesEditPanel> {
  final TextEditingController _attendeesController = TextEditingController();
  final FocusNode _attendeesFocusNode = FocusNode();

  @override
  void dispose() {
    _attendeesController.dispose();
    _attendeesFocusNode.dispose();
    super.dispose();
  }

  void _onAttendeeSubmit(String name) {
    widget.onAttendeeSubmit(name);
    _attendeesController.clear();
    FocusScope.of(context).requestFocus(_attendeesFocusNode);
  }

  void _onAttendeeRemove(int index) {
    widget.onAttendeeRemove(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "Attendees",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: widget.todo.labelColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            focusNode: _attendeesFocusNode,
            controller: _attendeesController,
            decoration: const InputDecoration(
              hintText: "Add to Attendees",
              border: InputBorder.none,
            ),
            onSubmitted: (value) => _onAttendeeSubmit(value),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          direction: Axis.horizontal,
          runSpacing: 10,
          spacing: 10,
          children: List.generate(
            widget.todo.attendees.length,
            (index) {
              return AttendeeListItem(
                name: widget.todo.attendees[index],
                onCancelTap: () => _onAttendeeRemove(index),
                borderColor: widget.todo.labelColor,
              );
            },
          ),
        ),
      ],
    );
  }
}
