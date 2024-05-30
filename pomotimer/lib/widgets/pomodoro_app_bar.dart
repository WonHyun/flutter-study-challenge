import 'package:flutter/material.dart';

class PomodoroAppBar extends StatelessWidget {
  const PomodoroAppBar({
    super.key,
    required this.onMenuTap,
  });

  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: onMenuTap,
        icon: const Icon(Icons.menu),
      ),
      title: const Text(
        "POMOTIMER",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
