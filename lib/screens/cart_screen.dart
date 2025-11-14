import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.shopping_bag_outlined, size: 56, color: AppColors.textSecondary),
              SizedBox(height: 12),
              Text('Giỏ hàng của bạn đang trống', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}

