import 'package:flutter/material.dart';

class ColorAnimatedButton extends StatelessWidget {
  const ColorAnimatedButton({
    super.key,
    this.text = "Button",
    this.color = Colors.amber,
    this.onTap,
    this.duration = const Duration(milliseconds: 200),
    this.width = 200,
    this.height = 50,
  });

  final String text;
  final Color color;
  final VoidCallback? onTap;
  final Duration duration;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
