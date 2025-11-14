import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String store;
  final String distance;
  final String price;
  final String oldPrice;
  final String discount;
  final IconData leadingIcon;

  const ProductCard({
    super.key,
    required this.title,
    required this.store,
    required this.distance,
    required this.price,
    required this.oldPrice,
    required this.discount,
    this.leadingIcon = Icons.ramen_dining,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(leadingIcon, size: 36, color: const Color(0xFFEF6C00)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text('$store • $distance', style: const TextStyle(fontSize: 12, color: AppColors.primary)),
          const Spacer(),
          Row(
            children: [
              Text(price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.red)),
              const SizedBox(width: 6),
              Text(oldPrice, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, decoration: TextDecoration.lineThrough)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                child: Text(discount, style: const TextStyle(fontSize: 10, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

