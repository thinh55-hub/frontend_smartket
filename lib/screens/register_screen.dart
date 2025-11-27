import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';
import 'login_screen.dart';
import 'otp_verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late TapGestureRecognizer _loginTapRecognizer;

  @override
  void initState() {
    super.initState();
    _loginTapRecognizer = TapGestureRecognizer()..onTap = _navigateToLogin;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardVisible = bottomInset > 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final ScrollPhysics scrollPhysics = isKeyboardVisible
              ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
              : const NeverScrollableScrollPhysics();
          final double keyboardPadding = isKeyboardVisible ? 24 : 0;

          return Stack(
            children: [
              // Background gradient oval
              Positioned(
                left: -165,
                top: -55,
                child: Container(
                  width: 760,
                  height: 377,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.50, 0.00),
                      end: Alignment(0.50, 1.00),
                      colors: [Color(0xFF008235), Color(0xFF25EB6F)],
                    ),
                    shape: OvalBorder(),
                  ),
                ),
              ),

              // Main content
              SafeArea(
                child: SingleChildScrollView(
                  physics: scrollPhysics,
                  padding: EdgeInsets.only(bottom: keyboardPadding),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: isKeyboardVisible ? 0 : constraints.maxHeight,
                    ),
                    child: Column(
                      children: [
                        // Header section với title
                        SizedBox(
                          height: 174,
                          child: Center(
                            child: Text(
                              'Đăng ký tài khoản',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(
                                'Lexend Deca',
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                height: 0.57,
                                letterSpacing: -0.50,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    color: Color(0x40000000),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Card trắng chính
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: isKeyboardVisible ? 0 : 32,
                          ),
                          child: LayoutBuilder(
                            builder: (context, cardConstraints) {
                              final double availableHeight = cardConstraints.maxHeight;
                              final double baseHeight = availableHeight.isFinite
                                  ? availableHeight - 160
                                  : MediaQuery.of(context).size.height - 260;
                              final double targetHeight =
                                  baseHeight.clamp(420.0, double.infinity);

                              return ConstrainedBox(
                                constraints: BoxConstraints(minHeight: targetHeight),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x66000000),
                                        blurRadius: 6,
                                        offset: Offset(0, 1),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 36),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                      const SizedBox(height: 24),
                                      // Tiêu đề nhỏ
                                      Text(
                                        'Thông tin cá nhân',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                          'Lexend Deca',
                                          color: const Color(0xFF00A63E),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          height: 0.77,
                                          letterSpacing: -0.50,
                                        ),
                                      ),
                                      const SizedBox(height: 24),

                                      // Họ và tên
                                      _buildInputField(
                                        label: 'Họ và tên',
                                        controller: _fullNameController,
                                        hint: 'Nhập Họ và Tên của bạn',
                                      ),
                                      const SizedBox(height: 16),

                                      // Số điện thoại
                                      _buildInputField(
                                        label: 'Số điện thoại',
                                        controller: _phoneController,
                                        hint: 'Nhập Số điện thoại của bạn',
                                        keyboardType: TextInputType.phone,
                                      ),
                                      const SizedBox(height: 16),

                                      // Email
                                      _buildInputField(
                                        label: 'Email',
                                        controller: _emailController,
                                        hint: 'Nhập địa chỉ Email của bạn',
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                      const SizedBox(height: 16),

                                      // Đặt mật khẩu
                                      _buildInputField(
                                        label: 'Đặt mật khẩu',
                                        controller: _passwordController,
                                        hint: 'Tạo mật khẩu cho tài khoản của bạn',
                                        obscureText: true,
                                      ),
                                      const SizedBox(height: 24),

                                      // Nút Tiếp tục
                                      Container(
                                        width: 150,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment(1.00, 0.49),
                                            end: Alignment(0.00, 0.49),
                                            colors: [Color(0xFF00C950), Color(0xFF00A63E)],
                                          ),
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x7F00A63E),
                                              blurRadius: 6,
                                              offset: Offset(0, 2),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => const OtpVerificationScreen(),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: Text(
                                            'Tiếp tục',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.getFont(
                                              'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),

                                      // Điều khoản
                                      SizedBox(
                                        width: 272,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Bằng cách tiếp tục, bạn đồng ý với\n',
                                                style: GoogleFonts.getFont(
                                                  'Lexend Deca',
                                                  color: const Color(0xFF6A7282),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'Điều khoản dịch vụ',
                                                style: GoogleFonts.getFont(
                                                  'Lexend Deca',
                                                  color: const Color(0xFF00A63E),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' và ',
                                                style: GoogleFonts.getFont(
                                                  'Lexend Deca',
                                                  color: const Color(0xFF6A7282),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'Chính sách bảo mật',
                                                style: GoogleFonts.getFont(
                                                  'Lexend Deca',
                                                  color: const Color(0xFF00A63E),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Quay lại ',
                                              style: GoogleFonts.getFont(
                                                'Lexend Deca',
                                                color: const Color(0xFF8A8A8A),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                height: 1.31,
                                                letterSpacing: -0.50,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'đăng nhập',
                                              style: GoogleFonts.getFont(
                                                'Lexend Deca',
                                                color: const Color(0xFF00A63E),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                height: 1.31,
                                                letterSpacing: -0.50,
                                              ),
                                              recognizer: _loginTapRecognizer,
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Hoặc đăng nhập bằng',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                          'Lexend Deca',
                                          color: const Color(0xFF8A8A8A),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          height: 1.31,
                                          letterSpacing: -0.50,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          _buildSocialButton('assets/images/google.png',
                                              onTap: _navigateToHome),
                                          const SizedBox(width: 61),
                                          _buildSocialButton('assets/images/facebook.png',
                                              onTap: _navigateToHome),
                                        ],
                                      ),
                                      const SizedBox(height: 32),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return SizedBox(
      width: 293,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 14,
            child: Text(
              label,
              style: GoogleFonts.getFont(
                'Lexend Deca',
                color: const Color(0xFF00A63E),
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 0.94,
                letterSpacing: -0.50,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: ShapeDecoration(
              color: const Color(0xFFF7F7F7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: GoogleFonts.getFont(
                'Lexend Deca',
                fontSize: 12,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.getFont(
                  'Lexend Deca',
                  color: const Color(0xFF8A8A8A),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String iconPath, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 59,
        height: 59,
        padding: const EdgeInsets.all(11),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Image.asset(
          iconPath,
          width: 37,
          height: 37,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen(isLandscape: false)),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}
