import 'dart:math';

import 'package:animation_challenge/global/values.dart';
import 'package:animation_challenge/screens/widgets/animated_progress_bar.dart';
import 'package:animation_challenge/screens/widgets/flash_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Direction {
  left,
  right,
}

class BackgroundColor {
  static const blue = Color(0xFF40CAFE);
  static const red = Color(0xFFFF7952);
  static const green = Color(0xFF71DD7A);
}

class FlashCardsScreen extends StatefulWidget {
  const FlashCardsScreen({super.key});

  @override
  State<FlashCardsScreen> createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  int _quizIndex = 0;

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late final Tween<double> _rotaion = Tween(
    begin: -15,
    end: 15,
  );

  late final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1.0,
  );

  late final Tween<double> _behindCardOpacity = Tween(
    begin: 0.5,
    end: 1.0,
  );

  late final Tween<double> _guideTextOpacity = Tween(
    begin: 0.0,
    end: 1.0,
  );

  late final _leftColor = ColorTween(
    begin: BackgroundColor.blue,
    end: BackgroundColor.red,
  );

  late final _rightColor = ColorTween(
    begin: BackgroundColor.blue,
    end: BackgroundColor.green,
  );

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;

    if (_position.value.abs() >= bound) {
      _swipeCard(
        _position.value.isNegative ? Direction.left : Direction.right,
      );
    } else {
      _position.animateTo(
        0,
        curve: Curves.easeOut,
      );
    }
  }

  void _whenSwipeComplete() {
    _position.value = 0;
    setState(() {
      _quizIndex = (_quizIndex + 1) % quizs.length;
    });
  }

  void _swipeCard(Direction direction) {
    final dropZone = size.width + 100;
    int factor;

    switch (direction) {
      case Direction.left:
        factor = -1;
      case Direction.right:
        factor = 1;
    }
    _position
        .animateTo(
          dropZone * factor,
          curve: Curves.easeOut,
        )
        .whenComplete(_whenSwipeComplete);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flash Cards"),
      ),
      body: AnimatedBuilder(
          animation: _position,
          builder: (context, child) {
            final angle = _rotaion.transform(
                    (_position.value + size.width / 2) / size.width) *
                pi /
                180;
            final scale = _scale.transform(_position.value.abs() / size.width);
            final behindCardOpacity = _behindCardOpacity
                .transform(_position.value.abs() / size.width);
            final backgroundColor = _position.value.isNegative
                ? _leftColor.transform(clampDouble(
                    _position.value.abs() * 3 / size.width, 0.0, 1.0))
                : _rightColor.transform(clampDouble(
                    _position.value.abs() * 3 / size.width, 0.0, 1.0));
            final guideText = _position.value.isNegative
                ? "Need to review"
                : "I got it right";
            final guideTextOpacity = _guideTextOpacity.transform(
                clampDouble(_position.value.abs() * 10 / size.width, 0.0, 1.0));
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: guideTextOpacity,
                    child: Text(
                      guideText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: angle == 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Transform.scale(
                      scale: min(scale, 1.0),
                      child: Opacity(
                        opacity: min(behindCardOpacity, 1.0),
                        child: FlashCard(
                          width: size.width * 0.8,
                          height: size.height * 0.5,
                          quiz: quizs[(_quizIndex + 1) % quizs.length],
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onHorizontalDragUpdate: _onHorizontalDragUpdate,
                    onHorizontalDragEnd: _onHorizontalDragEnd,
                    child: Transform.translate(
                      offset: Offset(_position.value, 0),
                      child: Transform.rotate(
                        angle: angle,
                        child: FlashCard(
                          width: size.width * 0.8,
                          height: size.height * 0.5,
                          quiz: quizs[_quizIndex],
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  right: 50,
                  bottom: 50,
                  child: AnimatedProgressBar(
                    duration: const Duration(milliseconds: 300),
                    progress: (_quizIndex + 1) / quizs.length,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
