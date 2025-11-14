import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'payment_sheet.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ElevatedButton(
          onPressed: () => PaymentSheet.show(context),
          child: const Text('Open Payment Methods'),
        ),
      ),
    );
  }
}
