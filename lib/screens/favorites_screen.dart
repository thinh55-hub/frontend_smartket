import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textPrimary),
                  const SizedBox(width: 12),
                  Text('Favorites', style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: const Color(0xFFE7EAF2),
                      child: const Icon(Icons.favorite_border, size: 40, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 24),
                    Text('No favorite stores yet', style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Text(
                      'Start adding stores to your favorites to see them here',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexendDeca(fontSize: 13, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 160,
                      height: 44,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppColors.border),
                          boxShadow: AppShadows.light,
                        ),
                        child: Center(
                          child: Text('Browse Stores', style: GoogleFonts.lexendDeca(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
