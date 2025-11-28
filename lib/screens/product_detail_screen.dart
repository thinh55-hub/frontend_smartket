import 'package:flutter/material.dart';

import '../components/product_detail_page.dart';
import '../core/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ProductDetailPage(product: product);
  }
}
