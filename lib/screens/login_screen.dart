import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Để dùng GoogleFonts hoặc tự add Lexend Deca

// Nếu chưa có GoogleFonts, chạy: flutter pub add google_fonts
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy chiều rộng màn hình để responsive (Figma design là 390-428px)
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: (screenWidth - 390).clamp(0, 48), // Tối đa 48px mỗi bên như Figma
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 76),

              // Logo (thay bằng logo thật của bạn)
              Container(
                width: 157,
                height: 157,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'), // hoặc NetworkImage
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 41), // 214 - 173 = 41

              // Tên app (thay bằng text hoặc asset thật)
              Container(
                width: 196,
                height: 27,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/app_name.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 90),

              // ====================== SỐ ĐIỆN THOẠI ======================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Số điện thoại',
                  style: GoogleFonts.getFont(
                    'Lexend Deca',
                    color: const Color(0xFF00A63E),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 0.94,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 40,
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.getFont(
                    'Lexend Deca',
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nhập số điện thoại',
                    hintStyle: GoogleFonts.getFont(
                      'Lexend Deca',
                      color: const Color(0xFF8A8A8A),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F7F7),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // ====================== MẬT KHẨU ======================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mật khẩu',
                  style: GoogleFonts.getFont(
                    'Lexend Deca',
                    color: const Color(0xFF00A63E),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 0.94,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 40,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: GoogleFonts.getFont(
                    'Lexend Deca',
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nhập mật khẩu',
                    hintStyle: GoogleFonts.getFont(
                      'Lexend Deca',
                      color: const Color(0xFF8A8A8A),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F7F7),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                        color: const Color(0xFF8A8A8A),
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 11),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Quên mật khẩu?',
                    style: GoogleFonts.getFont(
                      'Lexend Deca',
                      color: const Color(0xFF00A63E),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      height: 1.31,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 34),

              // ====================== NÚT ĐĂNG NHẬP ======================
              Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF00A63E), Color(0xFF00C950)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x8400A63E),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Đăng nhập',
                    style: GoogleFonts.getFont(
                      'Lexend Deca',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 0.85,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 21),

              // Chưa có tài khoản?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chưa có tài khoản?',
                    style: GoogleFonts.getFont(
                      'Lexend Deca',
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      height: 1.31,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Tạo tài khoản',
                      style: GoogleFonts.getFont(
                        'Lexend Deca',
                        color: const Color(0xFF00A63E),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        height: 1.31,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // Divider + text
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Hoặc đăng nhập bằng',
                      style: GoogleFonts.getFont(
                        'Lexend Deca',
                        color: const Color(0xFF8A8A8A),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 1.31,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                ],
              ),

              const SizedBox(height: 28),

              // Social buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google (hoặc Facebook/Apple tùy bạn)
                  _socialButton('assets/images/google.png'), // thay icon thật
                  const SizedBox(width: 60),
                  _socialButton('assets/images/facebook.png'),
                ],
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String assetPath) {
    return Container(
      width: 59,
      height: 59,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Image.asset(assetPath, width: 37, height: 37),
    );
  }
}