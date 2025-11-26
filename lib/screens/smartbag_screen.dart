import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/smartbag_card.dart';
import '../widgets/smartket_header_bar.dart';

class SmartbagScreen extends StatelessWidget {
  const SmartbagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chips = [
      'Túi bữa sáng',
      'Túi bữa trưa',
      'Túi bữa tối',
      'Túi đồ ăn nhanh',
      'Túi đồ uống mix',
      'Túi bánh & snack',
      'Túi nguyên liệu tươi',
      'Túi Eat Clean / Hữu cơ',
      'Túi combo hỗn hợp',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SmartketHeaderBar(),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Smartbag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.location_on_outlined, size: 18, color: AppColors.primary),
                    SizedBox(width: 8),
                    Expanded(child: Text('Quận 1, TP.HCM • 5 km', style: TextStyle(fontSize: 13, color: AppColors.textPrimary))),
                    Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textPrimary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  final selected = i == 0;
                  return _Chip(chips[i], selected);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: chips.length,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.78,
                  children: const [
                    SmartbagCard(
                      tag: 'Túi bữa sáng',
                      title: 'Breakfast Bag – Bakery & Coffee',
                      store: 'Gia Lạc Minimart',
                      distance: '0.8 km',
                      price: '45.000 đ',
                      oldPrice: '90.000 đ',
                      discount: '-50%',
                      time: '07:00–09:00',
                    ),
                    SmartbagCard(
                      tag: 'Túi bữa tối',
                      title: 'Dinner Bag',
                      store: 'Gia Lạc Minimart',
                      distance: '0.8 km',
                      price: '50.000 đ',
                      oldPrice: '100.000 đ',
                      discount: '-50%',
                      time: '18:00–20:00',
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

