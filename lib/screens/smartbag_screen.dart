import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/segment_chip.dart';
import '../widgets/smartket_header_bar.dart';

class SmartbagScreen extends StatelessWidget {
  const SmartbagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: const SmartbagContent(),
      ),
    );
  }
}

class SmartbagContent extends StatelessWidget {
  const SmartbagContent({super.key});

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SmartketHeaderBar(),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFECEFF3)),
              boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 6, offset: Offset(0, 2))],
            ),
            child: Row(
              children: const [
                Icon(Icons.location_on_outlined, size: 18, color: Color(0xFF00C853)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Quận 1, TP.HCM • 5 km',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF3C404B)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: chips.map((c) {
                final selected = c == 'Túi bữa sáng';
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SegmentChip(c, selected),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
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
              SizedBox(width: 12),
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
      ],
    );
  }
}

class SmartbagCard extends StatelessWidget {
  final String tag;
  final String title;
  final String store;
  final String distance;
  final String price;
  final String oldPrice;
  final String discount;
  final String time;

  const SmartbagCard({
    super.key,
    required this.tag,
    required this.title,
    required this.store,
    required this.distance,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0E4EE)),
              boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 4))],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: const Color(0xFFF6F8FA),
                    child: const Icon(Icons.lunch_dining, size: 44, color: Color(0xFFFFA726)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFFCEB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.lexendDeca(
                            fontSize: 12,
                            color: const Color(0xFF00C853),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        title,
                        style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w800),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        store,
                        style: GoogleFonts.lexendDeca(fontSize: 12, color: const Color(0xFF00C853)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        distance,
                        style: GoogleFonts.lexendDeca(fontSize: 11, color: const Color(0xFF80848F)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFF00C853), borderRadius: BorderRadius.circular(8)),
              child: Text(
                price,
                style: GoogleFonts.lexendDeca(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
