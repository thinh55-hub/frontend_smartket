import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/forms/primary_button.dart';

class PaymentSheet {
  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: AppShadows.elevated,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(width: 36, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 12),
                  const Text('Phương thức thanh toán', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  const Divider(height: 1, color: AppColors.border),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      children: const [
                        _MethodTile(icon: Icons.account_balance_wallet_outlined, title: 'MoMo', subtitle: 'Liên kết ví MoMo'),
                        SizedBox(height: 8),
                        _MethodTile(icon: Icons.credit_card_outlined, title: 'Ngân hàng Vietcombank', subtitle: '**** 1234'),
                        SizedBox(height: 8),
                        _MethodTile(icon: Icons.credit_card_outlined, title: 'Ngân hàng Techcombank', subtitle: '**** 5678'),
                        SizedBox(height: 8),
                        _MethodTile(icon: Icons.phone_iphone_outlined, title: 'Apple Pay'),
                        SizedBox(height: 8),
                        _MethodTile(icon: Icons.add_card_outlined, title: 'Thêm thẻ mới'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      children: [
                        Expanded(child: PrimaryButton(label: 'Hủy', filled: false, onPressed: () => Navigator.of(context).pop())),
                        const SizedBox(width: 12),
                        Expanded(child: PrimaryButton(label: 'Xong', onPressed: () => Navigator.of(context).pop())),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _MethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _MethodTile({required this.icon, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.light,
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: AppColors.textPrimary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
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
    );
  }
}
