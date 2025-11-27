import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/models/product.dart';
import '../core/utils/formatting.dart';
import '../theme/app_theme.dart';

/// Shared product card used across home & explore tabs.
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final priceValue = product.price != null ? '${formatCurrency(product.price!)} ₫' : '-- ₫';
    final oldPrice = product.oldPrice != null ? '${formatCurrency(product.oldPrice!)} ₫' : null;
    final priceLabel = _cleanPrice(priceValue);
    final oldPriceLabel = oldPrice != null ? _cleanPrice(oldPrice) : null;
    final discount = _discountLabel();

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        height: 238.281,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, AppColors.promoCardBackground],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 96,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.promoCardBackground),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _buildProductImage(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.name,
                          style: GoogleFonts.lexendDeca(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textPrimary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.merchantName ?? 'GL Minimart',
                          style: GoogleFonts.lexendDeca(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              '0.8 km',
                              style: GoogleFonts.lexendDeca(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              priceLabel,
                              style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.salePrice),
                            ),
                            if (oldPriceLabel != null) ...[
                              const SizedBox(width: 6),
                              Text(
                                oldPriceLabel,
                                style: GoogleFonts.lexendDeca(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFB3BAC8),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (discount != null)
                    Positioned(
                      top: 0,
                      right: -4,
                      child: IgnorePointer(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.discountPink,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            discount,
                            style: GoogleFonts.lexendDeca(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.discountRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFF00A63E), width: 1.212),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    final imageUrl = product.imageUrl;
    const fallback = Center(child: Icon(Icons.ramen_dining, size: 40, color: Color(0xFFEF6C00)));
    if (imageUrl == null || imageUrl.isEmpty) {
      return fallback;
    }
    if (imageUrl.startsWith('http')) {
      return Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => fallback);
    }
    return Image.asset(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => fallback);
  }

  String? _discountLabel() {
    if (product.oldPrice != null && product.price != null && product.oldPrice! > 0) {
      final percent = (1 - (product.price! / product.oldPrice!)) * 100;
      final rounded = percent.round();
      if (rounded > 0) {
        return '-${rounded.abs()}%';
      }
    }
    if (product.discount != null && product.discount! > 0) {
      return '-${product.discount!.round()}%';
    }
    return null;
  }

  String _cleanPrice(String value) {
    return value.replaceAll('₫', 'đ').replaceAll(' ', '');
  }
}
