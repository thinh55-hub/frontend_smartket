import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../widgets/segment_chip.dart';
import '../widgets/smartket_header_bar.dart';

class _MockQrOrder {
  final String storeName;
  final String orderId;
  final String pickupTime;
  final String address;
  final String bagSummary;

  const _MockQrOrder({
    required this.storeName,
    required this.orderId,
    required this.pickupTime,
    required this.address,
    required this.bagSummary,
  });
}

const _mockQrOrder = _MockQrOrder(
  storeName: 'Green Valley Mart',
  orderId: '#SMK-48219',
  pickupTime: 'Pickup today • 18:00 - 19:00',
  address: '123 Nguyen Trai, District 1',
  bagSummary: '1x Surprise smartbag • Mixed bakery & groceries',
);

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: SmartketHeaderBar(
                logoHeight: 40,
              ),
            ),
          ),
          const Expanded(
            child: QrContent(),
          ),
        ],
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
                Container(
                  width: 220,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppShadows.light,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _mockQrOrder.storeName,
                        style: GoogleFonts.lexendDeca(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _mockQrOrder.bagSummary,
                        style: GoogleFonts.lexendDeca(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _mockQrOrder.pickupTime,
                        style: GoogleFonts.lexendDeca(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _mockQrOrder.address,
                        style: GoogleFonts.lexendDeca(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _mockQrOrder.orderId,
                        style: GoogleFonts.lexendDeca(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Icon(Icons.qr_code_2, size: 120, color: Color(0xFF0F9D58)),
                const SizedBox(height: 12),
                Text(
                  'Đưa mã QR này cho cửa hàng để quét',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexendDeca(fontSize: 13, color: const Color(0xFF80848F)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
