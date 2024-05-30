import 'package:flutter/material.dart';
import 'package:simple_calendar/global/colors.dart';

class LabelSelector extends StatelessWidget {
  const LabelSelector({
    super.key,
    required this.onChangeLabelColor,
    this.size = 50,
  });

  final Function(Color color) onChangeLabelColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: LabelColors.colorList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onChangeLabelColor(LabelColors.colorList[index]),
            child: Container(
              width: size,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child:
                  CircleAvatar(backgroundColor: LabelColors.colorList[index]),
            ),
          );
        });
  }
}
