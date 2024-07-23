import 'package:animation_challenge/screens/widgets/custom_progress_bar.dart';
import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({
    super.key,
    required this.progress,
    required this.duration,
    this.curves = Curves.easeInOut,
  });

  final double progress;
  final Duration duration;
  final Curve curves;

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..forward();

  late final CurvedAnimation _progressCurved = CurvedAnimation(
    parent: _progress,
    curve: widget.curves,
  );

  late Animation<double> _animation = Tween<double>(
    begin: 0.0,
    end: widget.progress,
  ).animate(_progressCurved);

  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      _animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(_progressCurved);

      _progress
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: CustomProgressBar(
            progress: _animation.value,
          ),
          size: const Size(200, 30),
        );
      },
    );
  }
}
