import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import 'info_pill.dart';

class InfoSectionItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const InfoSectionItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });
}

class InfoSection extends StatelessWidget {
  final String heading;
  final List<InfoSectionItem> items;

  const InfoSection({
    super.key,
    required this.heading,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.lexendDeca(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            for (int i = 0; i < items.length; i++) ...[
              InfoPill(
                leadingIcon: items[i].icon,
                title: items[i].title,
                subtitle: items[i].subtitle ?? '',
                onTap: items[i].onTap,
              ),
              if (i != items.length - 1) const SizedBox(height: 8),
            ],
          ],
        ),
      ],
    );
  }
}

