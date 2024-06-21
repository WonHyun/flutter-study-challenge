import 'package:flutter/material.dart';

class ShutterButton extends StatefulWidget {
  const ShutterButton({
    super.key,
    required this.onTap,
    this.size = 60,
  });

  final double size;
  final Function() onTap;

  @override
  State<ShutterButton> createState() => _ShutterButtonState();
}

class _ShutterButtonState extends State<ShutterButton> {
  bool isTapping = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) => setState(() {
        isTapping = true;
      }),
      onTapUp: (details) => setState(() {
        isTapping = false;
      }),
      onTapCancel: () => setState(() {
        isTapping = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.all(isTapping ? 10 : 5),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
