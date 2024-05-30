import 'package:flutter/material.dart';
import 'package:pomotimer/provider/pomodoro_provider.dart';
import 'package:pomotimer/widgets/time_panel.dart';
import 'package:provider/provider.dart';

class TimerView extends StatefulWidget {
  const TimerView({
    super.key,
  });

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PomodoroProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimePanel(time: provider.getCurrentSeconds().substring(0, 2)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            ":",
            style: TextStyle(
              color: provider.tick % 2 == 0
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TimePanel(time: provider.getCurrentSeconds().substring(2)),
      ],
    );
  }
}
