import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 24, offset: Offset(0, 12))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.lexendDeca(fontSize: 9, color: AppColors.textSecondary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.lexendDeca(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primary),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.lexendDeca(fontSize: 8, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
