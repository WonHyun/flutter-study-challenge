import 'package:flutter/material.dart';

class TimerSelectorItem extends StatelessWidget {
  const TimerSelectorItem({
    super.key,
    required this.time,
    required this.callback,
    this.isSelected = false,
  });

  final int time;
  final bool isSelected;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 75,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.white : null,
        ),
        child: InkWell(
          onTap: () => callback.call(),
          child: Center(
            child: Text(
              "$time",
              style: TextStyle(
                color: isSelected ? const Color(0xFFE64D3D) : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
