import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Circular icon button with light border/shadow used in multiple screens.
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double diameter;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.diameter = 40,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.primary,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: diameter,
      height: diameter,
      child: Material(
        color: backgroundColor,
        shape: const CircleBorder(),
        elevation: 0,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFECEFF3)),
              boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 4))],
            ),
            child: Icon(icon, size: iconSize, color: iconColor),
          ),
        ),
      ),
    );
  }
}
