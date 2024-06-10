import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationTab extends StatelessWidget {
  const BottomNavigationTab({
    super.key,
    required this.selectedIcon,
    required this.unselectedIcon,
    this.selectedColor,
    this.unselectedColor,
    this.isSelected = false,
    this.onTap,
  });

  final IconData selectedIcon;
  final IconData unselectedIcon;
  final Color? selectedColor;
  final Color? unselectedColor;
  final bool isSelected;
  final Function()? onTap;

  Color _getIconColor(BuildContext context) {
    if (isSelected) {
      return selectedColor ?? Theme.of(context).colorScheme.inverseSurface;
    } else {
      return unselectedColor ??
          Theme.of(context).colorScheme.inverseSurface.withOpacity(0.3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: FaIcon(
              key: ValueKey(isSelected),
              isSelected ? selectedIcon : unselectedIcon,
              size: 24,
              color: _getIconColor(context),
            ),
          ),
        ),
      ),
    );
  }
}
