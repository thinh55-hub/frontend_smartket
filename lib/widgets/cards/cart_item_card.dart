import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_smartket/theme/app_theme.dart';

class CartItemCard extends StatelessWidget {
  final String title;
  final String store;
  final double price;
  final double? oldPrice;
  final int quantity;
  final String? imageAsset;
  final VoidCallback? onRemove;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const CartItemCard({
    super.key,
    required this.title,
    required this.store,
    required this.price,
    this.oldPrice,
    required this.quantity,
    this.imageAsset,
    this.onRemove,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E4EE)),
        boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 72,
              height: 72,
              color: const Color(0xFFF6F8FA),
              child: imageAsset != null
                  ? Image.asset(
                      imageAsset!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.local_mall_outlined, size: 30, color: AppColors.primary),
                    )
                  : const Icon(Icons.local_mall_outlined, size: 30, color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.lexendDeca(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
                      splashRadius: 18,
                      onPressed: onRemove,
                    ),
                  ],
                ),
                Text(store, style: GoogleFonts.lexendDeca(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${price.toInt()} đ',
                      style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary),
                    ),
                    if (oldPrice != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        '${oldPrice!.toInt()} đ',
                        style: GoogleFonts.lexendDeca(fontSize: 12, color: const Color(0xFFB3BAC8), decoration: TextDecoration.lineThrough),
                      ),
                    ],
                    const Spacer(),
                    _QuantityStepper(
                      quantity: quantity,
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
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

class _QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const _QuantityStepper({required this.quantity, this.onIncrement, this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE0E4EE)),
      ),
      child: Row(
        children: [
          IconButton(onPressed: onDecrement, icon: const Icon(Icons.remove, size: 18)),
          Text('$quantity', style: GoogleFonts.lexendDeca(fontSize: 14)),
          IconButton(onPressed: onIncrement, icon: const Icon(Icons.add, size: 18)),
        ],
      ),
    );
  }
}
