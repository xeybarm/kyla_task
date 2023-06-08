import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final double buttonSize;
  final Function() onTap;
  const CircleButton({
    super.key,
    required this.icon,
    required this.buttonSize,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
