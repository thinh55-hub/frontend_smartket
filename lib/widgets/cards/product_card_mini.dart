import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_smartket/core/models/product.dart';
import 'package:frontend_smartket/core/utils/formatting.dart';
import 'package:frontend_smartket/theme/app_theme.dart';

/// Compact product tile that mirrors the "Product - mini" Figma spec.
class ProductCardMini extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCardMini({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final priceLabel = _formatPrice(product.price);
    final oldPriceLabel = _formatPrice(product.oldPrice);
    final discount = _discountLabel();

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEEF1F7)),
                boxShadow: AppShadows.light,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MiniImage(product: product),
                  const SizedBox(height: 10),
                  Text(
                    product.name,
                    style: GoogleFonts.lexendDeca(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        priceLabel ?? '-- đ',
                        style: GoogleFonts.lexendDeca(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.salePrice,
                        ),
                      ),
                      if (oldPriceLabel != null) ...[
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            oldPriceLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: GoogleFonts.lexendDeca(
                              fontSize: 13,
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
            ),
            if (discount != null)
              Positioned(
                top: -6,
                right: -2,
                child: _DiscountBadge(label: discount),
              ),
          ],
        ),
      ),
    );
  }

  String? _formatPrice(double? value) {
    if (value == null) return null;
    return '${formatCurrency(value)}đ';
  }

  String? _discountLabel() {
    if (product.oldPrice != null &&
        product.price != null &&
        product.oldPrice! > 0) {
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
}

class _MiniImage extends StatelessWidget {
  final Product product;

  const _MiniImage({required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.imageUrl;
    final placeholder = Center(
      child: Icon(Icons.inventory_2_outlined,
          color: AppColors.primary.withOpacity(0.6)),
    );

    Widget image;
    if (imageUrl == null || imageUrl.isEmpty) {
      image = placeholder;
    } else if (imageUrl.startsWith('http')) {
      image = Image.network(imageUrl,
          fit: BoxFit.cover, errorBuilder: (_, __, ___) => placeholder);
    } else {
      image = Image.asset(imageUrl,
          fit: BoxFit.cover, errorBuilder: (_, __, ___) => placeholder);
    }

    return AspectRatio(
      aspectRatio: 125 / 86,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9FB),
          borderRadius: BorderRadius.circular(18),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: image,
        ),
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final String label;

  const _DiscountBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF0F0),
            Color(0xFFFFC7C7),
          ],
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.lexendDeca(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.discountRed,
        ),
      ),
    );
  }
}
