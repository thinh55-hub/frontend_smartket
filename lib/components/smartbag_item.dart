import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/models/smartbag.dart';
import '../core/utils/formatting.dart';
import '../theme/app_theme.dart';

/// Smartbag list item card with hero image + metadata (Figma: "Smartbag item").
class SmartbagItemCard extends StatelessWidget {
  final String title;
  final String merchant;
  final String distance;
  final String pickupWindow;
  final String price;
  final String? originalPrice;
  final String? imageUrl;
  final bool isFavorite;
  final double? width;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onAddTap;

  const SmartbagItemCard({
    super.key,
    required this.title,
    required this.merchant,
    required this.distance,
    required this.pickupWindow,
    required this.price,
    this.originalPrice,
    this.imageUrl,
    this.isFavorite = false,
    this.width,
    this.onTap,
    this.onFavoriteTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE3E8F1)),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 18, offset: Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SmartbagItemImage(
            imageUrl: imageUrl,
            isFavorite: isFavorite,
            onFavoriteTap: onFavoriteTap,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        merchant,
                        style: GoogleFonts.lexendDeca(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      distance,
                      style: GoogleFonts.lexendDeca(fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  pickupWindow,
                  style: GoogleFonts.lexendDeca(fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          price,
                          style: GoogleFonts.lexendDeca(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.salePrice),
                        ),
                        if (originalPrice != null)
                          Text(
                            originalPrice!,
                            style: GoogleFonts.lexendDeca(
                              fontSize: 13,
                              color: const Color(0xFFB1B8C6),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    _AddButton(onPressed: onAddTap),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget card = content;
    if (width != null) {
      card = SizedBox(width: width, child: content);
    }

    if (onTap != null) {
      card = GestureDetector(onTap: onTap, child: card);
    }

    return card;
  }
}

class _SmartbagItemImage extends StatelessWidget {
  final String? imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const _SmartbagItemImage({this.imageUrl, required this.isFavorite, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _buildImage(),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: onFavoriteTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(color: Color(0x33000000), blurRadius: 6, offset: Offset(0, 3)),
                  ],
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.salePrice : AppColors.primary,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    const placeholder = ColoredBox(
      color: Color(0xFFF4F6FA),
      child: Center(child: Icon(Icons.fastfood, color: Color(0xFFB7BDC9), size: 40)),
    );

    if (imageUrl == null || imageUrl!.isEmpty) {
      return placeholder;
    }

    if (imageUrl!.startsWith('http')) {
      return Image.network(imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => placeholder);
    }

    return Image.asset(imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => placeholder);
  }
}

class SmartbagItemData {
  final String id;
  final String title;
  final String merchant;
  final String distance;
  final String pickupWindow;
  final String price;
  final String? originalPrice;
  final String imageUrl;
  final bool isFavorite;
  final String? description;
  final int? stock;

  const SmartbagItemData({
    required this.id,
    required this.title,
    required this.merchant,
    required this.distance,
    required this.pickupWindow,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.isFavorite = false,
    this.description,
    this.stock,
  });

  factory SmartbagItemData.fromSmartbag(Smartbag bag) {
    return SmartbagItemData(
      id: bag.id,
      title: bag.title,
      merchant: bag.storeName,
      distance: '• ${bag.distance}',
      pickupWindow: 'Lấy vào ${bag.pickupTime}',
      price: '${formatCurrency(bag.price)} đ',
      originalPrice: '${formatCurrency(bag.oldPrice)} đ',
      imageUrl: bag.imageAsset,
      isFavorite: false,
      description: bag.description ?? bag.tag,
      stock: bag.stock,
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _AddButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFFFC940),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x26000000), blurRadius: 8, offset: Offset(0, 4))],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
    );
  }
}
