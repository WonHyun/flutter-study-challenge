import 'package:flutter/material.dart';

class LogoButton extends StatelessWidget {
  const LogoButton({
    super.key,
    this.guideText,
    this.logo,
    this.onTap,
    this.isInversedColor = false,
  });

  final Widget? logo;
  final String? guideText;
  final Function()? onTap;
  final bool isInversedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: isInversedColor
            ? Theme.of(context).colorScheme.inverseSurface
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 0.5,
          color: isInversedColor
              ? Theme.of(context).colorScheme.inverseSurface
              : Colors.grey.shade500,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo ?? const SizedBox.shrink(),
              const SizedBox(width: 15),
              Text(
                guideText ?? "",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isInversedColor
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
