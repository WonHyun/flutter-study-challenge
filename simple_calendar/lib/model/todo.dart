import 'package:flutter/material.dart';
import 'package:simple_calendar/global/colors.dart';
import 'package:simple_calendar/utils/generator_util.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> attendees;
  final Color labelColor;

  Todo({
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? attendees,
    Color? labelColor,
  })  : id = uuid.v4(),
        title = title ?? "",
        description = description ?? "",
        startTime = startTime ?? DateTime.now(),
        endTime = endTime ?? DateTime.now(),
        attendees = attendees ?? const [],
        labelColor = labelColor ?? LabelColors.lemon;

  Todo copyWith({
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    List<String>? attendees,
    Color? labelColor,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      attendees: attendees ?? this.attendees,
      labelColor: labelColor ?? this.labelColor,
    );
  }
}
