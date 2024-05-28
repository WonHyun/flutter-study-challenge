import 'package:flutter/material.dart';
import 'package:simple_calendar/widgets/common/circle_image_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.imgPath,
    this.onUserTap,
    this.onAddTap,
  });

  final String? imgPath;
  final VoidCallback? onUserTap;
  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: CircleImageButton(imgPath: imgPath, onTap: onUserTap),
      actions: [
        IconButton(
          onPressed: onAddTap,
          icon: const Icon(Icons.add, size: 40),
        ),
      ],
    );
  }
}
