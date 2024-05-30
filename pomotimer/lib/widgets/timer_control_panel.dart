import 'package:flutter/material.dart';
import 'package:pomotimer/provider/pomodoro_provider.dart';
import 'package:provider/provider.dart';

enum IconType {
  start,
  pause,
  reset,
  next,
}

class TimerControlPanel extends StatelessWidget {
  const TimerControlPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PomodoroProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        provider.isRunning
            ? CircleIconButton(
                iconType: IconType.pause,
                callback: provider.onPause,
              )
            : Row(
                children: [
                  CircleIconButton(
                    iconType: IconType.reset,
                    callback: provider.onTimerReset,
                  ),
                  const SizedBox(width: 20),
                  CircleIconButton(
                    iconType: IconType.start,
                    callback: provider.onStartTimer,
                  ),
                  const SizedBox(width: 20),
                  CircleIconButton(
                    iconType: IconType.next,
                    callback: provider.onSkipNextCycle,
                  )
                ],
              ),
      ],
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.iconType,
    required this.callback,
  });

  final IconType iconType;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 50,
      color: Colors.white,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Colors.black.withOpacity(0.2),
        ),
      ),
      onPressed: () => callback.call(),
      icon: Builder(builder: (context) {
        switch (iconType) {
          case IconType.start:
            return const Icon(Icons.play_arrow);
          case IconType.pause:
            return const Icon(Icons.pause);
          case IconType.reset:
            return const Icon(Icons.restore);
          case IconType.next:
            return const Icon(Icons.skip_next);
          default:
            return const Icon(Icons.play_arrow);
        }
      }),
    );
  }
}
