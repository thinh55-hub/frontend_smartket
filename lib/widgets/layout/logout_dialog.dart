import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_smartket/theme/app_theme.dart';
import '../../core/localization/app_localizations.dart';

class LogoutDialog {
  static Future<bool?> show(BuildContext context) {
    // Show the dialog using the nearest navigator so it inherits the
    // surrounding localization and theme.
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      useRootNavigator: false,
      builder: (ctx) => const _LogoutDialog(),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Color(0x26000000), blurRadius: 20, offset: Offset(0, 10)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context).logoutDialogTitle,
              style: GoogleFonts.lexendDeca(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).logoutDialogMessage,
              style: GoogleFonts.lexendDeca(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: _DialogButton(
                    label: AppLocalizations.of(context).logoutCancelLabel,
                    textColor: AppColors.textPrimary,
                    background: const Color(0xFFF3F4F6),
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: _DialogButton(
                    label: AppLocalizations.of(context).logoutLabel,
                    textColor: Colors.white,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF3B30), Color(0xFFE50914)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color? background;
  final Gradient? gradient;
  final VoidCallback onTap;

  const _DialogButton({
    required this.label,
    required this.textColor,
    required this.onTap,
    this.background,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: gradient == null ? background : null,
          gradient: gradient,
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.lexendDeca(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
