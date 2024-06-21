import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  const FlashButton({
    super.key,
    required this.flashMode,
    required this.onPressed,
  });

  final FlashMode flashMode;
  final Function() onPressed;

  IconData _getIcon(FlashMode mode) {
    switch (mode) {
      case FlashMode.off:
        return Icons.flash_off_rounded;
      case FlashMode.auto:
        return Icons.flash_auto_rounded;
      case FlashMode.always:
        return Icons.flash_on_rounded;
      case FlashMode.torch:
        return Icons.flashlight_on_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      onPressed: onPressed,
      icon: Icon(
        _getIcon(flashMode),
      ),
    );
  }
}
