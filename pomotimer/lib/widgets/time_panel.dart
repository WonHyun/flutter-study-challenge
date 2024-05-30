import 'package:flutter/material.dart';

class TimePanel extends StatelessWidget {
  const TimePanel({
    super.key,
    required this.time,
  });

  final double _width = 150;
  final double _height = 180;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(0, -10),
          child: Transform.scale(
            scaleX: 0.9,
            child: Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -5),
          child: Transform.scale(
            scaleX: 0.95,
            child: Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: Text(
              time,
              style: const TextStyle(
                color: Color(0xFFE64D3D),
                fontSize: 90,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
