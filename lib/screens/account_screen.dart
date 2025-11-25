import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222325),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                        children: [
                          const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                          const SizedBox(width: 12),
                          Text(
                            'Hồ sơ của tôi',
                            style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, thickness: 0.4),
                    Expanded(
                      child: Container(
                        color: const Color(0xFFF5F7FB),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text('Tài khoản', style: GoogleFonts.lexendDeca(fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            _AccountItem(
                              icon: Icons.person_outline,
                              title: 'Thông tin tài khoản',
                              subtitle: 'tungf',
                            ),
                            const SizedBox(height: 10),
                            _AccountItem(
                              icon: Icons.receipt_long_outlined,
                              title: 'Lịch sử đơn hàng',
                            ),
                            const SizedBox(height: 16),
                            Text('Thanh toán', style: GoogleFonts.lexendDeca(fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            _AccountItem(
                              icon: Icons.credit_card_outlined,
                              title: 'Phương thức thanh toán',
                              subtitle: 'Quản lý MoMo / Ngân hàng / Apple Pay',
                              onTap: () => _showPaymentSheet(context),
                            ),
                            const SizedBox(height: 16),
                            Text('Cài đặt', style: GoogleFonts.lexendDeca(fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            _AccountItem(
                              icon: Icons.notifications_none,
                              title: 'Thông báo',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void _showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E4EE),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Payment Methods',
                  style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
              const _PaymentItem(
                icon: Icons.phone_android,
                title: 'MoMo',
                subtitle: '0987 *** *** 123',
              ),
              const SizedBox(height: 8),
              const _PaymentItem(
                icon: Icons.account_balance,
                title: 'Bank Transfer',
                subtitle: '**** **** **** 4567',
              ),
              const SizedBox(height: 8),
              const _PaymentItem(
                icon: Icons.apple,
                title: 'Apple Pay',
                subtitle: 'nguyenvana@icloud.com',
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C853),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                      style: GoogleFonts.lexendDeca(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AccountItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const _AccountItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF3C404B)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF80848F)),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFFB3BAC8)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PaymentItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: const Color(0xFF3C404B)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF80848F)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

