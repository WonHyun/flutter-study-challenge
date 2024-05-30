import 'package:flutter/material.dart';

class SizedDot extends StatelessWidget {
  const SizedDot({
    super.key,
    required this.size,
    required this.color,
    this.duration = const Duration(milliseconds: 100),
  });

  final double size;
  final Color color;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: size,
      height: size,
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(360),
      ),
    );
  }
}
