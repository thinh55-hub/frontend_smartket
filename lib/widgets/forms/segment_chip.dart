import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

/// Pill-style toggle chip used across Home tabs (e.g., QR and Smartbag sections).
class SegmentChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool inverted;

  const SegmentChip(this.label, this.selected, {super.key, this.inverted = false});

  @override
  Widget build(BuildContext context) {
    if (inverted) {
      final borderRadius = BorderRadius.circular(39);
      Widget chip = AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: 320,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: selected
              ? const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF00A63E), Color(0xFF00C950)],
                )
              : null,
          color: selected ? null : Colors.transparent,
          boxShadow: selected
              ? const [BoxShadow(color: Color(0x4D00C950), blurRadius: 12, offset: Offset(0, 4))]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.lexendDeca(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : AppColors.primary,
            ),
          ),
        ),
      );

      if (selected) {
        chip = ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: chip,
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: chip,
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: selected ? null : Border.all(color: const Color(0xFFE8EBF2)),
        boxShadow: selected
            ? const [BoxShadow(color: Color(0x12000000), blurRadius: 8, offset: Offset(0, 4))]
            : const [BoxShadow(color: Color(0x05000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.lexendDeca(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
