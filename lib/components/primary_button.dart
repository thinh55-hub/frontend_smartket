import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool filled;

  const PrimaryButton({super.key, required this.label, this.onPressed, this.filled = true});

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    final bg = filled
        ? (disabled ? AppColors.disabled : AppColors.primary)
        : Colors.white;
    final fg = filled
        ? (disabled ? AppColors.textSecondary : Colors.white)
        : AppColors.textPrimary;

    return SizedBox(
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: filled ? null : Border.all(color: AppColors.border),
          boxShadow: filled ? AppShadows.light : null,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: disabled ? null : onPressed,
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: fg),
            ),
          ),
        ),
      ),
    );
  }
}

