import 'package:flutter/material.dart';
import 'package:simple_calendar/test/mock.dart';
import 'package:simple_calendar/widgets/common/circle_image_button.dart';

class HomeDrawerMenu extends StatelessWidget {
  const HomeDrawerMenu({
    super.key,
    required this.isDarkTheme,
    required this.onChangeTheme,
  });

  final bool isDarkTheme;
  final VoidCallback onChangeTheme;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleImageButton(),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello ${userInfo.userName}!",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        "How are you today?",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dark Theme"),
                  Switch(
                    value: isDarkTheme,
                    onChanged: (value) => onChangeTheme(),
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
