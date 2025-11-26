import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../components/product_card.dart';

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
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: _exploreProducts.length,
                  itemBuilder: (context, index) {
                    final item = _exploreProducts[index];
                    return ProductCard(
                      title: item.title,
                      store: item.store,
                      distance: item.distance,
                      price: item.price,
                      oldPrice: item.oldPrice,
                      discount: item.discount,
                      leadingIcon: item.icon,
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

class _ExploreProduct {
  final String title;
  final String store;
  final String distance;
  final String price;
  final String oldPrice;
  final String discount;
  final IconData icon;

  const _ExploreProduct({
    required this.title,
    required this.store,
    required this.distance,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.icon,
  });
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

const List<_ExploreProduct> _exploreProducts = [
  _ExploreProduct(
    title: 'Cơm Bento Trứng Cuộn',
    store: 'Gia Lạc Minimart',
    distance: '0.8 km',
    price: '35.000 đ',
    oldPrice: '50.000 đ',
    discount: '-30%',
    icon: Icons.rice_bowl,
  ),
  _ExploreProduct(
    title: 'Combo Ngũ Quả',
    store: 'Happy Vegan',
    distance: '1.2 km',
    price: '49.000 đ',
    oldPrice: '70.000 đ',
    discount: '-25%',
    icon: Icons.eco,
  ),
  _ExploreProduct(
    title: 'Smoothie Mix Pack',
    store: 'Freshie Bar',
    distance: '0.5 km',
    price: '45.000 đ',
    oldPrice: '60.000 đ',
    discount: '-20%',
    icon: Icons.blender,
  ),
  _ExploreProduct(
    title: 'Set Ngũ Cốc Healthy',
    store: 'Nutri Corner',
    distance: '2.1 km',
    price: '55.000 đ',
    oldPrice: '80.000 đ',
    discount: '-30%',
    icon: Icons.breakfast_dining,
  ),
];

 
