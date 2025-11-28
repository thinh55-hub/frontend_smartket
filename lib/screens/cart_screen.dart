import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/store_cart_card.dart';
import '../core/state/cart_provider.dart';
import '../core/state/navigation_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/empty_state.dart';
import '../widgets/smartket_header_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: const CartContent(),
      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomNav(
          current: nav.current == MainTab.cart ? nav.current : MainTab.cart,
          onChanged: (tab) {
            if (tab == MainTab.cart) return;
            nav.current = tab;
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
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
        Container(
          color: Colors.white,
          width: double.infinity,
          child: const SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: SmartketHeaderBar(),
            ),
          ),
        ),
        Expanded(
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              if (cartProvider.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (cartProvider.error != null) {
                return Center(
                  child: EmptyState(
                    icon: Icons.warning_amber_outlined,
                    title: 'Không thể tải giỏ hàng',
                    subtitle: cartProvider.error,
                  ),
                );
              }
              final stores = cartProvider.stores;
              if (stores.isEmpty) {
                return const Center(
                  child: EmptyState(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Giỏ hàng đang trống',
                    subtitle: 'Hãy thêm sản phẩm để bắt đầu mua sắm',
                  ),
                );
              }
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8),
                  itemCount: stores.length + 1,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Giỏ hàng',
                              style: GoogleFonts.lexendDeca(fontSize: 24, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      );
                    }
                    final store = stores[index - 1];
                    return StoreCartCard(
                      storeName: store.name,
                      items: store.items
                          .map(
                            (item) => CompactCartItemData(
                              title: item.title,
                              price: item.price,
                              quantity: item.quantity,
                              imageAsset: item.imageAsset,
                              onIncrease: () => cartProvider.increaseQuantity(store.id, item.id),
                              onDecrease: () => cartProvider.decreaseQuantity(store.id, item.id),
                              onRemove: () => cartProvider.removeItem(store.id, item.id),
                            ),
                          )
                          .toList(),
                      onClose: () => cartProvider.removeStore(store.id),
                      onCheckout: () {},
                      margin: EdgeInsets.fromLTRB(16, index == 1 ? 0 : 12, 16, 12),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
