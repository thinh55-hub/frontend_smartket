import 'package:flutter/material.dart';
import '../components/smartbag_category.dart';
import '../components/smartbag_item.dart';
import '../components/map_tab.dart';
import 'smartbag_detail_screen.dart';
import '../components/location_pill.dart';
import '../theme/app_theme.dart';
import '../widgets/segment_chip.dart';
import '../widgets/smartket_header_bar.dart';

class SmartbagScreen extends StatelessWidget {
  const SmartbagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SmartbagContent(),
      ),
    );
  }
}

class SmartbagContent extends StatelessWidget {
  const SmartbagContent({super.key});

  void _openSmartbagDetail(BuildContext context, SmartbagItemData deal) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SmartbagDetailScreen(deal: deal)));
  }

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

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SmartketHeaderBar(logoHeight: 52),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: LocationPill(),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: MapTab(items: _mapTabItems),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          SmartbagCategory(
            title: 'Mới nhất',
            icon: Icons.star_rounded,
            deals: _smartbagNewestDeals,
            onItemTap: (deal) => _openSmartbagDetail(context, deal),
          ),
          const SizedBox(height: 24),
          SmartbagCategory(
            title: 'Túi bữa sáng',
            icon: Icons.free_breakfast,
            deals: _smartbagItemDeals,
            onItemTap: (deal) => _openSmartbagDetail(context, deal),
          ),
          const SizedBox(height: 24),
          SmartbagCategory(
            title: 'Túi bữa trưa',
            icon: Icons.lunch_dining,
            deals: _smartbagMiniDeals,
            onItemTap: (deal) => _openSmartbagDetail(context, deal),
          ),
        ],
      ),
    );
  }
}

const List<SmartbagItemData> _smartbagMiniDeals = [
  SmartbagItemData(
    id: 'mini-1',
    title: 'Bánh ngọt & cà phê',
    merchant: 'GL Minimart',
    distance: '0.8 km',
    pickupWindow: '8:00 - 11:30 hôm nay',
    price: '27.000 đ',
    originalPrice: '37.000 đ',
    imageUrl: 'https://images.unsplash.com/photo-1493770348161-369560ae357d?auto=format&fit=crop&w=640&q=80',
    description: 'Combo bánh ngọt và cà phê nóng, hoàn hảo cho buổi sáng nhiều năng lượng.',
  ),
  SmartbagItemData(
    id: 'mini-2',
    title: 'Brunch & Salad',
    merchant: 'Gia Lạc Minimart',
    distance: '1.1 km',
    pickupWindow: '9:30 - 12:00 hôm nay',
    price: '39.000 đ',
    originalPrice: '65.000 đ',
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=640&q=80',
    description: 'Túi brunch với salad tươi và bánh mì sandwich.',
  ),
  SmartbagItemData(
    id: 'mini-3',
    title: 'Combo Healthy Smoothie',
    merchant: 'DT Minimart',
    distance: '0.6 km',
    pickupWindow: '14:00 - 16:30 hôm nay',
    price: '32.000 đ',
    originalPrice: '58.000 đ',
    imageUrl: 'https://images.unsplash.com/photo-1481391032119-d89fee407e44?auto=format&fit=crop&w=640&q=80',
    description: 'Sinh tố healthy kèm snack hạt khô dinh dưỡng.',
  ),
];

const List<SmartbagItemData> _smartbagItemDeals = [
  SmartbagItemData(
    id: 'item-1',
    title: 'Bánh ngọt & cà phê',
    merchant: 'GL Minimart',
    distance: '• 0.8 km',
    pickupWindow: 'Lấy vào 8:00 - 11:30 hôm nay',
    price: '27.000 đ',
    originalPrice: '37.000 đ',
    imageUrl: 'https://images.unsplash.com/photo-1493770348161-369560ae357d?auto=format&fit=crop&w=640&q=80',
    isFavorite: true,
    description: 'Set bánh ngọt handmade kèm ly cà phê nóng.',
  ),
  SmartbagItemData(
    id: 'item-2',
    title: 'Brunch & Salad',
    merchant: 'Gia Lạc Minimart',
    distance: '• 1.1 km',
    pickupWindow: 'Lấy vào 9:00 - 11:00 hôm nay',
    price: '35.000 đ',
    originalPrice: '55.000 đ',
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=640&q=80',
    description: 'Brunch đủ đầy với salad rau củ và sandwich.',
  ),
];

const List<SmartbagItemData> _smartbagNewestDeals = [
  SmartbagItemData(
    id: 'new-1',
    title: 'Bánh ngọt & cà phê',
    merchant: 'GL Minimart',
    distance: '• 0.8 km',
    pickupWindow: 'Lấy vào 8:00 - 11:30 hôm nay',
    price: '27.000 đ',
    originalPrice: '37.000 đ',
    imageUrl: 'https://images.unsplash.com/photo-1493770348161-369560ae357d?auto=format&fit=crop&w=640&q=80',
    isFavorite: true,
    description: 'Combo bánh ngọt kèm đồ uống nóng.',
  ),
  SmartbagItemData(
    id: 'new-2',
    title: 'Combo Healthy Smoothie',
    merchant: 'DT Minimart',
    distance: '• 0.6 km',
    pickupWindow: 'Lấy vào 10:00 - 12:00 hôm nay',
    price: '32.000 đ',
    originalPrice: '58.000 đ',
    imageUrl: 'https://images.unsplash.com/photo-1481391032119-d89fee407e44?auto=format&fit=crop&w=640&q=80',
    description: 'Sinh tố healthy mix trái cây tươi.',
  ),
];

const List<MapTabItem> _mapTabItems = [
  MapTabItem(label: 'Smartbag', icon: Icons.card_giftcard_outlined),
  MapTabItem(label: 'Đang mở cửa', icon: Icons.access_time_outlined),
  MapTabItem(label: 'Gần tôi', icon: Icons.near_me_outlined),
];
