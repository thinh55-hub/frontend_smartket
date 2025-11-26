import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/product_card.dart';
import '../components/search_pill.dart';
import '../components/smartbag_chip_list.dart';
import '../core/models/product.dart';
import '../core/state/product_provider.dart';
import '../theme/app_theme.dart';

class ExploreContent extends StatelessWidget {
  const ExploreContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _ExploreModeChip(label: 'Danh sách', selected: true),
                SizedBox(width: 8),
                _ExploreModeChip(label: 'Bản đồ', selected: false),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SearchPill(placeholder: 'Tìm kiếm sản phẩm hoặc cửa hàng...'),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartbagChipList(
                  labels: _exploreCategories,
                  selectedIndex: 0,
                  onSelected: (_) {},
                ),
                Consumer<ProductProvider>(
                  builder: (context, provider, _) {
                    final products = provider.products.isNotEmpty ? provider.products : _fallbackProducts;
                    if (products.isEmpty) {
                      return const Center(child: Text('Chưa có sản phẩm'));
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 160 / 238.281,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(product: product, onTap: () {});
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ExploreModeChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _ExploreModeChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        boxShadow: selected ? AppShadows.light : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.lexendDeca(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: selected ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}

const List<String> _exploreCategories = [
  '🍱 Thực phẩm & đồ ăn',
  '🥤 Đồ uống',
  '🍪 Snack – Bánh kẹo – Đồ ăn vặt',
  '🥛 Sữa & sản phẩm từ sữa',
  '🍜 Mì gói – đồ khô – Gia vị',
  '🥬 Trái cây – Rau củ',
  '🥖 Bánh mì – Bánh ngọt',
  '🥩 Thịt – Hải sản',
  '🍲 Đồ khô – Gia vị – Mì gói',
  '🌱 Thực phẩm chay / hữu cơ',
  '🥫 Đồ hộp / Thực phẩm chế biến sẵn',
  '🧂 Gia vị – Dầu ăn – Nước mắm',
  '📦 Khác',
];

final List<Product> _fallbackProducts = [
  Product(
    id: 'exp-1',
    name: 'Cơm Bento Trứng Cuộn',
    merchantName: 'Gia Lạc Minimart',
    price: 35000.0,
    oldPrice: 50000.0,
    discount: 30,
  ),
  Product(
    id: 'exp-2',
    name: 'Combo Ngũ Quả',
    merchantName: 'Happy Vegan',
    price: 49000.0,
    oldPrice: 70000.0,
    discount: 25,
  ),
  Product(
    id: 'exp-3',
    name: 'Smoothie Mix Pack',
    merchantName: 'Freshie Bar',
    price: 45000.0,
    oldPrice: 60000.0,
    discount: 20,
  ),
  Product(
    id: 'exp-4',
    name: 'Set Ngũ Cốc Healthy',
    merchantName: 'Nutri Corner',
    price: 55000.0,
    oldPrice: 80000.0,
    discount: 30,
  ),
];
