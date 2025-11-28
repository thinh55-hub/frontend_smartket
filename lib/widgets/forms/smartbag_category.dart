import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_smartket/theme/app_theme.dart';
import '../cards/smartbag_item.dart';

/// Displays a titled horizontal carousel of Smartbag items.
class SmartbagCategory extends StatelessWidget {
  final String title;
  final IconData? icon;
  final List<SmartbagItemData> deals;
  final double itemWidth;
  final ValueChanged<SmartbagItemData>? onItemTap;

  const SmartbagCategory({
    super.key,
    required this.title,
    this.icon,
    required this.deals,
    this.itemWidth = 300,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    if (deals.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: Colors.amber.shade600),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 320,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: deals.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final deal = deals[index];
              return SmartbagItemCard(
                width: itemWidth,
                title: deal.title,
                merchant: deal.merchant,
                distance: deal.distance,
                pickupWindow: deal.pickupWindow,
                price: deal.price,
                originalPrice: deal.originalPrice,
                imageUrl: deal.imageUrl,
                isFavorite: deal.isFavorite,
                onTap: onItemTap != null ? () => onItemTap!(deal) : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
