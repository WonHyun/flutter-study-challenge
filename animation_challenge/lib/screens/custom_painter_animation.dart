import 'package:animation_challenge/screens/widgets/circle_progress_bar.dart';
import 'package:flutter/material.dart';

class CustomPainterAnimation extends StatefulWidget {
  const CustomPainterAnimation({super.key});

  @override
  State<CustomPainterAnimation> createState() => _CustomPainterAnimationState();
}

class _CustomPainterAnimationState extends State<CustomPainterAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _progress;

  bool _isPlaying = false;
  bool _isDone = false;

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isPlaying = false;
            _isDone = true;
          });
        } else {
          if (_isDone) {
            setState(() {
              _isDone = false;
            });
          }
        }
      });
    _progress =
        Tween<double>(begin: 0.0, end: 2.0).animate(_animationController);
  }

  void _startTimer() {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.forward();
    }
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseTimer() {
    _animationController.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _resetTimer() {
    _animationController.reset();
    setState(() {
      _isPlaying = false;
    });
  }

  String _getMinuteString() {
    if (_animationController.duration != null) {
      final duration =
          _animationController.duration! * (1.0 - _animationController.value);
      return duration.inMinutes.toString().padLeft(2, "0");
    }
    return "00";
  }

  String _getSecondString() {
    if (_animationController.duration != null) {
      final duration =
          _animationController.duration! * (1.0 - _animationController.value);
      return (duration.inSeconds % 60).toString().padLeft(2, "0");
    }
    return "00";
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Painter"),
      ),
      body: AnimatedBuilder(
          animation: _progress,
          builder: (context, child) {
            return Stack(
              children: [
                if (_isDone)
                  const Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Text(
                      "Done!",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: CustomPaint(
                    size: const Size(250, 250),
                    painter: CircleProgressBar(
                      progress: _progress.value,
                      barColor: const Color(0xFFFF676B),
                      backgroundBarColor: const Color(0xFFEEEEEE),
                      thickness: 20,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _getMinuteString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                        ),
                      ),
                      const Text(
                        ":",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                        ),
                      ),
                      Text(
                        _getSecondString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _resetTimer,
                        icon: const Icon(Icons.restore),
                        iconSize: 42,
                      ),
                      const SizedBox(width: 10),
                      _isPlaying
                          ? IconButton(
                              onPressed: _pauseTimer,
                              icon: const Icon(Icons.pause),
                              iconSize: 42,
                            )
                          : IconButton(
                              onPressed: _startTimer,
                              icon: const Icon(Icons.play_arrow),
                              iconSize: 42,
                            ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: _resetTimer,
                        icon: const Icon(Icons.stop),
                        iconSize: 42,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
