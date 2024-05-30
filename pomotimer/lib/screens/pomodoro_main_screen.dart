import 'package:flutter/material.dart';
import 'package:pomotimer/provider/pomodoro_provider.dart';
import 'package:pomotimer/widgets/guide_text.dart';
import 'package:pomotimer/widgets/pomodoro_app_bar.dart';
import 'package:pomotimer/widgets/progress_status_indicator.dart';
import 'package:pomotimer/widgets/timer_control_panel.dart';
import 'package:pomotimer/widgets/timer_selector.dart';
import 'package:pomotimer/widgets/timer_view.dart';
import 'package:provider/provider.dart';

class PomodoroMainScreen extends StatelessWidget {
  const PomodoroMainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PomodoroProvider())
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              PomodoroAppBar(onTapMenu: () => {}),
              const SizedBox(height: 20),
              const GuideText(),
              const SizedBox(height: 30),
              const TimerView(),
              const SizedBox(height: 30),
              const TimerSelector(),
              const SizedBox(height: 30),
              const TimerControlPanel(),
              const SizedBox(height: 30),
              const ProgressStatusIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
