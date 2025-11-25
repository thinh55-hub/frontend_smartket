import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../core/models/product.dart';
import '../data/mock_products.dart';
import '../widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import '../core/state/navigation_provider.dart';
// home_screen import removed; navigation uses NavigationProvider now

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _IncreaseItem extends StatelessWidget {
  final VoidCallback onPressed;

  const _IncreaseItem({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // CSS: width/height 1.86627rem (~29.86px), border-radius 1.06667rem (~17.07px), background #00C950
    const double size = 1.86627 * 16; // ~29.86
    const double radius = 1.06667 * 16; // ~17.07

    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: const Color(0xFF00C950),
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(radius),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 0;
  

  @override
  Widget build(BuildContext context) {
    final price = widget.product.price ?? 0.0;
    final oldPrice = widget.product.oldPrice ?? 0.0;
    final discount = (oldPrice > 0 && price > 0)
        ? '-${(((oldPrice - price) / oldPrice) * 100).round()}%'
        : null;

    final extended = mockProductExtended[widget.product.id];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image header
                    Container(
                      height: 340,
                      padding: const EdgeInsets.only(top: 8),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Center(
                        child: widget.product.imageUrl != null
                            ? Image.asset(
                                widget.product.imageUrl!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.contain,
                                errorBuilder: (c, e, st) => const Icon(
                                  Icons.ramen_dining,
                                  size: 120,
                                  color: Color(0xFFCCCCCC),
                                ),
                              )
                            : const Icon(
                                Icons.ramen_dining,
                                size: 120,
                                color: Color(0xFFCCCCCC),
                              ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE6EAF0)),
                          boxShadow: [
                                BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.03), blurRadius: 12, offset: const Offset(0, 6)),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              style: GoogleFonts.lexendDeca(
                                color: const Color(0xCC292929),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 1.73333,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.storefront, size: 18, color: AppColors.primary),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.product.merchantName ?? 'Cửa hàng',
                                    style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: AppColors.primary, size: 20),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (oldPrice > 0) ...[
                                  Text(
                                    _formatCurrency(oldPrice),
                                    style: const TextStyle(fontSize: 16, color: Color(0xFFBDBDBD), decoration: TextDecoration.lineThrough),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Text(
                                  _formatCurrency(price),
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primary),
                                ),
                                const SizedBox(width: 12),
                                if (discount != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(color: const Color(0xFFFFF1F2), borderRadius: BorderRadius.circular(999)),
                                    child: Text(discount, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFE23838))),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                                'Còn lại: ${widget.product.stock ?? '—'}',
                                style: GoogleFonts.lexendDeca(
                                color: const Color(0xCC292929),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.73333,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              // Use product description if present; otherwise fall back to the provided copy.
                              widget.product.description ?? 'Mì Hảo Hảo Tôm Chua Cay là món ăn nhanh được yêu thích với hương vị đậm đà, chua cay hấp dẫn. Thích hợp cho bữa ăn nhẹ hoặc bữa ăn chính. Sản phẩm còn hạn sử dụng tốt, đang trong chương trình giảm giá đặc biệt.',
                              style: GoogleFonts.lexendDeca(
                                color: const Color(0xCC292929),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                height: 1.73333,
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (extended != null) ...[
                              _InfoBlock(title: 'Xuất xứ', value: extended['origin']),
                              _InfoBlock(title: 'Thành phần / Dinh dưỡng', value: extended['nutrition']),
                              _InfoBlock(title: 'Bảo quản', value: extended['storage']),
                              _InfoBlock(title: 'Hướng dẫn sử dụng', value: extended['usage']),
                            ],
                          ],
                        ),
                      ),
                    ),

                    // Related products title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Text(
                        'Thêm từ cửa hàng này',
                        style: GoogleFonts.lexendDeca(
                          color: const Color(0xFF292929),
                          fontSize: 2, // 1.2rem (1rem = 16px)
                          fontWeight: FontWeight.w400,
                          height: 1.5, // 1.8rem line-height -> 1.5 relative to 1.2rem (150%)
                        ),
                      ),
                    ),

                    // Green strip with related cards (gradient)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(0, 166, 62, 0.70), // rgba(0,166,62,0.70)
                            Color.fromRGBO(0, 166, 62, 0.00), // rgba(0,166,62,0.00)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: const [
                            _RelatedProductCard(emoji: '🍱', name: 'Cơm Bento Trứng Cuộn', price: '35.000 đ', oldPrice: '35.000 đ'),
                            SizedBox(width: 12),
                            _RelatedProductCard(emoji: '🧃', name: 'Nước cam ép tươi', price: '20.000 đ', oldPrice: '20.000 đ'),
                            SizedBox(width: 12),
                            _RelatedProductCard(emoji: '☕', name: 'Cà phê sữa đá', price: '18.000 đ'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Permanent back button overlay (always visible)
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                          BoxShadow(color: const Color.fromRGBO(39, 174, 96, 0.18), blurRadius: 8, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add-to-cart bar (placed above the BottomNav)
              Center(
              child: SizedBox(
                width: 28.86667 * 16, // 28.86667rem -> px (1rem = 16px)
                child: Container(
                  height: 4 * 16, // increased total height (3.8rem) for more vertical space
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: const Border(top: BorderSide(color: Color(0xFFE5E7EB), width: 1.18)),
                    boxShadow: [
                          BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 16, offset: const Offset(0, -4)),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    // Group: decrease / quantity / increase inside a pale pill container
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0.25 * 16, horizontal: 0.3 * 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(2.66667 * 16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // decrease
                          SizedBox(
                            width: 1.86627 * 16,
                            height: 1.86627 * 16,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1.33333 * 16),
                                border: Border.all(color: const Color(0xFFD1D5DC), width: 1.18),
                                boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 6, offset: const Offset(0, 2))],
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.remove, size: 16),
                                color: AppColors.textPrimary,
                                onPressed: () {
                                  if (quantity > 0) setState(() => quantity--);
                                },
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 0.53333 * 16),
                          // quantity
                          SizedBox(
                            width: 1.93333 * 16,
                            height: 1.8 * 16,
                            child: Center(
                              child: Text(
                                quantity.toString(),
                                style: GoogleFonts.lexendDeca(
                                  color: const Color.fromRGBO(41, 41, 41, 0.90),
                                  fontSize: 1.33333 * 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2, // 1.6rem / 1.33333rem = 1.2
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 0.53333 * 16),
                          // increase (use reusable widget)
                          _IncreaseItem(onPressed: () => setState(() => quantity++)),
                        ],
                      ),
                    ),
                    SizedBox(width: 1.2 * 16), // gap: 1.2rem (tighter)
                    SizedBox(
                      width: 13.75 * 16, // fixed wider pill (~13.75rem) to avoid wrapping and keep proportions
                      child: Container(
                        height: 2.8 * 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00C950), Color(0xFF27AE60)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.18), blurRadius: 24, offset: const Offset(0, 6))],
                        ),
                        child: ElevatedButton(
                          onPressed: quantity > 0
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã thêm $quantity ${widget.product.name} vào giỏ hàng'), backgroundColor: AppColors.primary, duration: const Duration(seconds: 2)));
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(double.infinity),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            'Thêm vào giỏ hàng',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lexendDeca(
                              color: Colors.white,
                              fontSize: 1.4 * 16,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            // Primary navigation row at the very bottom
            SafeArea(
              top: false,
              child: BottomNav(
                current: context.watch<NavigationProvider>().current,
                onChanged: (tab) {
                  context.read<NavigationProvider>().current = tab;
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double v) {
    final int amount = v.toInt();
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return '${buffer.toString()} đ';
  }
}



class _InfoBlock extends StatelessWidget {
  final String title;
  final String? value;
  const _InfoBlock({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: GoogleFonts.lexendDeca(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value!,
          style: GoogleFonts.lexendDeca(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ]),
    );
  }
}

class _RelatedProductCard extends StatelessWidget {
  final String emoji;
  final String name;
  final String price;
  final String? oldPrice;

  const _RelatedProductCard({required this.emoji, required this.name, this.price = '35.000 đ', this.oldPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7EAF0), width: 1),
        boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(height: 80, alignment: Alignment.center, child: Text(emoji, style: const TextStyle(fontSize: 56)))),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF0A0A0A), // #0A0A0A
              fontFamily: 'Arial',
              fontSize: 17.0667, // 1.06667rem -> ~17.0667px
              fontWeight: FontWeight.w400,
              height: 1.5, // 1.6rem line-height -> relative height approx 1.5 (150%)
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(children: [
            Text(price, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF4CAF50))),
            if (oldPrice != null) ...[
              const SizedBox(width: 6),
              Text(oldPrice!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFFBBBBBB), decoration: TextDecoration.lineThrough, decorationColor: Color(0xFFBBBBBB))),
            ]
          ])
        ]),
      ),
    );
  }
}
