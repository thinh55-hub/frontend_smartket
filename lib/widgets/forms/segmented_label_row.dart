import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class SegmentedLabelRow extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const SegmentedLabelRow({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        labels.length,
        (index) => Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => onSelected(index),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.lexendDeca(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: selectedIndex == index ? Colors.white : AppColors.primary,
                ),
                child: Text(labels[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
