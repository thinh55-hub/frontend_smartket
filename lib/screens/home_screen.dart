import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../core/state/navigation_provider.dart';
import '../widgets/bottom_nav.dart';
import '../theme/app_theme.dart';
import '../core/state/product_provider.dart';
import '../core/models/product.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isLandscape;

  const HomeScreen({super.key, required this.isLandscape});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // HomeScreen now reads tab state from NavigationProvider.

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: _buildTabContent(nav.current),
        bottomNavigationBar: BottomNav(
          current: nav.current,
          onChanged: (tab) {
            nav.current = tab;
          },
        ),
      ),
    );
  }

  Widget _buildTabContent(MainTab currentTab) {
    switch (currentTab) {
      case MainTab.home:
        return const _HomeOverview();
      case MainTab.explore:
        return const _ExploreTab();
      case MainTab.qr:
        return const _QrTab();
      case MainTab.smartbag:
        return const _SmartbagTab();
      case MainTab.cart:
        return const _CartTab();
    }
  }
}

// This private shell is intentionally unused in some layouts; keep it for future designs.
// ignore: unused_element
class _HomeShell extends StatelessWidget {
  final bool isLandscape;
  final MainTab currentTab;
  final ValueChanged<MainTab> onBottomChanged;
  final Widget child;

  const _HomeShell({
    required this.isLandscape,
    required this.currentTab,
    required this.onBottomChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final aspect = isLandscape ? 9 / 5 : 9 / 19.5;

    return AspectRatio(
      aspectRatio: aspect,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFFF5F7FB),
                  child: child,
                ),
              ),
              const Divider(height: 1, thickness: 0.4),
              BottomNav(current: currentTab, onChanged: onBottomChanged),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeOverview extends StatelessWidget {
  const _HomeOverview();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Fixed header section
        Container(
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      'SMARTKET',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.favorite_border, color: Color(0xFF00C853)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_outline, color: Color(0xFF00C853)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E4EE)),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, size: 20, color: Color(0xFF9AA1AF)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Tìm sản phẩm, cửa hàng, smartbag...',
                          style: TextStyle(fontSize: 13, color: Color(0xFF9AA1AF)),
                        ),
                      ),
                      Icon(Icons.tune_rounded, size: 18, color: Color(0xFF9AA1AF)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _SegmentChip('Ngày', true),
                      const SizedBox(width: 8),
                      _SegmentChip('Tuần', false),
                      const SizedBox(width: 8),
                      _SegmentChip('Tháng', false),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
          SizedBox(
          height: 90,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              _StatCard(title: 'Túi thực phẩm đã cứu', value: '3', subtitle: 'Hôm nay bạn đã cứu được'),
              SizedBox(width: 12),
              _StatCard(title: 'Tiền đã tiết kiệm', value: '82.000 đ', subtitle: 'Số tiền bạn tiết kiệm hôm nay'),
            ],
          ),
          ),
          const SizedBox(height: 16),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Icon(Icons.local_offer_outlined, size: 16, color: Color(0xFF00C853)),
              SizedBox(width: 6),
              Text('Khuyến mãi gần bạn', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 170,
            child: Consumer<ProductProvider>(
              builder: (context, provider, _) {
                if (provider.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.error != null) {
                  return Center(
                    child: Text(
                      'Lỗi: ${provider.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  );
                }
                final products = provider.products.take(10).toList();
                if (products.isEmpty) {
                  return const Center(
                    child: Text(
                      'Chưa có sản phẩm',
                      style: TextStyle(fontSize: 12, color: Color(0xFF80848F)),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (ctx, i) {
                    final p = products[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: p),
                          ),
                        );
                      },
                      child: _ProductCard(product: p),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Icon(Icons.shopping_bag_outlined, size: 16, color: Color(0xFF00C853)),
              SizedBox(width: 6),
              Text('Smartbag gần bạn', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
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
              _SmartbagCard(
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
              _SmartbagCard(
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
          const SizedBox(height: 16),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Icon(Icons.favorite_border, size: 16, color: Color(0xFF00C853)),
              SizedBox(width: 6),
              Text('Cửa hàng yêu thích', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          ),
          const SizedBox(height: 8),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFE0E4EE)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.favorite_border, size: 32, color: Color(0xFFB3BAC8)),
                SizedBox(height: 12),
                Text(
                  'Bạn chưa có cửa hàng yêu thích',
                  style: TextStyle(fontSize: 13, color: Color(0xFF3C404B)),
                ),
                SizedBox(height: 4),
                Text(
                  "Hãy nhấn nút '❤' tại trang cửa hàng để lưu lại.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: Color(0xFF80848F)),
                ),
              ],
            ),
          ),
          ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}class _SegmentChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _SegmentChip(this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF00C853) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : const Color(0xFF3C404B),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, color: Color(0xFF3C404B))),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 11, color: Color(0xFF80848F)),
          ),
        ],
      ),
    );
  }
}

class _DealCard extends StatelessWidget {
  final String title;
  final String store;
  final String distance;
  final String price;
  final String oldPrice;
  final String discount;

  const _DealCard({
    required this.title,
    required this.store,
    required this.distance,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E4EE)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Icon(Icons.ramen_dining, size: 32, color: Color(0xFFEF6C00)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(
            '$store\n$distance',
            style: const TextStyle(fontSize: 11, color: Color(0xFF00C853)),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                price,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.red),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  oldPrice,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFB3BAC8),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  discount,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final price = product.price != null ? _formatCurrency(product.price!) : '--';
    final oldPrice = product.oldPrice != null ? _formatCurrency(product.oldPrice!) : null;
    final discount = (product.price != null && product.oldPrice != null && product.oldPrice! > 0)
        ? '-${(((product.oldPrice! - product.price!) / product.oldPrice!) * 100).round()}%'
        : null;

    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E4EE)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          SizedBox(
            height: 48,
            child: product.imageUrl != null
                ? Image.asset(
                    product.imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (ctx, error, stack) => const Icon(Icons.ramen_dining, size: 32, color: Color(0xFFEF6C00)),
                  )
                : const Icon(Icons.ramen_dining, size: 32, color: Color(0xFFEF6C00)),
          ),
          Text(
            product.name,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            product.merchantName ?? 'SMARTKET',
            style: const TextStyle(fontSize: 11, color: Color(0xFF00C853)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                price,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.red),
              ),
              const SizedBox(width: 4),
              if (oldPrice != null)
                Flexible(
                  child: Text(
                    oldPrice,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFB3BAC8),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              const Spacer(),
              if (discount != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.discountPink,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    discount,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.discountRed,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double v) {
    // Format VND: no decimals, '.' as thousand separator
    final int amount = v.toInt();
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return '${buffer.toString()} đ';
  }
}

class _ExploreTab extends StatelessWidget {
  const _ExploreTab();

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text(
                'KHÁM PHÁ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Color(0xFF00C853)),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Color(0xFF00C853)),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              _SegmentChip('Danh sách', true),
              SizedBox(width: 8),
              _SegmentChip('Bản đồ', false),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, size: 20, color: Color(0xFF9AA1AF)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tìm kiếm sản phẩm hoặc cửa hàng...',
                    style: TextStyle(fontSize: 13, color: Color(0xFF9AA1AF)),
                  ),
                ),
                Icon(Icons.tune_rounded, size: 18, color: Color(0xFF9AA1AF)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: categories.map((c) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        c,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF3C404B)),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text('Thực phẩm & đồ ăn', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const _DealCard(
                  title: 'Cơm Bento Trứng Cuộn',
                  store: 'Gia Lạc Minimart',
                  distance: '0.8 km',
                  price: '35.000 đ',
                  oldPrice: '50.000 đ',
                  discount: '-30%',
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _QrTab extends StatelessWidget {
  const _QrTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Mã QR của tôi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              _SegmentChip('Đơn hàng', true),
              SizedBox(width: 8),
              _SegmentChip('Smartbag', false),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.qr_code_2, size: 72, color: Color(0xFFB3BAC8)),
                SizedBox(height: 16),
                Text(
                  'Chưa có mã QR nào',
                  style: TextStyle(fontSize: 14, color: Color(0xFF80848F)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SmartbagTab extends StatelessWidget {
  const _SmartbagTab();

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text(
                'Smartbag',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Color(0xFF00C853)),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Color(0xFF00C853)),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E4EE)),
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
                  child: _SegmentChip(c, selected),
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
              _SmartbagCard(
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
              _SmartbagCard(
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

class _SmartbagCard extends StatelessWidget {
  final String tag;
  final String title;
  final String store;
  final String distance;
  final String price;
  final String oldPrice;
  final String discount;
  final String time;

  const _SmartbagCard({
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
    return Container(
      width: 190,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E4EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lunch_dining, size: 28, color: Color(0xFFFFA726)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE5F9EC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              tag,
              style: const TextStyle(fontSize: 10, color: Color(0xFF00C853)),
            ),
          ),
          const SizedBox(height: 4),
          Text(title, 
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '$store\n$distance',
            style: const TextStyle(fontSize: 10, color: Color(0xFF00C853)),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                price,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.red),
              ),
              const SizedBox(width: 4),
              Text(
                oldPrice,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFFB3BAC8),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.discountPink,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  discount,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.discountRed,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time, size: 12, color: Color(0xFF80848F)),
              const SizedBox(width: 3),
              Text(
                time,
                style: const TextStyle(fontSize: 10, color: Color(0xFF80848F)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CartTab extends StatelessWidget {
  const _CartTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Icon(Icons.shopping_bag_outlined, size: 56, color: Color(0xFFB3BAC8)),
        const SizedBox(height: 12),
        const Text(
          'Giỏ hàng của bạn đang trống',
          style: TextStyle(fontSize: 14, color: Color(0xFF80848F)),
        ),
      ],
    );
  }
}
