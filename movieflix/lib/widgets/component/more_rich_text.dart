import 'package:flutter/material.dart';
import 'package:movieflix/global/colors.dart';

class MoreRichText extends StatefulWidget {
  const MoreRichText({
    super.key,
    required this.text,
    this.maxLines = 5,
  });

  final String text;
  final int maxLines;

  @override
  State<MoreRichText> createState() => _MoreRichTextState();
}

class _MoreRichTextState extends State<MoreRichText> {
  bool _isTapping = false;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final TextSpan textSpan = TextSpan(
        text: widget.text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
        ),
      );

      final TextPainter textPainter = TextPainter(
        text: textSpan,
        maxLines: widget.maxLines,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(maxWidth: constraints.maxWidth);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            maxLines: _isExpanded ? null : widget.maxLines,
            overflow:
                _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            text: TextSpan(
              text: widget.text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
              ),
            ),
          ),
          Offstage(
            offstage: _isExpanded || !textPainter.didExceedMaxLines,
            child: GestureDetector(
              onTap: () => setState(() => _isExpanded = true),
              onTapDown: (details) => setState(() => _isTapping = true),
              onTapUp: (details) => setState(() => _isTapping = false),
              onTapCancel: () => setState(() => _isTapping = false),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 100),
                style: TextStyle(
                  color:
                      _isTapping ? ThemeColors.movieflixPrimary : Colors.amber,
                  fontSize: 18,
                  fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
                  fontWeight: FontWeight.bold,
                ),
                child: const Text("Show More"),
              ),
            ),
          ),
        ],
      );
    });
  }
}
