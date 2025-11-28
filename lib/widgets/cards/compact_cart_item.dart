import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:frontend_smartket/core/utils/formatting.dart';
import 'package:frontend_smartket/theme/app_theme.dart';

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
                Text(title, style: GoogleFonts.lexendDeca(fontSize: 17, fontWeight: FontWeight.w400)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('${formatCurrency(price)} đ', style: GoogleFonts.lexendDeca(fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.primary)),
                    const Spacer(),
                    _QuantityButton(icon: Icons.remove, filled: false, onTap: onDecrease),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('$quantity', style: GoogleFonts.lexendDeca(fontSize: 17, fontWeight: FontWeight.w400)),
                    ),
                    _QuantityButton(icon: Icons.add, filled: true, onTap: onIncrease),
                    const Spacer(),
                    IconButton(
                      onPressed: onRemove,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      splashRadius: 20,
                      icon: SvgPicture.string(
                        _trashIconSvg,
                        width: 18,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _trashIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="21" height="23" viewBox="0 0 21 23" fill="none">
  <path d="M1.25 5.25H3.25M3.25 5.25H19.25M3.25 5.25V19.25C3.25 19.7804 3.46071 20.2891 3.83579 20.6642C4.21086 21.0393 4.71957 21.25 5.25 21.25H15.25C15.7804 21.25 16.2891 21.0393 16.6642 20.6642C17.0393 20.2891 17.25 19.7804 17.25 19.25V5.25M6.25 5.25V3.25C6.25 2.71957 6.46071 2.21086 6.83579 1.83579C7.21086 1.46071 7.71957 1.25 8.25 1.25H12.25C12.7804 1.25 13.2891 1.46071 13.6642 1.83579C14.0393 2.21086 14.25 2.71957 14.25 3.25V5.25" stroke="#E7000B" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback? onTap;

  const _QuantityButton({
    required this.icon,
    required this.filled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      splashColor: AppColors.primary.withOpacity(0.1),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: filled ? AppColors.primary : const Color(0xFFE0E4EE),
          ),
          boxShadow: filled
              ? const [
                  BoxShadow(
                    color: Color(0x2200A63E),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 11,
          color: filled ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }
}
