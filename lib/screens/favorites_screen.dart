import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class FavoriteStore {
  final String name;
  final String description;
  final String joinedSince;
  final String location;

  const FavoriteStore({
    required this.name,
    required this.description,
    required this.joinedSince,
    required this.location,
  });
}

const List<FavoriteStore> _mockFavoriteStores = [
  FavoriteStore(
    name: 'Green Valley Mart',
    description: 'Local grocery focusing on fresh, seasonal and surplus products from nearby farms.',
    joinedSince: 'Joined Smartket since Feb 2023',
    location: '2.1 km • District 3',
  ),
  FavoriteStore(
    name: 'Sunrise Bakery',
    description: 'Artisan bakery rescuing end-of-day breads, pastries and desserts.',
    joinedSince: 'Joined Smartket since Nov 2022',
    location: '850 m • District 1',
  ),
  FavoriteStore(
    name: 'Fresh & Co. Market',
    description: 'Convenience market offering surprise bags of fruits, veggies and ready-to-eat meals.',
    joinedSince: 'Joined Smartket since May 2024',
    location: '3.4 km • District 7',
  ),
];

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
              child: _mockFavoriteStores.isEmpty
                  ? Center(
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
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: _mockFavoriteStores.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final store = _mockFavoriteStores[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                            boxShadow: AppShadows.light,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE9F9F0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.storefront_rounded, color: AppColors.primary),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          store.name,
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          store.description,
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: 13,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.favorite_rounded, color: AppColors.primary),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.schedule, size: 16, color: AppColors.textSecondary),
                                  const SizedBox(width: 6),
                                  Text(
                                    store.joinedSince,
                                    style: GoogleFonts.lexendDeca(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      store.location,
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
