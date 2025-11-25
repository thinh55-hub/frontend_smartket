import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222325),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Column(
              children: [
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                ),
                const Divider(height: 1, thickness: 0.4),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF5F7FB),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5F9EC),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.location_on_outlined, color: Color(0xFF00C853), size: 40),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Cho phép truy cập vị trí',
                          style: GoogleFonts.lexendDeca(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'SMARTKET cần quyền truy cập vị trí để hiển thị các cửa hàng và sản phẩm gần bạn nhất',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: Color(0xFF80848F)),
                        ),
                        const SizedBox(height: 24),
                        const _BenefitItem(text: 'Tìm deals và smartbags gần bạn'),
                        const SizedBox(height: 8),
                        const _BenefitItem(text: 'Tính khoảng cách chính xác đến cửa hàng'),
                        const SizedBox(height: 8),
                        const _BenefitItem(text: 'Nhận thông báo về ưu đãi trong khu vực'),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xFF00C853),
                              borderRadius: BorderRadius.circular(16),
                            ),
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'Cho phép',
                                  style: GoogleFonts.lexendDeca(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE0E4EE)),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Chọn vị trí thủ công',
                            style: GoogleFonts.lexendDeca(fontSize: 14, color: const Color(0xFF3C404B)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Bạn có thể thay đổi cài đặt này bất kỳ lúc nào trong phần cài đặt',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11, color: Color(0xFF80848F)),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E4EE)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF00C853), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Color(0xFF3C404B)),
            ),
          ),
        ],
      ),
    );
  }
}
