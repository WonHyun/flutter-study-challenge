import 'package:flutter/material.dart';
import 'package:simple_calendar/global/values.dart';
import 'package:simple_calendar/model/todo.dart';
import 'package:simple_calendar/model/user.dart';
import 'package:simple_calendar/utils/generator_util.dart';

final userInfo = User(
  userId: uuid.v4(),
  userName: "Nico",
);

final todos = [
  Todo(
    title: "Design Meeting",
    description: "design meeting",
    startTime: DateTime(today.year, today.month, today.day, 11, 30),
    endTime: DateTime(today.year, today.month, today.day, 12, 20),
    attendees: ["Alex", "Helena", "Nana"],
    labelColor: const Color(0xFFFEF754),
  ),
  Todo(
    title: "Daily Project",
    description: "Team Project",
    startTime: DateTime(today.year, today.month, today.day, 12, 35),
    endTime: DateTime(today.year, today.month, today.day, 14, 10),
    attendees: [
      "Nico",
      "Richard",
      "Ciry",
      "Michel",
      "Shelle",
      "Raman",
      "Kumin",
    ],
    labelColor: const Color(0xFF9C6BCE),
  ),
  Todo(
    title: "Weekly Planning",
    description: "check the plan",
    startTime: DateTime(today.year, today.month, today.day, 15, 00),
    endTime: DateTime(today.year, today.month, today.day, 16, 30),
    attendees: ["Den", "Nana", "Mark"],
    labelColor: const Color(0xFFBBEE4B),
  ),
  Todo(
    title: "Enjoy your life",
    description: "check the plan",
    startTime: DateTime(today.year, today.month, today.day + 1, 12, 34),
    endTime: DateTime(today.year, today.month, today.day + 1, 15, 32),
    attendees: ["Nico", "Nana", "Mark"],
    labelColor: const Color(0xFF11AA4B),
  ),
  Todo(
    title: "New Project",
    description: "Team Project",
    startTime: DateTime(today.year, today.month, today.day + 3, 12, 35),
    endTime: DateTime(today.year, today.month, today.day + 3, 14, 10),
    attendees: [
      "Nico",
      "Richard",
      "Ciry",
      "Michel",
      "Shelle",
      "Raman",
      "Kumin",
    ],
    labelColor: const Color(0xFF9C6BCE),
  ),
];
