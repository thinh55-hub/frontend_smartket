import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/state/navigation_provider.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/smartket_header_bar.dart';
import '../theme/app_theme.dart';
import '../core/state/product_provider.dart';
import '../core/models/product.dart';
import '../data/mock_products.dart';
import '../components/product_card.dart';
import '../components/smartbag_chip.dart';
import '../components/segmented_label_row.dart';
import '../components/stat_card.dart';
import '../components/search_pill.dart';
import 'product_detail_screen.dart';
import 'explore_screen.dart';
import 'qr_screen.dart';
import 'smartbag_screen.dart';
import 'cart_screen.dart';

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
        bottomNavigationBar: SafeArea(
          top: false,
          child: BottomNav(current: nav.current, onChanged: (t) => nav.current = t),
        ),
      ),
    );
  }

  Widget _buildTabContent(MainTab currentTab) {
    switch (currentTab) {
      case MainTab.home:
        return _HomeOverview();
      case MainTab.explore:
        return ExploreContent();
      case MainTab.qr:
        return const QrContent();
      case MainTab.smartbag:
        return const SmartbagContent();
      case MainTab.cart:
        return const CartContent();
    }
  }
}

// Replace the broken _HomeShell with a clean _HomeOverview that contains
// the previously inlined home UI (header + scrollable content).
class _HomeOverview extends StatelessWidget {
  const _HomeOverview();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _HomeHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 32),
            physics: const BouncingScrollPhysics(),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _OverviewHero(),
                SizedBox(height: 24),
                _SmartbagShelf(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SmartketHeaderBar(),
              const SizedBox(height: 12),
              // Figma Node: 346-1052 — Location selector pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFECEFF3)),
                  boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.location_on_outlined, size: 18, color: AppColors.primary),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Quận 1, TP.HCM • 5 km', style: TextStyle(fontSize: 13, color: AppColors.textPrimary)),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textPrimary),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Figma Node: 558-491 — Search input
                  // Search (reusable component)
                  const SearchPill(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverviewHero extends StatefulWidget {
  const _OverviewHero();
  static const _heroBorderRadius = BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32));

  @override
  State<_OverviewHero> createState() => _OverviewHeroState();
}

class _OverviewHeroState extends State<_OverviewHero> {
  int _selectedRange = 0;

  static const List<_RangeStats> _statsByRange = [
    _RangeStats(
      rescuedValue: '2',
      rescuedSubtitle: 'Túi thực phẩm đã cứu hôm nay',
      savedValue: '36.000 đ',
      savedSubtitle: 'Số tiền đã tiết kiệm hôm nay',
    ),
    _RangeStats(
      rescuedValue: '7',
      rescuedSubtitle: 'Túi thực phẩm đã cứu tuần này',
      savedValue: '136.000 đ',
      savedSubtitle: 'Số tiền đã tiết kiệm tuần này',
    ),
    _RangeStats(
      rescuedValue: '16',
      rescuedSubtitle: 'Túi thực phẩm đã cứu tháng này',
      savedValue: '236.000 đ',
      savedSubtitle: 'Số tiền đã tiết kiệm tháng này',
    ),
  ];

  void _onSelectRange(int index) {
    if (_selectedRange == index) return;
    setState(() => _selectedRange = index);
  }
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: _OverviewHero._heroBorderRadius,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.heroGradientStart, AppColors.heroGradientMid, AppColors.heroGradientFade],
            stops: [0.0, 0.7, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: _OverviewHero._heroBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Column(
                    children: [
                      _SlidingSegmentControl(
                        selectedIndex: _selectedRange,
                        onSelected: _onSelectRange,
                      ),
                      const SizedBox(height: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        child: Row(
                          key: ValueKey(_selectedRange),
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Hôm nay bạn đã cứu được',
                                value: _statsByRange[_selectedRange].rescuedValue,
                                subtitle: _statsByRange[_selectedRange].rescuedSubtitle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: StatCard(
                                title: 'Tiền đã tiết kiệm',
                                value: _statsByRange[_selectedRange].savedValue,
                                subtitle: _statsByRange[_selectedRange].savedSubtitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const SizedBox(width: 14),
                  _PromoIcon(),
                  const SizedBox(width: 8),
                  Text(
                    'Khuyến mãi gần bạn',
                    style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRect(
                child: SizedBox(
                  height: 238.281,
                  child: Consumer<ProductProvider>(
                    builder: (context, provider, _) {
                      if (provider.loading) {
                        return const Center(
                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                        );
                      }
                      if (provider.error != null) {
                        return Center(
                          child: Text('Lỗi: ${provider.error}', style: TextStyle(color: Colors.white)),
                        );
                      }
                      final data = provider.products.isNotEmpty ? provider.products : mockProducts;
                      final promos = data.take(6).toList();
                      if (promos.isEmpty) {
                        return const Center(
                          child: Text('Chưa có sản phẩm', style: TextStyle(color: Colors.white)),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.only(left: 18, right:  18),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: promos.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final product = promos[index];
                          return ProductCard(
                            product: product,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmartbagShelf extends StatefulWidget {
  const _SmartbagShelf();

  @override
  State<_SmartbagShelf> createState() => _SmartbagShelfState();
}

class _SmartbagShelfState extends State<_SmartbagShelf> {
  int _selectedIndex = 0;
  final List<GlobalKey> _cardKeys = List.generate(_smartbagDeals.length, (_) => GlobalKey());

  void _onChipTap(int index) {
    if (_selectedIndex != index) {
      setState(() => _selectedIndex = index);
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCard(index));
    } else {
      _scrollToCard(index);
    }
  }

  void _scrollToCard(int index) {
    final context = _cardKeys[index].currentContext;
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
    final deals = _smartbagDeals;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 22, 0, 26),
        decoration: BoxDecoration(
          color: const Color(0xFFF1FBF5),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Smartbag đáng chú ý',
                        style: GoogleFonts.lexendDeca(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Săn túi thực phẩm ngon giá tốt trong ngày',
                        style: GoogleFonts.lexendDeca(fontSize: 13, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    foregroundColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    textStyle: GoogleFonts.lexendDeca(fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {},
                  child: const Text('Xem tất cả'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: deals.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final deal = deals[index];
                  return SmartbagChip(
                    label: deal.tag,
                    selected: index == _selectedIndex,
                    onTap: () => _onChipTap(index),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: deals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final deal = deals[index];
                return KeyedSubtree(
                  key: _cardKeys[index],
                  child: _SmartbagHighlightCard(deal: deal, highlight: index == _selectedIndex),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SmartbagHighlightCard extends StatelessWidget {
  final _SmartbagDeal deal;
  final bool highlight;

  const _SmartbagHighlightCard({required this.deal, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    final Color textColor = highlight ? Colors.white : AppColors.textPrimary;
    final Color muted = highlight ? Colors.white.withOpacity(0.78) : AppColors.textSecondary;
    final gradient = highlight
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00C261), Color(0xFF00994E)],
          )
        : const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEFF8F2)],
          );

    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: gradient,
        border: highlight ? null : Border.all(color: const Color(0xFFD9E6DD)),
        boxShadow: highlight
            ? const [BoxShadow(color: Color(0x3300AF55), blurRadius: 24, offset: Offset(0, 14))]
            : const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _SmartbagEmojiBadge(emoji: deal.emoji, highlight: highlight),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SmartbagTag(label: deal.tag, highlight: highlight),
                    const SizedBox(height: 6),
                    Text(
                      deal.title,
                      style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w700, color: textColor),
                    ),
                    Text(
                      deal.store,
                      style: GoogleFonts.lexendDeca(fontSize: 12, fontWeight: FontWeight.w500, color: muted),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: highlight ? Colors.white : AppColors.primary, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: muted),
              const SizedBox(width: 4),
              Text(deal.distance, style: GoogleFonts.lexendDeca(fontSize: 12, color: muted)),
              const SizedBox(width: 12),
              Icon(Icons.access_time, size: 16, color: muted),
              const SizedBox(width: 4),
              Text(deal.time, style: GoogleFonts.lexendDeca(fontSize: 12, color: muted)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                deal.price,
                style: GoogleFonts.lexendDeca(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: highlight ? Colors.white : AppColors.primary,
                ),
              ),
              if (deal.originalPrice != null) ...[
                const SizedBox(width: 10),
                Text(
                  deal.originalPrice!,
                  style: GoogleFonts.lexendDeca(
                    fontSize: 13,
                    color: muted,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
              if (deal.savingText != null) ...[
                const SizedBox(width: 10),
                Text(
                  deal.savingText!,
                  style: GoogleFonts.lexendDeca(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: highlight ? Colors.white : AppColors.primary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _SmartbagTag extends StatelessWidget {
  final String label;
  final bool highlight;

  const _SmartbagTag({required this.label, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: highlight ? Colors.white.withOpacity(0.18) : const Color(0xFFEFFCEB),
        borderRadius: BorderRadius.circular(14),
        border: highlight ? Border.all(color: Colors.white.withOpacity(0.3)) : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.lexendDeca(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: highlight ? Colors.white : const Color(0xFF00C853),
        ),
      ),
    );
  }
}

class _SmartbagEmojiBadge extends StatelessWidget {
  final String emoji;
  final bool highlight;

  const _SmartbagEmojiBadge({required this.emoji, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: highlight ? Colors.white.withOpacity(0.15) : Colors.white,
        border: highlight ? Border.all(color: Colors.white24) : Border.all(color: const Color(0xFFE3EBE4)),
        boxShadow: highlight ? null : const [BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 6))],
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

class _PromoIcon extends StatelessWidget {
  const _PromoIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0)),
      ),
      child: CustomPaint(
        size: const Size(20, 20),
        painter: _PromoIconPainter(),
      ),
    );
  }
}

class _PromoIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.66603
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.save();
    canvas.clipRect(clipRect);

    final path1 = Path()
      ..moveTo(size.width * 0.6664, size.height * 0.4165)
      ..cubicTo(size.width * 0.6664, size.height * 0.4592, size.width * 0.6495, size.height * 0.5003,
          size.width * 0.6190, size.height * 0.5309)
      ..cubicTo(size.width * 0.5885, size.height * 0.5614, size.width * 0.5474, size.height * 0.5783,
          size.width * 0.5048, size.height * 0.5783)
      ..cubicTo(size.width * 0.4622, size.height * 0.5783, size.width * 0.4211, size.height * 0.5614,
          size.width * 0.3906, size.height * 0.5309)
      ..cubicTo(size.width * 0.3601, size.height * 0.5003, size.width * 0.3432, size.height * 0.4592,
          size.width * 0.3432, size.height * 0.4165);
    canvas.drawPath(path1, paint);

    canvas.drawLine(
      Offset(size.width * 0.1293, size.height * 0.2513),
      Offset(size.width * 0.8707, size.height * 0.2513),
      paint,
    );

    final path3 = Path()
      ..moveTo(size.width * 0.1417, size.height * 0.2275)
      ..cubicTo(size.width * 0.1291, size.height * 0.2440, size.width * 0.1225, size.height * 0.2650,
          size.width * 0.1225, size.height * 0.2867)
      ..lineTo(size.width * 0.1225, size.height * 0.8330)
      ..cubicTo(size.width * 0.1225, size.height * 0.8566, size.width * 0.1318, size.height * 0.8789,
          size.width * 0.1480, size.height * 0.8951)
      ..cubicTo(size.width * 0.1642, size.height * 0.9113, size.width * 0.1865, size.height * 0.9206,
          size.width * 0.2101, size.height * 0.9206)
      ..lineTo(size.width * 0.7900, size.height * 0.9206)
      ..cubicTo(size.width * 0.8136, size.height * 0.9206, size.width * 0.8359, size.height * 0.9113,
          size.width * 0.8521, size.height * 0.8951)
      ..cubicTo(size.width * 0.8683, size.height * 0.8789, size.width * 0.8775, size.height * 0.8566,
          size.width * 0.8775, size.height * 0.8330)
      ..lineTo(size.width * 0.8775, size.height * 0.2867)
      ..cubicTo(size.width * 0.8775, size.height * 0.2650, size.width * 0.8709, size.height * 0.2440,
          size.width * 0.8583, size.height * 0.2275)
      ..lineTo(size.width * 0.7747, size.height * 0.1166)
      ..cubicTo(size.width * 0.7671, size.height * 0.1067, size.width * 0.7578, size.height * 0.0985,
          size.width * 0.7470, size.height * 0.0926)
      ..cubicTo(size.width * 0.7362, size.height * 0.0868, size.width * 0.7243, size.height * 0.0834,
          size.width * 0.7122, size.height * 0.0834)
      ..lineTo(size.width * 0.2914, size.height * 0.0834)
      ..cubicTo(size.width * 0.2793, size.height * 0.0834, size.width * 0.2674, size.height * 0.0868,
          size.width * 0.2566, size.height * 0.0926)
      ..cubicTo(size.width * 0.2458, size.height * 0.0985, size.width * 0.2365, size.height * 0.1067,
          size.width * 0.2289, size.height * 0.1166)
      ..lineTo(size.width * 0.1417, size.height * 0.2275);
    canvas.drawPath(path3, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SmartbagDeal {
  final String tag;
  final String title;
  final String store;
  final String distance;
  final String price;
  final String time;
  final String emoji;
  final String? originalPrice;
  final String? savingText;

  const _SmartbagDeal({
    required this.tag,
    required this.title,
    required this.store,
    required this.distance,
    required this.price,
    required this.time,
    required this.emoji,
    this.originalPrice,
    this.savingText,
  });
}

const List<_SmartbagDeal> _smartbagDeals = [
  _SmartbagDeal(
    tag: 'Túi Ăn Sáng',
    title: 'Bakery & Coffee',
    store: 'Gia Lạc Minimart',
    distance: '0.8 km',
    price: '45.000 ₫',
    time: '07:00 - 09:00',
    emoji: '🥐',
    originalPrice: '90.000 ₫',
    savingText: 'Tiết kiệm 50%',
  ),
  _SmartbagDeal(
    tag: 'Túi Ăn Chiều',
    title: 'Bakery & Coffee',
    store: 'Gia Lạc Minimart',
    distance: '0.8 km',
    price: '45.000 ₫',
    time: '15:00 - 17:00',
    emoji: '🥐',
    originalPrice: '90.000 ₫',
    savingText: 'Tiết kiệm 50%',
  ),
  _SmartbagDeal(
    tag: 'Túi Đồ Uống',
    title: 'Tea & Smoothie',
    store: 'ĐT Minimart',
    distance: '1.2 km',
    price: '39.000 ₫',
    time: '13:00 - 15:00',
    emoji: '🥤',
    originalPrice: '70.000 ₫',
    savingText: 'Còn 2 túi',
  ),
  _SmartbagDeal(
    tag: 'Túi Healthy',
    title: 'Eat Clean Combo',
    store: 'GL Minimart',
    distance: '0.5 km',
    price: '52.000 ₫',
    time: '10:00 - 12:00',
    emoji: '🥗',
    originalPrice: '98.000 ₫',
    savingText: 'Tiết kiệm 47%',
  ),
];

class _SlidingSegmentControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _SlidingSegmentControl({required this.selectedIndex, required this.onSelected});

  static const _labels = ['Ngày', 'Tuần', 'Tháng'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double padding = 4;
        final double availableWidth = constraints.maxWidth - padding * 2;
        final double itemWidth = availableWidth / _labels.length;

        return Container(
          height: 40,
          padding: const EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(39),
            boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 8))],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 280),
                left: selectedIndex * itemWidth,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF00A63E), Color(0xFF00C950)],
                        ),
                        boxShadow: [
                          BoxShadow(color: Color(0x4000C950), blurRadius: 12, offset: Offset(0, 4)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SegmentedLabelRow(labels: _labels, selectedIndex: selectedIndex, onSelected: onSelected),
            ],
          ),
        );
      },
    );
  }
}

class _RangeStats {
  final String rescuedValue;
  final String rescuedSubtitle;
  final String savedValue;
  final String savedSubtitle;

  const _RangeStats({
    required this.rescuedValue,
    required this.rescuedSubtitle,
    required this.savedValue,
    required this.savedSubtitle,
  });
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
    return SizedBox(
      width: 180,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0E4EE)),
              boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0,4))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Container(
                  height: 72,
                  decoration: BoxDecoration(color: const Color(0xFFF6F8FA), borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: Icon(Icons.ramen_dining, size: 36, color: Color(0xFFEF6C00))),
                ),
                const SizedBox(height: 8),
                Text(title, style: GoogleFonts.lexendDeca(fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  '$store\n$distance',
                  style: GoogleFonts.lexendDeca(fontSize: 11, color: const Color(0xFF00C853)),
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.lexendDeca(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.red),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        oldPrice,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: GoogleFonts.lexendDeca(fontSize: 11, color: const Color(0xFFB3BAC8), decoration: TextDecoration.lineThrough),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: -50,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE5E8),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [BoxShadow(color: Color(0x16000000), blurRadius: 8, offset: Offset(0,4))],
              ),
              child: Text(discount, style: GoogleFonts.lexendDeca(fontSize: 24, fontWeight: FontWeight.w400, color: const Color(0xFFB00020))),
            ),
          ),
        ],
      ),
    );
  }
}
