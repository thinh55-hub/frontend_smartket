import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/models/product.dart';
import '../core/models/smartbag.dart';
import '../core/utils/formatting.dart';
import '../theme/app_theme.dart';
import 'product_card_mini.dart';
import 'smartbag_card.dart';
import 'smartbag_card_mini.dart';
import 'smartbag_card_mini.dart';

class StoreExploreCard extends StatelessWidget {
  final StoreExploreData store;
  final bool favorite;
  final VoidCallback? onFavorite;
  final EdgeInsetsGeometry? margin;

  const StoreExploreCard({
    super.key,
    required this.store,
    this.favorite = false,
    this.onFavorite,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeColor =
        store.isOpen ? AppColors.primary : AppColors.textSecondary;

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE7EBF4)),
        boxShadow: AppShadows.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F9F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.storefront_rounded,
                    color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: GoogleFonts.lexendDeca(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _InfoRow(
                          icon: Icons.star_rate_rounded,
                          iconColor: const Color(0xFFFFC107),
                          label:
                              '${store.rating.toStringAsFixed(1)} (${store.reviewCountLabel})',
                        ),
                        _InfoRow(
                          icon: Icons.directions_walk_outlined,
                          label: store.etaText,
                        ),
                        if (store.distanceText != null)
                          _InfoRow(
                            icon: Icons.location_on_outlined,
                            label: store.distanceText!,
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            color: AppColors.textSecondary, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          store.isOpen ? 'Mở cửa' : 'Đã đóng cửa',
                          style: GoogleFonts.lexendDeca(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: badgeColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '•',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          store.statusDetail,
                          style: GoogleFonts.lexendDeca(
                              fontSize: 14, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavorite,
                icon: Icon(
                  favorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: favorite ? AppColors.primary : const Color(0xFFBBC3D5),
                ),
                splashRadius: 24,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 210,
            child: Stack(
              children: [
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: store.featuredProducts.length +
                      (store.smartbag != null ? 1 : 0),
                  padding: const EdgeInsets.only(right: 34),
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final smartbag = store.smartbag;
                    final productCount = store.featuredProducts.length;
                    if (smartbag != null && index == productCount) {
                      return SmartbagCardMini(
                        title: smartbag.title,
                        time: smartbag.pickupTime,
                        price: _formatPrice(smartbag.price),
                        oldPrice: _formatPrice(smartbag.oldPrice),
                        image: smartbag.imageAsset,
                      );
                    }
                    final product = store.featuredProducts[index];
                    return ProductCardMini(product: product);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double value) => '${formatCurrency(value)} đ';

  String _discountLabel(Smartbag bag) {
    if (bag.oldPrice <= bag.price) return '-0%';
    final percent = (1 - (bag.price / bag.oldPrice)) * 100;
    return '-${percent.abs().round()}%';
  }
}

class StoreExploreData {
  final String id;
  final String name;
  final double rating;
  final String reviewCountLabel;
  final String etaText;
  final bool isOpen;
  final String statusDetail;
  final List<Product> featuredProducts;
  final String? distanceText;
  final Smartbag? smartbag;

  const StoreExploreData({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewCountLabel,
    required this.etaText,
    required this.isOpen,
    required this.statusDetail,
    required this.featuredProducts,
    this.distanceText,
    this.smartbag,
  });
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _InfoRow(
      {required this.icon,
      required this.label,
      this.iconColor = AppColors.textSecondary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.lexendDeca(
              fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _ScrollHint extends StatelessWidget {
  final bool visible;

  const _ScrollHint({required this.visible});

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    return Container(
      width: 28,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.transparent, Colors.white],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 20,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F8FC),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFDADFEA)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: index == 2 ? 0 : 4),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFBBC3D5),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
