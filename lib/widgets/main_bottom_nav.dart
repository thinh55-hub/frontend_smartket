import 'package:flutter/material.dart';

enum MainTab { home, explore, qr, smartbag, cart }

class MainBottomNavBar extends StatelessWidget {
  final MainTab current;
  final ValueChanged<MainTab> onChanged;

  const MainBottomNavBar({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_BottomItem>[
      _BottomItem(MainTab.home, Icons.home_outlined, 'Trang chủ'),
      _BottomItem(MainTab.explore, Icons.storefront_outlined, 'Khám phá'),
      _BottomItem(MainTab.qr, Icons.qr_code_2, 'Mã QR'),
      _BottomItem(MainTab.smartbag, Icons.card_giftcard_outlined, 'Smartbag'),
      _BottomItem(MainTab.cart, Icons.shopping_bag_outlined, 'Giỏ hàng'),
    ];

    return Container(
      height: 64,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: items.map((item) {
          final selected = item.tab == current;
          final color = selected ? const Color(0xFF00C853) : const Color(0xFFB3BAC8);
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(item.tab),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, size: 22, color: color),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(fontSize: 11, color: color),
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

class _BottomItem {
  final MainTab tab;
  final IconData icon;
  final String label;

  _BottomItem(this.tab, this.icon, this.label);
}

