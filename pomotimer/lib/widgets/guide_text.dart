import 'package:flutter/material.dart';
import 'package:pomotimer/provider/pomodoro_provider.dart';
import 'package:provider/provider.dart';

class GuideText extends StatelessWidget {
  const GuideText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PomodoroProvider>(context);
    return Center(
      child: Text(
        provider.guideText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}
