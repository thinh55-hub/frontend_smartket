import 'package:flutter/material.dart';

import 'package:frontend_smartket/theme/app_theme.dart';

class LocationPill extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const LocationPill({super.key, this.label = 'Quận 1, TP.HCM • 5 km', this.onTap});

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFECEFF3)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, size: 18, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textPrimary),
        ],
      ),
    );

    if (onTap == null) return content;
    return GestureDetector(onTap: onTap, child: content);
  }
}
