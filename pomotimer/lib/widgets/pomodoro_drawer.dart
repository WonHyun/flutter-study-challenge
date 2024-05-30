import 'package:flutter/material.dart';
import 'package:pomotimer/global/theme.dart';
import 'package:pomotimer/provider/pomodoro_provider.dart';
import 'package:pomotimer/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class PomodoroDrawer extends StatelessWidget {
  const PomodoroDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final timerProvider = Provider.of<PomodoroProvider>(context);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Change Theme",
                    style: TextStyle(fontSize: 20),
                  ),
                  Switch(
                    trackColor: WidgetStateProperty.resolveWith((states) =>
                        Theme.of(context).colorScheme.inverseSurface),
                    thumbColor: WidgetStateProperty.resolveWith(
                        (states) => Theme.of(context).colorScheme.surface),
                    value: themeProvider.themeType == ThemeType.eggplant,
                    onChanged: (value) => themeProvider.onChangeTheme(
                      value ? ThemeType.eggplant : ThemeType.tomato,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Rounds",
                    style: TextStyle(fontSize: 20),
                  ),
                  NumberCounter(
                    number: timerProvider.totalRound,
                    onUpTap: () => timerProvider
                        .onChangeMaxRound(timerProvider.totalRound + 1),
                    onDownTap: () => timerProvider
                        .onChangeMaxRound(timerProvider.totalRound - 1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Goals",
                    style: TextStyle(fontSize: 20),
                  ),
                  NumberCounter(
                    number: timerProvider.totalGoal,
                    onUpTap: () => timerProvider
                        .onChangeMaxGoal(timerProvider.totalGoal + 1),
                    onDownTap: () => timerProvider
                        .onChangeMaxGoal(timerProvider.totalGoal - 1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Clear All Progress",
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: timerProvider.onClearAllProgress,
                    icon: const Icon(Icons.delete, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberCounter extends StatelessWidget {
  const NumberCounter({
    super.key,
    required this.number,
    required this.onUpTap,
    required this.onDownTap,
  });

  final int number;
  final VoidCallback onUpTap;
  final VoidCallback onDownTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$number",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            GestureDetector(
              onTap: onUpTap,
              child: Text(
                "▲",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 12,
                ),
              ),
            ),
            GestureDetector(
              onTap: onDownTap,
              child: Text(
                "▼",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
