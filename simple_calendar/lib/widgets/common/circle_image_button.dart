import 'package:flutter/material.dart';

class CircleImageButton extends StatelessWidget {
  const CircleImageButton({
    super.key,
    this.imgPath,
    this.onTap,
    this.size = 50,
  });

  final double? size;
  final String? imgPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(360);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(
            imgPath ?? "assets/images/cyber-kitty.jpg",
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
        ),
      ),
    );
  }
}
