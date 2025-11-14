import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/primary_button.dart';
import 'payment_sheet.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textPrimary),
                  SizedBox(width: 8),
                  Text('Hồ sơ của tôi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                ],
              ),
              const SizedBox(height: 16),
              const _GroupTitle('Tài khoản'),
              const SizedBox(height: 8),
              const _RowItem(icon: Icons.person_outline, title: 'Thông tin tài khoản', subtitle: 'tungf'),
              const SizedBox(height: 10),
              const _RowItem(icon: Icons.receipt_long_outlined, title: 'Lịch sử đơn hàng'),
              const SizedBox(height: 16),
              const _GroupTitle('Thanh toán'),
              const SizedBox(height: 8),
              _RowItem(
                icon: Icons.credit_card_outlined,
                title: 'Phương thức thanh toán',
                subtitle: 'Quản lý MoMo / Ngân hàng / Apple Pay',
                onTap: () => PaymentSheet.show(context),
              ),
              const SizedBox(height: 16),
              const _GroupTitle('Cài đặt'),
              const SizedBox(height: 8),
              const _RowItem(icon: Icons.notifications_none, title: 'Thông báo'),
              const _RowItem(icon: Icons.language_outlined, title: 'Ngôn ngữ'),
              const SizedBox(height: 16),
              const _GroupTitle('Hỗ trợ'),
              const SizedBox(height: 8),
              const _RowItem(icon: Icons.help_outline, title: 'FAQ – Liên hệ'),
              const SizedBox(height: 16),
              const _GroupTitle('Phiên làm việc'),
              const SizedBox(height: 8),
              PrimaryButton(label: 'Đăng xuất', onPressed: () {}, filled: false),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupTitle extends StatelessWidget {
  final String title;
  const _GroupTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary));
  }
}

class _RowItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  const _RowItem({required this.icon, required this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.textPrimary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
