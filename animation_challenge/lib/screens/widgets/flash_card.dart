import 'dart:math';

import 'package:animation_challenge/models/quiz.dart';
import 'package:flutter/material.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({
    super.key,
    required this.width,
    required this.height,
    required this.quiz,
    required this.backgroundColor,
  });

  final double width;
  final double height;
  final Quiz quiz;
  final Color backgroundColor;

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  bool _isFlip = false;
  bool _isFlipping = false;

  void _toggleCard() {
    setState(() {
      _isFlip = !_isFlip;
      _isFlipping = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            onEnd: () => setState(() {
              _isFlipping = false;
            }),
            duration: const Duration(milliseconds: 500),
            transform: Matrix4.rotationY(_isFlip ? pi : 0),
            transformAlignment: Alignment.center,
            width: widget.width,
            height: widget.height,
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Container(
            width: widget.width,
            height: widget.height,
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Opacity(
              opacity: _isFlipping ? 0 : 1,
              child: Text(
                _isFlip ? widget.quiz.answer : widget.quiz.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
