import 'package:flutter/material.dart';

class CustomPainterAnimation extends StatefulWidget {
  const CustomPainterAnimation({super.key});

  @override
  State<CustomPainterAnimation> createState() => _CustomPainterAnimationState();
}

class _CustomPainterAnimationState extends State<CustomPainterAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Painter"),
      ),
    );
  }
}
