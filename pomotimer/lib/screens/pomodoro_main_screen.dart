import 'package:flutter/material.dart';
import 'package:pomotimer/widgets/guide_text.dart';
import 'package:pomotimer/widgets/pomodoro_app_bar.dart';
import 'package:pomotimer/widgets/pomodoro_drawer.dart';
import 'package:pomotimer/widgets/progress_status_indicator.dart';
import 'package:pomotimer/widgets/timer_control_panel.dart';
import 'package:pomotimer/widgets/timer_selector.dart';
import 'package:pomotimer/widgets/timer_view.dart';

class PomodoroMainScreen extends StatefulWidget {
  const PomodoroMainScreen({
    super.key,
  });

  @override
  State<PomodoroMainScreen> createState() => _PomodoroMainScreenState();
}

class _PomodoroMainScreenState extends State<PomodoroMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onMenuTap() => _scaffoldKey.currentState?.openDrawer();
  void _onScaffoldTap() => _scaffoldKey.currentState?.closeDrawer();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              PomodoroAppBar(onMenuTap: _onMenuTap),
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
        drawer: const PomodoroDrawer(),
      ),
    );
  }
}
