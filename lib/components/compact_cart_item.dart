import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

/// Compact cart item row that matches the Figma snapshot with image,
/// name, price, quantity stepper, and delete icon.
class CompactCartItem extends StatelessWidget {
  final String title;
  final double price;
  final int quantity;
  final String? imageAsset;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onRemove;

  const CompactCartItem({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
    this.imageAsset,
    this.onIncrease,
    this.onDecrease,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E4EE)),
        boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 56,
              height: 56,
              color: const Color(0xFFF6F8FA),
              child: imageAsset != null
                  ? Image.asset(
                      imageAsset!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.fastfood_outlined, color: AppColors.primary),
                    )
                  : const Icon(Icons.fastfood_outlined, color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: GoogleFonts.lexendDeca(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('${price.toInt()} đ', style: GoogleFonts.lexendDeca(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
              ],
            ),
          ),
          _QuantityButton(icon: Icons.remove, filled: false, onTap: onDecrease),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('$quantity', style: GoogleFonts.lexendDeca(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
          _QuantityButton(icon: Icons.add, filled: true, onTap: onIncrease),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onRemove,
            splashRadius: 20,
            icon: const Icon(Icons.delete_outline, color: Color(0xFFE53935)),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback? onTap;

  const _QuantityButton({required this.icon, required this.filled, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? AppColors.primary : Colors.white,
          border: filled ? null : Border.all(color: const Color(0xFFD8DEE6)),
          boxShadow: filled ? const [BoxShadow(color: Color(0x3300C853), blurRadius: 8, offset: Offset(0, 4))] : null,
        ),
        child: Icon(
          icon,
          size: 18,
          color: filled ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}
