import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum MainTab { home, explore, qr, smartbag, cart }

class BottomNav extends StatelessWidget {
  final MainTab current;
  final ValueChanged<MainTab> onChanged;

  const BottomNav({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_NavItem>[
      _NavItem(MainTab.home, Icons.home_outlined, 'Trang chủ'),
      _NavItem(MainTab.explore, Icons.search_outlined, 'Khám phá'),
      _NavItem(MainTab.qr, Icons.qr_code_2, 'Mã QR'),
      _NavItem(MainTab.smartbag, Icons.card_giftcard_outlined, 'Smartbag'),
      _NavItem(MainTab.cart, Icons.shopping_bag_outlined, 'Giỏ hàng'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: AppRadius.r20,
          topRight: AppRadius.r20,
        ),
        boxShadow: AppShadows.light,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: items.map((item) {
          final selected = item.tab == current;
          final color = selected ? AppColors.primary : AppColors.navInactive;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(item.tab),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, size: 22, color: color),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 11,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  final MainTab tab;
  final IconData icon;
  final String label;

  _NavItem(this.tab, this.icon, this.label);
}

