import 'package:flutter/material.dart';

import 'circle_icon_button.dart';
import 'smartket_logo.dart';
import '../screens/favorite_stores_screen.dart';
import '../screens/profile_screen.dart';

/// Brand header row used on the Home and detail screens.
class SmartketHeaderBar extends StatelessWidget {
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onProfileTap;
  final double logoHeight;

  const SmartketHeaderBar({
    super.key,
    this.onFavoriteTap,
    this.onProfileTap,
    this.logoHeight = 66,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmartketLogo(height: logoHeight, padding: const EdgeInsets.only(top: 4)),
        const Spacer(),
        CircleIconButton(
          icon: Icons.favorite_border,
          onPressed: onFavoriteTap ??
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const FavoriteStoresScreen()),
                );
              },
        ),
        const SizedBox(width: 10),
        CircleIconButton(
          icon: Icons.person_outline,
          onPressed: onProfileTap ??
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
        ),
      ],
    );
  }
}
