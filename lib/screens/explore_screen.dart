import 'package:flutter/material.dart';
import '../components/app_top_bar.dart';
import '../theme/app_theme.dart';
import '../components/product_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'KHÁM PHÁ'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _Chip('Danh sách', true),
                        const SizedBox(width: 8),
                        _Chip('Bản đồ', false),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, size: 20, color: AppColors.textSecondary),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Tìm kiếm sản phẩm hoặc cửa hàng...',
                              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                            ),
                          ),
                          // filter icon removed per design
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categories
                          .map((c) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: AppShadows.light,
                                ),
                                child: Text(c, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text('Thực phẩm & đồ ăn', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    ProductCard(
                      title: 'Cơm Bento Trứng Cuộn',
                      store: 'Gia Lạc Minimart',
                      distance: '0.8 km',
                      price: '35.000 đ',
                      oldPrice: '50.000 đ',
                      discount: '-30%',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  const _Chip(this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? AppColors.primary : AppColors.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}

 

