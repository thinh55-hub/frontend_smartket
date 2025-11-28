import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../core/localization/app_localizations.dart';
import '../widgets/layout/map_store_overlay.dart';
import '../widgets/forms/map_tab.dart';
import '../widgets/cards/product_card.dart';
import '../widgets/forms/search_pill.dart';
import '../widgets/forms/smartbag_chip_list.dart';
import '../widgets/cards/store_explore_card.dart';
import '../core/models/product.dart';
import '../core/models/smartbag.dart';
import '../core/state/product_provider.dart';
import '../core/state/smartbag_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/layout/smartket_header_bar.dart';
import 'product_detail_screen.dart';

enum ExploreTab { list, map }

class ExploreContent extends StatefulWidget {
  const ExploreContent({super.key});

  @override
  State<ExploreContent> createState() => _ExploreContentState();
}

class _ExploreContentState extends State<ExploreContent> {
  ExploreTab _selectedTab = ExploreTab.list;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: SmartketHeaderBar(),
          ),
        ),
        ),
        if (_selectedTab == ExploreTab.map)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _ExploreModeChip(
                    label: strings.exploreListLabel,
                    selected: _selectedTab == ExploreTab.list,
                    onTap: () => _onTabSelected(ExploreTab.list),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ExploreModeChip(
                    label: strings.exploreMapLabel,
                    selected: _selectedTab == ExploreTab.map,
                    onTap: () => _onTabSelected(ExploreTab.map),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _selectedTab == ExploreTab.list
                ? _ListExploreTab(
                    key: const ValueKey('list-tab'),
                    selectedTab: _selectedTab,
                    onTabSelected: _onTabSelected,
                  )
                : const _MapExploreTab(key: ValueKey('map-tab')),
          ),
        ),
      ],
    );
  }

  void _onTabSelected(ExploreTab tab) {
    if (_selectedTab == tab) return;
    setState(() => _selectedTab = tab);
  }
}

class _ListExploreTab extends StatelessWidget {
  final ExploreTab selectedTab;
  final ValueChanged<ExploreTab> onTabSelected;

  const _ListExploreTab({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _ExploreModeChip(
                  label: strings.exploreListLabel,
                  selected: selectedTab == ExploreTab.list,
                  onTap: () => onTabSelected(ExploreTab.list),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ExploreModeChip(
                  label: strings.exploreMapLabel,
                  selected: selectedTab == ExploreTab.map,
                  onTap: () => onTabSelected(ExploreTab.map),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SmartbagChipList(
            labels: _exploreCategories,
            selectedIndex: 0,
            onSelected: (_) {},
          ),
          const SizedBox(height: 8),
          Consumer<ProductProvider>(
            builder: (context, provider, _) {
              final products = provider.products.isNotEmpty
                  ? provider.products
                  : _fallbackProducts;
              if (products.isEmpty) {
                return Center(child: Text(strings.exploreNoProducts));
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
                  return ProductCard(
                    product: product,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MapExploreTab extends StatefulWidget {
  const _MapExploreTab({super.key});

  @override
  State<_MapExploreTab> createState() => _MapExploreTabState();
}

class _MapExploreTabState extends State<_MapExploreTab> {
  bool _overlayExpanded = false;

  void _toggleOverlaySize() {
    setState(() => _overlayExpanded = !_overlayExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, SmartbagProvider>(
      builder: (context, productProvider, smartbagProvider, _) {
        final strings = AppLocalizations.of(context);
        final products = productProvider.products.isNotEmpty
            ? productProvider.products
            : _fallbackProducts;
        final stores = _buildStoreSections(products, smartbagProvider.bags);
        return Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                child: Image.asset(
                  'assets/images/map_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 24,
              left: 24,
              right: 24,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SearchPill(
                    placeholder: strings.searchPlaceholder,
                  ),
                  const SizedBox(height: 12),
                  MapTab(items: _mapTabFilters),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MapStoreOverlay(
                stores: stores,
                expanded: _overlayExpanded,
                onToggleSize: _toggleOverlaySize,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ExploreModeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ExploreModeChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
              color: selected ? AppColors.primary : AppColors.border),
          boxShadow: selected ? AppShadows.light : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.lexendDeca(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.textPrimary,
          ),
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

const List<MapTabItem> _mapTabFilters = [
  MapTabItem(label: 'Smartbag', icon: Icons.card_giftcard_outlined),
  MapTabItem(label: 'Đang mở cửa', icon: Icons.access_time),
  MapTabItem(label: 'Gần tôi', icon: Icons.navigation_outlined),
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

List<StoreExploreData> _buildStoreSections(
  List<Product> products,
  List<Smartbag> smartbags,
) {
  final grouped = <String, List<Product>>{};
  for (final product in products) {
    final key = (product.merchantName ?? '').isEmpty
        ? 'Cửa hàng nổi bật'
        : product.merchantName!;
    grouped.putIfAbsent(key, () => <Product>[]);
    grouped[key]!.add(product);
  }

  final entries = grouped.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  final smartbagByStore = <String, Smartbag>{};
  for (final bag in smartbags) {
    smartbagByStore.putIfAbsent(bag.storeName, () => bag);
  }

  return List.generate(entries.length, (index) {
    final data = entries[index];
    final meta = _storeMetas[index % _storeMetas.length];
    final featured = data.value.take(5).toList();
    final matchedBag = smartbagByStore[data.key];
    return StoreExploreData(
      id: 'map-store-${index + 1}',
      name: data.key,
      rating: meta.rating,
      reviewCountLabel: meta.reviewLabel,
      etaText: meta.eta,
      isOpen: meta.isOpen,
      statusDetail: meta.statusDetail,
      distanceText: meta.distance,
      featuredProducts: featured,
      smartbag: matchedBag,
    );
  });
}

class _StoreMeta {
  final double rating;
  final String reviewLabel;
  final String eta;
  final bool isOpen;
  final String statusDetail;
  final String? distance;

  const _StoreMeta({
    required this.rating,
    required this.reviewLabel,
    required this.eta,
    required this.isOpen,
    required this.statusDetail,
    this.distance,
  });
}

const List<_StoreMeta> _storeMetas = [
  _StoreMeta(
    rating: 4.2,
    reviewLabel: '40+',
    eta: '5 phút',
    isOpen: true,
    statusDetail: 'Đóng cửa lúc 20:00',
    distance: '0.8 km',
  ),
  _StoreMeta(
    rating: 4.5,
    reviewLabel: '120+',
    eta: '8 phút',
    isOpen: true,
    statusDetail: 'Đóng cửa lúc 21:30',
    distance: '1.2 km',
  ),
  _StoreMeta(
    rating: 4.0,
    reviewLabel: '25+',
    eta: '12 phút',
    isOpen: false,
    statusDetail: 'Mở lại lúc 7:00',
    distance: '2.4 km',
  ),
];
