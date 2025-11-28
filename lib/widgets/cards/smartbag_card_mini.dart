import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_smartket/theme/app_theme.dart';

class SmartbagCardMini extends StatelessWidget {
  final String title;
  final String time;
  final String price;
  final String? oldPrice;
  final String image;
  final VoidCallback? onTap;

  const SmartbagCardMini({
    super.key,
    required this.title,
    required this.time,
    required this.price,
    required this.image,
    this.oldPrice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6E9F2)),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: _buildImage(),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lexendDeca(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: GoogleFonts.lexendDeca(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: GoogleFonts.lexendDeca(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.salePrice,
                ),
              ),
              if (oldPrice != null) ...[
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    oldPrice!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: GoogleFonts.lexendDeca(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB6B8C4),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );

    if (onTap == null) return card;

    return GestureDetector(
      onTap: onTap,
      child: card,
    );
  }

  Widget _buildImage() {
    final placeholder = Container(
      height: 88,
      color: const Color(0xFFF5F5F8),
      alignment: Alignment.center,
      child: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
    );
    if (image.isEmpty) {
      return placeholder;
    }
    if (image.startsWith('http')) {
      return Image.network(
        image,
        height: 88,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => placeholder,
      );
    }
    return Image.asset(
      image,
      height: 88,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => placeholder,
    );
  }
}
