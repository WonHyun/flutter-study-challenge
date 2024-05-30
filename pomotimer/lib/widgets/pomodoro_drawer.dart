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
