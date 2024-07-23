import 'package:flutter/material.dart';

class CustomProgressBar extends CustomPainter {
  CustomProgressBar({
    required this.progress,
    this.thickness = 12,
    this.backgroundBarColor = Colors.black12,
    this.barColor = Colors.white,
  });

  final double progress;
  final double thickness;
  final Color backgroundBarColor;
  final Color barColor;

  Paint _paintBar({required Color color}) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final centerHeight = size.height / 2;

    // draw background
    canvas.drawLine(
      Offset(0, centerHeight),
      Offset(size.width, centerHeight),
      _paintBar(color: backgroundBarColor),
    );

    // draw progress
    canvas.drawLine(
      Offset(0, centerHeight),
      Offset(0 + size.width * progress, centerHeight),
      _paintBar(color: barColor),
    );
  }

  @override
  bool shouldRepaint(covariant CustomProgressBar oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
