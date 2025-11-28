import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';

// Import giả lập các màn hình khác
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
    final size = MediaQuery.sizeOf(context);
    final double screenHeight = size.height;
    final double paddingBottom = MediaQuery.of(context).viewInsets.bottom;
    
    // Xác định thiết bị nhỏ để điều chỉnh UI
    final bool isSmallDevice = screenHeight < 700; 

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      // Tắt tự động resize để tránh lỗi giật layout khi bàn phím hiện
      resizeToAvoidBottomInset: false, 
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            // --- 1. Background Xanh (Giữ nguyên) ---
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

            // --- 2. Nội dung chính (Scrollable & Responsive) ---
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    // Đẩy nội dung lên khi bàn phím hiện (thủ công)
                    padding: EdgeInsets.only(bottom: paddingBottom + 20),
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      // Đảm bảo container ít nhất cao bằng màn hình để căn giữa
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        // Căn giữa nội dung theo chiều dọc nếu màn hình đủ lớn
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: [
                          
                          // Header Title
                          SizedBox(height: isSmallDevice ? 40 : 60), // Khoảng cách linh hoạt
                          Text(
                            'Đăng ký tài khoản',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lexendDeca(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              letterSpacing: -0.50,
                              shadows: const [
                                Shadow(offset: Offset(0, 2), blurRadius: 4, color: Color(0x40000000)),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 30),

                          // --- CARD FORM CHÍNH ---
                          // Không dùng Expanded ở đây để tránh lỗi RenderFlex
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: isSmallDevice ? 16 : 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(color: Color(0x66000000), blurRadius: 6, offset: Offset(0, 1)),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallDevice ? 20 : 36,
                              vertical: 24,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Ôm sát nội dung
                              children: [
                                Text(
                                  'Thông tin cá nhân',
                                  style: GoogleFonts.lexendDeca(
                                    color: const Color(0xFF00A63E),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Các trường nhập liệu
                                _buildInputField(label: 'Họ và tên', controller: _fullNameController, hint: 'Nhập Họ và Tên của bạn'),
                                const SizedBox(height: 16),
                                _buildInputField(label: 'Số điện thoại', controller: _phoneController, hint: 'Nhập Số điện thoại', keyboardType: TextInputType.phone),
                                const SizedBox(height: 16),
                                _buildInputField(label: 'Email', controller: _emailController, hint: 'Nhập địa chỉ Email', keyboardType: TextInputType.emailAddress),
                                const SizedBox(height: 16),
                                _buildInputField(label: 'Đặt mật khẩu', controller: _passwordController, hint: 'Tạo mật khẩu', obscureText: true),
                                const SizedBox(height: 24),

                                // Button Tiếp tục
                                SizedBox(
                                  width: 150,
                                  height: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [Color(0xFF00C950), Color(0xFF00A63E)]),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [BoxShadow(color: Color(0x7F00A63E), blurRadius: 6, offset: Offset(0, 2))],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OtpVerificationScreen())),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      ),
                                      child: Text('Tiếp tục', style: GoogleFonts.lexendDeca(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300)),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),
                                _buildTermsAndLogin(),
                                const SizedBox(height: 20),

                                Text('Hoặc đăng nhập bằng', style: GoogleFonts.lexendDeca(color: const Color(0xFF8A8A8A), fontSize: 13)),
                                const SizedBox(height: 16),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildSocialButton('assets/images/google.png', onTap: _navigateToHome),
                                    const SizedBox(width: 40),
                                    _buildSocialButton('assets/images/facebook.png', onTap: _navigateToHome),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Spacer ảo dưới cùng để scroll đẹp hơn
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.lexendDeca(color: const Color(0xFF00A63E), fontSize: 16, fontWeight: FontWeight.w400)), // Giảm font size header chút cho gọn
        const SizedBox(height: 8),
        Container(
          height: 40, // Tăng nhẹ height để dễ bấm hơn
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: ShapeDecoration(color: const Color(0xFFF7F7F7), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
          child: Center(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: GoogleFonts.lexendDeca(fontSize: 14, color: Colors.black87),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.lexendDeca(color: const Color(0xFF8A8A8A), fontSize: 12, fontWeight: FontWeight.w300),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndLogin() {
    return Column(
      children: [
        SizedBox(
          width: 280,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Bằng cách tiếp tục, bạn đồng ý với\n', style: GoogleFonts.lexendDeca(color: const Color(0xFF6A7282), fontSize: 11, fontWeight: FontWeight.w300)),
                TextSpan(text: 'Điều khoản dịch vụ', style: GoogleFonts.lexendDeca(color: const Color(0xFF00A63E), fontSize: 11, fontWeight: FontWeight.w700)),
                TextSpan(text: ' và ', style: GoogleFonts.lexendDeca(color: const Color(0xFF6A7282), fontSize: 11, fontWeight: FontWeight.w300)),
                TextSpan(text: 'Chính sách bảo mật', style: GoogleFonts.lexendDeca(color: const Color(0xFF00A63E), fontSize: 11, fontWeight: FontWeight.w700)),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Quay lại ', style: GoogleFonts.lexendDeca(color: const Color(0xFF8A8A8A), fontSize: 13)),
              TextSpan(text: 'đăng nhập', style: GoogleFonts.lexendDeca(color: const Color(0xFF00A63E), fontSize: 13, fontWeight: FontWeight.bold), recognizer: _loginTapRecognizer),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSocialButton(String iconPath, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 50, // Thu nhỏ nút chút cho cân đối
        height: 50,
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadows: const [BoxShadow(color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 1))],
        ),
        child: Image.asset(iconPath, fit: BoxFit.contain),
      ),
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen(isLandscape: false)));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}