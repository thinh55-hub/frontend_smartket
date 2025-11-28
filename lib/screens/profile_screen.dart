import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/forms/info_section.dart';
import '../widgets/layout/logout_dialog.dart';
import '../widgets/forms/primary_button.dart';
import '../widgets/layout/bottom_nav.dart';
import '../core/state/navigation_provider.dart';
import '../core/state/locale_provider.dart';
import '../core/localization/app_localizations.dart';
import '../theme/app_theme.dart';
import 'cart_screen.dart';
import 'payment_sheet.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    final strings = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textPrimary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    strings.profileTitle,
                    style: GoogleFonts.lexendDeca(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InfoSection(
                heading: strings.accountSection,
                items: [
                  InfoSectionItem(
                    icon: Icons.person_outline,
                    title: strings.accountInfoTitle,
                    subtitle: strings.accountInfoSubtitle,
                  ),
                  InfoSectionItem(
                    icon: Icons.qr_code_2_outlined,
                    title: strings.orderHistoryTitle,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InfoSection(
                heading: strings.paymentSection,
                items: [
                  InfoSectionItem(
                    icon: Icons.credit_card_outlined,
                    title: strings.paymentMethodsTitle,
                    subtitle: strings.paymentMethodsSubtitle,
                    onTap: () => PaymentSheet.show(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InfoSection(
                heading: strings.settingsSection,
                items: [
                  InfoSectionItem(
                    icon: Icons.notifications_none,
                    title: strings.notificationsTitle,
                  ),
                  InfoSectionItem(
                    icon: Icons.language_outlined,
                    title: strings.languageTitle,
                    subtitle: strings.languageSubtitle,
                    onTap: () => localeProvider.toggleLocale(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InfoSection(
                heading: strings.supportSection,
                items: [
                  InfoSectionItem(
                    icon: Icons.help_outline,
                    title: strings.helpTitle,
                    subtitle: strings.helpSubtitle,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFE3E6EF),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: strings.logoutLabel,
                filled: false,
                onPressed: () async {
                  final result = await LogoutDialog.show(context);
                  if (result == true) {
                    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                      '/login',
                      (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
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
