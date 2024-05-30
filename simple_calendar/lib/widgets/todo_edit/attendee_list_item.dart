import 'package:flutter/material.dart';

class AttendeeListItem extends StatelessWidget {
  const AttendeeListItem({
    super.key,
    required this.name,
    required this.onCancelTap,
    this.borderColor = Colors.amber,
  });

  final Color borderColor;
  final String name;
  final VoidCallback onCancelTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: borderColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          GestureDetector(
            onTap: onCancelTap,
            child: const Icon(Icons.cancel, size: 20),
          ),
        ],
      ),
    );
  }
}
