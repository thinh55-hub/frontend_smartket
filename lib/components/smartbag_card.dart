import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/models/smartbag.dart';
import '../screens/smartbag_detail_screen.dart';
import '../theme/app_theme.dart';
import 'smartbag_item.dart';

/// Compact Smartbag card used in horizontal carousels (Figma: "Smartbag - mini").
class SmartbagCard extends StatelessWidget {
  final String title;
  final String timeRange;
  final String price;
  final String? originalPrice;
  final String? imageUrl;
  final double width;
  final Smartbag? smartbag;
  final VoidCallback? onTap;

  const SmartbagCard({
    super.key,
    required this.title,
    required this.timeRange,
    required this.price,
    this.originalPrice,
    this.imageUrl,
    this.width = 176,
    this.smartbag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE4E7EF)),
        boxShadow: AppShadows.elevated,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SmartbagCardImage(imageUrl: imageUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexendDeca(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  timeRange,
                  style: GoogleFonts.lexendDeca(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.lexendDeca(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.salePrice,
                      ),
                    ),
                    if (originalPrice != null && originalPrice!.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(
                        originalPrice!,
                        style: GoogleFonts.lexendDeca(
                          fontSize: 13,
                          color: const Color(0xFFB1B8C6),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    VoidCallback? effectiveOnTap = onTap;

    // If no custom onTap is provided but we have a Smartbag,
    // navigate to the SmartbagDetailScreen with mapped data.
    if (effectiveOnTap == null && smartbag != null) {
      final deal = SmartbagItemData.fromSmartbag(smartbag!);
      effectiveOnTap = () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SmartbagDetailScreen(deal: deal),
          ),
        );
      };
    }

    if (effectiveOnTap == null) return card;

    return GestureDetector(
      onTap: effectiveOnTap,
      child: card,
    );
  }
}

class _SmartbagCardImage extends StatelessWidget {
  final String? imageUrl;

  const _SmartbagCardImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    final placeholder = Container(
      color: const Color(0xFFF4F6FA),
      child: const Icon(
        Icons.local_cafe,
        size: 40,
        color: Color(0xFFB7BDC9),
      ),
    );

    if (imageUrl == null || imageUrl!.isEmpty) {
      return placeholder;
    }

    if (imageUrl!.startsWith('http')) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => placeholder,
      );
    }

    return Image.asset(
      imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => placeholder,
    );
  }
}
