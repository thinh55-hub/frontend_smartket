import 'package:flutter/material.dart';
import '../widgets/forms/smartbag_category.dart';
import '../widgets/cards/smartbag_item.dart';
import '../widgets/forms/map_tab.dart';
import 'smartbag_detail_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/smartket_header_bar.dart';
import '../widgets/forms/location_pill.dart';
import '../widgets/forms/smartbag_chip_list.dart';
import '../data/mock_smartbag.dart';
import '../core/utils/formatting.dart';

class SmartbagScreen extends StatelessWidget {
  const SmartbagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SmartbagContent(),
    );
  }
}

class SmartbagContent extends StatefulWidget {
  const SmartbagContent({super.key});

  @override
  State<SmartbagContent> createState() => _SmartbagContentState();
}

class _SmartbagContentState extends State<SmartbagContent> {
  int _selectedChipIndex = 0;
  final List<GlobalKey> _categoryKeys =
      List.generate(3, (_) => GlobalKey(debugLabel: 'smartbag-category'));

  void _openSmartbagDetail(BuildContext context, SmartbagItemData deal) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SmartbagDetailScreen(deal: deal)));
  }

  void _onChipTap(int index) {
    if (_selectedChipIndex != index) {
      setState(() => _selectedChipIndex = index);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCategory(index));
  }

  void _scrollToCategory(int index) {
    if (index < 0 || index >= _categoryKeys.length) return;
    final context = _categoryKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const _SmartbagHeader(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: LocationPill(),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SmartbagChipList(
                    labels: const ['Mới nhất', 'Túi bữa sáng', 'Túi bữa trưa'],
                    selectedIndex: _selectedChipIndex,
                    onSelected: _onChipTap,
                  ),
                ),
                const SizedBox(height: 16),
                KeyedSubtree(
                  key: _categoryKeys[0],
                  child: SmartbagCategory(
                    title: 'Mới nhất',
                    icon: Icons.star_rounded,
                    deals: _smartbagNewestDeals,
                    onItemTap: (deal) => _openSmartbagDetail(context, deal),
                  ),
                ),
                const SizedBox(height: 24),
                KeyedSubtree(
                  key: _categoryKeys[1],
                  child: SmartbagCategory(
                    title: 'Túi bữa sáng',
                    icon: Icons.free_breakfast,
                    deals: _smartbagItemDeals,
                    onItemTap: (deal) => _openSmartbagDetail(context, deal),
                  ),
                ),
                const SizedBox(height: 24),
                KeyedSubtree(
                  key: _categoryKeys[2],
                  child: SmartbagCategory(
                    title: 'Túi bữa trưa',
                    icon: Icons.lunch_dining,
                    deals: _smartbagMiniDeals,
                    onItemTap: (deal) => _openSmartbagDetail(context, deal),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SmartbagHeader extends StatelessWidget {
  const _SmartbagHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: const SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: SmartketHeaderBar(logoHeight: 52),
        ),
      ),
    );
  }
}

List<SmartbagItemData> _buildSmartbagItemData() {
  return mockSmartbags
      .map(
        (bag) => SmartbagItemData(
          id: bag.id,
          title: bag.title,
          merchant: bag.storeName,
          distance: '• ${bag.distance}',
          pickupWindow: 'Lấy vào ${bag.pickupTime}',
          price: '${formatCurrency(bag.price)} đ',
          originalPrice: '${formatCurrency(bag.oldPrice)} đ',
          imageUrl: bag.imageAsset,
          isFavorite: false,
          description: bag.description ?? bag.tag,
          stock: bag.stock,
        ),
      )
      .toList();
}

final List<SmartbagItemData> _smartbagMiniDeals = _buildSmartbagItemData();
final List<SmartbagItemData> _smartbagItemDeals = _buildSmartbagItemData();
final List<SmartbagItemData> _smartbagNewestDeals = _buildSmartbagItemData();

const List<MapTabItem> _mapTabItems = [
  MapTabItem(label: 'Smartbag', icon: Icons.card_giftcard_outlined),
  MapTabItem(label: 'Đang mở cửa', icon: Icons.access_time_outlined),
  MapTabItem(label: 'Gần tôi', icon: Icons.near_me_outlined),
];
