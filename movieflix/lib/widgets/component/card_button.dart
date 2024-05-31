import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.width,
    required this.height,
    required this.imgUrl,
    required this.callback,
  });

  final double width;
  final double height;
  final String imgUrl;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => callback.call(),
        ),
      ),
    );
  }
}
