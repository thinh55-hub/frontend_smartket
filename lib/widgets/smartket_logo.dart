import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

/// Brand logo that can be reused across screens.
class SmartketLogo extends StatelessWidget {
  final double height;
  final EdgeInsetsGeometry? padding;

  const SmartketLogo({
    super.key,
    this.height = 66,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      'assets/images/logo.png',
      height: height,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      alignment: Alignment.centerLeft,
      errorBuilder: (ctx, error, stack) => Text(
        'SMARTKET',
        style: GoogleFonts.lexendDeca(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
        ),
      ),
    );

    if (padding != null) {
      return Padding(padding: padding!, child: logo);
    }
    return logo;
  }
}
