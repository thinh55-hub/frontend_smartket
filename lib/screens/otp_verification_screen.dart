import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Column(
        children: [
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          Expanded(
            child: Padding(
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
                    margin: const EdgeInsets.only(bottom: 32),
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
    );
  }
}
