import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_smartket/theme/app_theme.dart';

class SmartbagChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const SmartbagChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final chip = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF00C853) : Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: selected ? const Color(0xFF00C853) : const Color(0xFFE0E4EE)),
        boxShadow: selected
            ? const [BoxShadow(color: Color(0x3300C853), blurRadius: 18, offset: Offset(0, 8))]
            : const [BoxShadow(color: Color(0x05000000), blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Text(
        label,
        style: GoogleFonts.lexendDeca(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );

    return GestureDetector(onTap: onTap, child: chip);
  }
}
