import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../widgets/segment_chip.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: const QrContent(),
      ),
    );
  }
}

class QrContent extends StatelessWidget {
  const QrContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Mã QR của tôi',
            style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              SegmentChip('Đơn hàng', true),
              SizedBox(width: 8),
              SegmentChip('Smartbag', false),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.qr_code_2, size: 72, color: Color(0xFFB3BAC8)),
                const SizedBox(height: 16),
                Text(
                  'Chưa có mã QR nào',
                  style: GoogleFonts.lexendDeca(fontSize: 14, color: const Color(0xFF80848F)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
