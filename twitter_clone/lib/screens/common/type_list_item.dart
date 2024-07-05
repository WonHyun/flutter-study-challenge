import 'package:flutter/material.dart';

class TypeListItem extends StatelessWidget {
  const TypeListItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.width = 100,
    this.height = 30,
  });

  final String text;
  final bool isSelected;
  final Function() onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.inverseSurface
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.inverseSurface
                : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.inverseSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
