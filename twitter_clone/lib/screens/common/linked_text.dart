import 'package:flutter/material.dart';

class LinkedText extends StatefulWidget {
  const LinkedText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w300,
    this.color = Colors.blue,
    this.onTap,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Function()? onTap;

  @override
  State<LinkedText> createState() => _LinkedTextState();
}

class _LinkedTextState extends State<LinkedText> {
  late Color _textColor;

  void _handleOnTapDown() =>
      setState(() => _textColor = widget.color.withOpacity(0.4));

  void _handleOnTapUp() => setState(() => _textColor = widget.color);

  void onTapAnimation() {
    _handleOnTapDown();
    Future.delayed(const Duration(milliseconds: 100), () => _handleOnTapUp());
  }

  void _handleOnTap() {
    onTapAnimation();
    widget.onTap?.call();
  }

  @override
  void initState() {
    super.initState();
    _textColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleOnTap,
      onTapDown: (details) => _handleOnTapDown(),
      onTapUp: (details) => _handleOnTapUp(),
      onTapCancel: _handleOnTapUp,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 100),
        style: TextStyle(
          color: _textColor,
          fontWeight: widget.fontWeight,
          fontSize: widget.fontSize,
        ),
        child: Text(widget.text),
      ),
    );
  }
}
