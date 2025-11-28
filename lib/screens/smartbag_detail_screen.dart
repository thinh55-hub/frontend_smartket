import 'package:flutter/material.dart';

import '../widgets/layout/product_detail_page.dart';
import '../widgets/cards/smartbag_item.dart';
import '../core/models/product.dart';

class SmartbagDetailScreen extends StatelessWidget {
  final SmartbagItemData deal;

  const SmartbagDetailScreen({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    final product = Product(
      id: deal.id,
      name: deal.title,
      description: deal.description ?? 'Thời gian lấy túi: ${deal.pickupWindow}. Túi Smartbag gồm nhiều món bất ngờ được chọn lọc trong ngày.',
      price: _parsePrice(deal.price),
      oldPrice: deal.originalPrice != null ? _parsePrice(deal.originalPrice!) : null,
      merchantName: deal.merchant,
      category: 'Smartbag',
      stock: deal.stock,
      imageUrl: deal.imageUrl,
    );

    return ProductDetailPage(product: product);
  }

  double? _parsePrice(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) return null;
    return double.tryParse(cleaned);
  }
}
