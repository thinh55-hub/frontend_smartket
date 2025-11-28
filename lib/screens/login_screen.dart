import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import các màn hình khác (giữ nguyên cấu trúc của bạn)
import 'home_screen.dart';
import 'register_screen.dart';

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
    // Lấy kích thước màn hình
    final size = MediaQuery.sizeOf(context);
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    
    // Lấy chiều cao bàn phím để xử lý padding
    final double viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;
    final bool keyboardVisible = viewInsetsBottom > 0;

    // Logic xác định màn hình nhỏ (iPhone SE, Android cũ)
    final bool isSmallDevice = screenHeight < 700;
    // Scale logo nhỏ lại chút nếu màn hình bé
    final double scale = isSmallDevice ? 0.8 : 1.0; 

    return Scaffold(
      backgroundColor: Colors.white,
      // Tắt resize để tránh background bị co lại xấu, ta sẽ tự handle scroll
      resizeToAvoidBottomInset: false, 
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              // Đẩy nội dung lên khi có bàn phím
              padding: EdgeInsets.only(bottom: viewInsetsBottom + 20),
              physics: keyboardVisible ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                // Đảm bảo chiều cao tối thiểu bằng màn hình để căn giữa đẹp
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    // Padding ngang linh hoạt, không để quá sát lề
                    horizontal: (screenWidth > 400) ? 48 : 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
                    children: [
                      // Khoảng trống linh hoạt thay vì fix cứng
                      SizedBox(height: isSmallDevice ? 20 : 40),

                      // Logo
                      Container(
                        width: 157 * scale,
                        height: 157 * scale,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: isSmallDevice ? 20 : 30),

                      // Tên App
                      Container(
                        width: 196 * scale, // Scale cả tên app cho cân đối
                        height: 27 * scale,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/app_name.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      SizedBox(height: isSmallDevice ? 40 : 60),

                      // --- FORM NHẬP LIỆU ---
                      
                      // Số điện thoại
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Số điện thoại',
                          style: GoogleFonts.lexendDeca(
                            color: const Color(0xFF00A63E),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 45, // Tăng nhẹ height để dễ bấm hơn trên mobile
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: GoogleFonts.lexendDeca(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'Nhập số điện thoại',
                            hintStyle: GoogleFonts.lexendDeca(color: const Color(0xFF8A8A8A), fontSize: 12, fontWeight: FontWeight.w300),
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 19, vertical: 0), // Vertical 0 để text tự căn giữa height 45
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Mật khẩu
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mật khẩu',
                          style: GoogleFonts.lexendDeca(
                            color: const Color(0xFF00A63E),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: GoogleFonts.lexendDeca(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'Nhập mật khẩu',
                            hintStyle: GoogleFonts.lexendDeca(color: const Color(0xFF8A8A8A), fontSize: 12, fontWeight: FontWeight.w300),
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 19, vertical: 0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, size: 20, color: const Color(0xFF8A8A8A)),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                        ),
                      ),

                      // Quên mật khẩu
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 30), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          child: Text('Quên mật khẩu?', style: GoogleFonts.lexendDeca(color: const Color(0xFF00A63E), fontSize: 13, fontWeight: FontWeight.w300)),
                        ),
                      ),

                      SizedBox(height: isSmallDevice ? 20 : 30),

                      // Nút Đăng nhập
                      Container(
                        width: double.infinity,
                        height: 48, // Chuẩn height nút bấm mobile
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF00A63E), Color(0xFF00C950)]),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [BoxShadow(color: Color(0x8400A63E), blurRadius: 6, offset: Offset(0, 3))],
                        ),
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen(isLandscape: false))),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, 
                            shadowColor: Colors.transparent, 
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                          ),
                          child: Text('Đăng nhập', style: GoogleFonts.lexendDeca(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Đăng ký
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Chưa có tài khoản? ', style: GoogleFonts.lexendDeca(fontSize: 13, fontWeight: FontWeight.w300)),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterScreen())),
                            child: Text('Tạo tài khoản', style: GoogleFonts.lexendDeca(color: const Color(0xFF00A63E), fontSize: 13, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),

                      SizedBox(height: isSmallDevice ? 30 : 40),

                      // Divider Hoặc
                      Row(children: const [
                        Expanded(child: Divider(color: Color(0xFFE0E0E0))), 
                        Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Hoặc đăng nhập bằng', style: TextStyle(color: Color(0xFF8A8A8A), fontSize: 13))), 
                        Expanded(child: Divider(color: Color(0xFFE0E0E0)))
                      ]),

                      SizedBox(height: isSmallDevice ? 20 : 28),

                      // Social Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialButton('assets/images/google.png'),
                          const SizedBox(width: 40),
                          _socialButton('assets/images/facebook.png'),
                        ],
                      ),
                      
                      // Padding bottom an toàn
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _socialButton(String assetPath) {
    return Container(
      width: 50, // Size chuẩn icon
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(10), 
        boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 1))]
      ),
      child: Image.asset(assetPath, width: 30, height: 30, fit: BoxFit.contain),
    );
  }
}
