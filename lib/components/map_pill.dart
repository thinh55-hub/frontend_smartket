import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Pill button that toggles between selected / unselected states per Figma spec.
class MapPill extends StatelessWidget {
  final bool selected;
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const MapPill({
    super.key,
    this.selected = false,
    this.label = 'Smartbag',
    this.icon = Icons.card_giftcard_outlined,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = selected ? const Color(0xFF008F7A) : Colors.white;
    final Color textColor = selected ? Colors.white : const Color(0xFF2C3A4B);
    final Color borderColor = selected ? Colors.transparent : const Color(0xFFE1E6F1);
    final BoxShadow shadow = selected
        ? const BoxShadow(color: Color(0x33008F7A), blurRadius: 20, offset: Offset(0, 10))
        : const BoxShadow(color: Color(0x12000000), blurRadius: 10, offset: Offset(0, 6));

    final pill = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [shadow],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 12),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lexendDeca(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return pill;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: pill,
    );
  }
}
