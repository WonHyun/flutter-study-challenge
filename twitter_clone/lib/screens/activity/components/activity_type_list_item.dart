import 'package:flutter/material.dart';
import 'package:twitter_clone/global/enum.dart';
import 'package:twitter_clone/global/extensions.dart';

class ActivityTypeListItem extends StatelessWidget {
  const ActivityTypeListItem({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTap,
    this.width = 100,
  });

  final ActivityType type;
  final bool isSelected;
  final Function() onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: width,
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.inverseSurface
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
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
            child: Text(type.labelName),
          ),
        ),
      ),
    );
  }
}
