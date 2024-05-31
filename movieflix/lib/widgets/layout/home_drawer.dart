import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflix/global/theme.dart';
import 'package:movieflix/providers/providers.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final themeNotifier = ref.watch(themeProvider.notifier);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Switch(
                    value: themeState.theme == MovieflixTheme.dark,
                    onChanged: (value) => themeNotifier.switchTheme(value),
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
