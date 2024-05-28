import 'package:flutter/material.dart';

class Todo {
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  List<String> attendees;
  Color labelColor;

  Todo({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.attendees,
    required this.labelColor,
  });
}
