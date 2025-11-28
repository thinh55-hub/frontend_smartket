import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/forms/primary_button.dart';
import '../core/state/navigation_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/layout/bottom_nav.dart';
import 'cart_screen.dart';

class FavoriteStoresScreen extends StatelessWidget {
  const FavoriteStoresScreen({super.key});

  void _goToExplore(BuildContext context) {
    final nav = context.read<NavigationProvider>();
    nav.current = MainTab.explore;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                'Favorite Stores',
                style: GoogleFonts.lexendDeca(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 144,
                      height: 144,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F7FB),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: Color(0xFFCFD4E0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No favorite stores yet',
                      style: GoogleFonts.lexendDeca(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Save stores to access deals faster',
                      style: GoogleFonts.lexendDeca(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 180,
                      child: PrimaryButton(
                        label: 'Explore stores',
                        filled: false,
                        onPressed: () => _goToExplore(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomNav(
          current: nav.current,
          onChanged: (tab) {
            if (tab == MainTab.cart) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
              return;
            }
            nav.current = tab;
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
    );
  }
}
