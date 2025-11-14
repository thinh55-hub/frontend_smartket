import 'package:flutter/material.dart';
import '../components/app_top_bar.dart';
import '../theme/app_theme.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'Thông tin cá nhân'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hoàn tất thông tin để bắt đầu sử dụng SMARTKET',
                      style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 24),
                    const _Label('Họ và tên'),
                    const SizedBox(height: 8),
                    const _InputField(
                      icon: Icons.person_outline,
                      hint: 'Nguyễn Đức Thịnh',
                    ),
                    const SizedBox(height: 16),
                    const _Label('Ngày sinh'),
                    const SizedBox(height: 8),
                    const _InputField(
                      icon: Icons.calendar_today_outlined,
                      hint: 'mm/dd/yyyy',
                    ),
                    const SizedBox(height: 16),
                    const _Label('Email'),
                    const SizedBox(height: 8),
                    const _InputField(
                      icon: Icons.email_outlined,
                      hint: 'email@example.com',
                    ),
                    const SizedBox(height: 16),
                    const _Label('Địa chỉ'),
                    const SizedBox(height: 8),
                    const _InputField(
                      icon: Icons.location_on_outlined,
                      hint: '123 Đường ABC, Quận 1, TP.HCM',
                      maxLines: 2,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.disabled,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'Hoàn tất',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
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

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final int maxLines;

  const _InputField({
    required this.icon,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              hint,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
