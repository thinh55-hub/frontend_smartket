import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/info_section.dart';
import '../components/logout_dialog.dart';
import '../components/primary_button.dart';
import '../core/state/navigation_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import 'cart_screen.dart';
import 'payment_sheet.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();

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
                    'Hồ sơ cá nhân',
                    style: GoogleFonts.lexendDeca(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const InfoSection(
                heading: 'Tài khoản',
                items: [
                  InfoSectionItem(
                    icon: Icons.person_outline,
                    title: 'Account Info',
                    subtitle: 'Nguyễn Văn A • nguyenvana@email.com',
                  ),
                  InfoSectionItem(
                    icon: Icons.qr_code_2_outlined,
                    title: 'Lịch sử đơn hàng',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InfoSection(
                heading: 'Thanh toán',
                items: [
                  InfoSectionItem(
                    icon: Icons.credit_card_outlined,
                    title: 'Payment Methods',
                    subtitle: 'Manage MoMo / Bank / Apple Pay',
                    onTap: () => PaymentSheet.show(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const InfoSection(
                heading: 'Cài đặt',
                items: [
                  InfoSectionItem(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                  ),
                  InfoSectionItem(
                    icon: Icons.language_outlined,
                    title: 'Language',
                    subtitle: 'English',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const InfoSection(
                heading: 'Hỗ trợ',
                items: [
                  InfoSectionItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'FAQ / Contact',
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
                label: 'Đăng xuất',
                filled: false,
                onPressed: () {
                  LogoutDialog.show(context);
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
