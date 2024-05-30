import 'package:flutter/material.dart';
import 'package:pomotimer/global/theme.dart';
import 'package:pomotimer/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class PomodoroDrawer extends StatelessWidget {
  const PomodoroDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Change Theme"),
                  Switch(
                    trackColor: WidgetStateProperty.resolveWith((states) =>
                        Theme.of(context).colorScheme.inverseSurface),
                    thumbColor: WidgetStateProperty.resolveWith(
                        (states) => Theme.of(context).colorScheme.surface),
                    value: provider.themeType == ThemeType.eggplant,
                    onChanged: (value) => provider.onChangeTheme(
                      value ? ThemeType.eggplant : ThemeType.tomato,
                    ),
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
