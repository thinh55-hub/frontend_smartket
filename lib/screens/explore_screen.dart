import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../components/product_card.dart';
import '../core/models/product.dart';
import '../core/state/product_provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: const ExploreContent(),
      ),
    );
  }
}

class ExploreContent extends StatelessWidget {
  const ExploreContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'KHÁM PHÁ',
                style: GoogleFonts.lexendDeca(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: AppColors.primary),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: AppColors.primary),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              _ExploreModeChip(label: 'Danh sách', selected: true),
              SizedBox(width: 8),
              _ExploreModeChip(label: 'Bản đồ', selected: false),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.border),
              boxShadow: AppShadows.light,
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: AppColors.textSecondary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tìm kiếm sản phẩm hoặc cửa hàng...',
                    style: GoogleFonts.lexendDeca(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _exploreCategories
                      .map((c) => _ExploreCategoryChip(label: c))
                      .toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  'Thực phẩm & đồ ăn',
                  style: GoogleFonts.lexendDeca(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 12),
                Consumer<ProductProvider>(
                  builder: (context, provider, _) {
                    final data = provider.products.isNotEmpty ? provider.products : _fallbackProducts;
                    if (data.isEmpty) {
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
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final product = data[index];
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        boxShadow: selected ? AppShadows.light : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.lexendDeca(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _ExploreCategoryChip extends StatelessWidget {
  final String label;

  const _ExploreCategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.light,
      ),
      child: Text(
        label,
        style: GoogleFonts.lexendDeca(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      ),
    );
  }
}

const List<String> _exploreCategories = [
  'Thực phẩm & đồ ăn',
  'Đồ uống',
  'Bánh ngọt / Bánh mì',
  'Trái cây – Rau củ',
  'Thịt – Hải sản',
  'Sữa & sản phẩm từ sữa',
  'Đồ khô – Gia vị – Mì gói',
  'Thực phẩm chay / hữu cơ',
  'Snack – Bánh kẹo – Đồ ăn vặt',
  'Đồ hộp / Thực phẩm chế biến sẵn',
  'Gia vị – Dầu ăn – Nước mắm',
  'Khác',
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

 
