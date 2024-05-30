import 'package:flutter/material.dart';
import 'package:simple_calendar/global/colors.dart';
import 'package:simple_calendar/utils/generator_util.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final DateTime startAt;
  final DateTime endAt;
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
        startAt = startTime ?? DateTime.now(),
        endAt = endTime ?? DateTime.now(),
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
      startTime: startTime ?? startAt,
      endTime: endTime ?? endAt,
      attendees: attendees ?? this.attendees,
      labelColor: labelColor ?? this.labelColor,
    );
  }
}
