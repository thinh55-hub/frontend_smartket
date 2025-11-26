import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: const CartContent(),
      ),
    );
  }
}

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Icon(Icons.shopping_bag_outlined, size: 56, color: Color(0xFFB3BAC8)),
        const SizedBox(height: 12),
        Text(
          'Giỏ hàng của bạn đang trống',
          style: GoogleFonts.lexendDeca(fontSize: 14, color: const Color(0xFF80848F)),
        ),
      ],
    );
  }
}
