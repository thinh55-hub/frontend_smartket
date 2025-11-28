import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchBarInput extends StatelessWidget {
  final String placeholder;
  final VoidCallback? onFilter;
  const SearchBarInput({super.key, required this.placeholder, this.onFilter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Row(children: [
        const Icon(Icons.search, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(child: Text(placeholder, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
      ]),
    );
  }
}
