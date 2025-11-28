import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend_smartket/core/localization/app_localizations.dart';
import 'package:frontend_smartket/theme/app_theme.dart';

/// A reusable rounded search pill used across screens.
///
/// - `placeholder` defaults to the Smartket copy used in Home.
/// - `onTap` can be provided to open a search page or show a dialog.
class SearchPill extends StatelessWidget {
  final String placeholder;
  final VoidCallback? onTap;

  const SearchPill({Key? key, this.placeholder = '', this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFECEFF3)),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              placeholder.isNotEmpty ? placeholder : AppLocalizations.of(context).searchPlaceholder,
              style: const TextStyle(fontSize: 13, color: Color(0xFF9AA1AF)),
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return child;

    return GestureDetector(onTap: onTap, child: child);
  }
}
