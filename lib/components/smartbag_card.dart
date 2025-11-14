import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SmartbagCard extends StatelessWidget {
  final String tag;
  final String title;
  final String store;
  final String distance;
  final String price;
  final String oldPrice;
  final String discount;
  final String time;

  const SmartbagCard({
    super.key,
    required this.tag,
    required this.title,
    required this.store,
    required this.distance,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.light,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.lunch_dining, size: 36, color: Color(0xFFFFA726)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFE5F9EC), borderRadius: BorderRadius.circular(12)),
              child: Text(tag, style: const TextStyle(fontSize: 11, color: AppColors.primary)),
            ),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            Text('$store • $distance', style: const TextStyle(fontSize: 12, color: AppColors.primary)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.red)),
                    const SizedBox(width: 6),
                    Text(oldPrice, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, decoration: TextDecoration.lineThrough)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                  child: Text(discount, style: const TextStyle(fontSize: 10, color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

