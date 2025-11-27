import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/store_cart_card.dart';
import '../components/compact_cart_item.dart';
import '../theme/app_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const SafeArea(child: CartContent()),
    );
  }
}

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            children: [
              IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new, size: 18)),
              const SizedBox(width: 8),
              Text('Giỏ hàng', style: GoogleFonts.lexendDeca(fontSize: 20, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: _sampleStores.length,
            itemBuilder: (context, index) {
              final store = _sampleStores[index];
              return StoreCartCard(
                storeName: store.name,
                items: store.items,
                onCheckout: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}

final List<_StoreCart> _sampleStores = [
  _StoreCart(
    name: 'GL Minimart',
    items: const [
      CompactCartItemData(title: 'Mỳ Hảo Hảo Tôm Chua Cay', price: 6000, quantity: 0, imageAsset: 'assets/images/mi_hao_hao.png'),
      CompactCartItemData(title: 'Sữa Tươi Ít Đường TH True Milk', price: 12000, quantity: 0, imageAsset: 'assets/images/sua_th.png'),
      CompactCartItemData(title: 'Kẹo Dẻo Haribo', price: 8000, quantity: 0, imageAsset: 'assets/images/haribo.png'),
    ],
  ),
  _StoreCart(
    name: 'ĐT Minimart',
    items: const [
      CompactCartItemData(title: 'Nước Ép Cam Twister', price: 12500, quantity: 0, imageAsset: 'assets/images/twister.png'),
      CompactCartItemData(title: 'Oishi Snack Bí Đỏ', price: 5000, quantity: 0, imageAsset: 'assets/images/oishi.png'),
      CompactCartItemData(title: 'Cà Phê Hoà Tan G7', price: 21000, quantity: 0, imageAsset: 'assets/images/g7.png'),
    ],
  ),
];

class _StoreCart {
  final String name;
  final List<CompactCartItemData> items;

  const _StoreCart({required this.name, required this.items});
}
