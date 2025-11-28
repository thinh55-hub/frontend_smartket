import 'package:flutter/material.dart';
import 'colors.dart';

class AppColors {
  // Using the new teal primary color as requested.
  static const Color primary = kPrimaryTeal;
  static const Color primaryAlt = kPrimaryGreenAlt;
  static const Color background = Color(0xFFF5F7FB);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE0E4EE);
  static const List<Color> primaryGradient = kPrimaryGradient;
  static const LinearGradient primaryGradientLinear = LinearGradient(
    colors: kPrimaryGradient,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Color textPrimary = Color(0xFF3C404B);
  static const Color textSecondary = Color(0xFF80848F);
  static const Color disabled = Color(0xFFE8E8E8);
  static const Color navInactive = Color(0xFF9A9A9A);
  // Discount badge colors (Figma alignment)
  static const Color discountPink = Color(0xFFFFE2E2);
  static const Color discountRed = Color(0xFFE7000B);
  // Home hero / promo palette pulled from Figma
  static const Color heroGradientStart = Color(0xFF5BE186);
  static const Color heroGradientMid = Color(0xFF1FC76E);
  static const Color heroGradientFade = Color(0x001CC76B);
  static const Color promoCardBorder = Color(0xFF33CF78);
  static const Color promoCardGlow = Color(0x1900A86B);
  static const Color promoCardBackground = Color(0xFFF3FFF7);
  static const Color salePrice = Color(0xFFEA1C2D);
}

class AppRadius {
  static const Radius r24 = Radius.circular(24);
  static const Radius r20 = Radius.circular(20);
  static const Radius r16 = Radius.circular(16);
  static const Radius r12 = Radius.circular(12);
}

class AppShadows {
  static const List<BoxShadow> light = [
    BoxShadow(
      color: Color(0x10000000),
      blurRadius: 6,
      spreadRadius: 1,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> elevated = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 10,
      spreadRadius: 2,
      offset: Offset(0, 4),
    ),
  ];
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    fontFamily: 'SF Pro Display',
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        color: AppColors.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: AppColors.textSecondary,
      ),
    ),
  );
}
