import 'dart:math';
import 'package:flutter/material.dart';

class CircleProgressBar extends CustomPainter {
  final double progress;
  final Color barColor;
  final Color backgroundBarColor;
  final double thickness;

  CircleProgressBar({
    required this.progress,
    required this.barColor,
    required this.backgroundBarColor,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2);

    const startingAngle = -0.5 * pi;

    // draw back arc
    final circlePaint = Paint()
      ..color = backgroundBarColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    canvas.drawCircle(
      center,
      radius,
      circlePaint,
    );

    // draw arc
    final arcRect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    final arcPaint = Paint()
      ..color = barColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      arcRect,
      startingAngle,
      progress * pi,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CircleProgressBar oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
