import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

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
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5F9EC),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.shield_outlined, color: Color(0xFF00C853), size: 40),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Xác minh OTP',
                          style: GoogleFonts.lexendDeca(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mã xác minh đã được gửi đến',
                          style: GoogleFonts.lexendDeca(fontSize: 13, color: const Color(0xFF80848F)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '0905175313',
                          style: GoogleFonts.lexendDeca(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            final bool isFirst = index == 0;
                            return Container(
                              width: 40,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isFirst ? const Color(0xFF00C853) : const Color(0xFFE0E4EE),
                                  width: isFirst ? 2 : 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                isFirst ? '1' : '',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Gửi lại mã sau 57s',
                          style: GoogleFonts.lexendDeca(fontSize: 13, color: const Color(0xFF80848F)),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3E7F0),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Xác nhận',
                            style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFFB3BAC8)),
                          ),
                        ),
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
