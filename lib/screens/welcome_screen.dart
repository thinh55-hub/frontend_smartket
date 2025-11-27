// lib/screens/welcome_page1.dart (hoặc tên file bạn thích)
import 'package:flutter/material.dart';

class WelcomePage1 extends StatefulWidget {
  const WelcomePage1({Key? key}) : super(key: key);

  @override
  State<WelcomePage1> createState() => _WelcomePage1State();
}

class _WelcomePage1State extends State<WelcomePage1> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Khuyến mãi gần bạn",
      "desc": "Tìm sản phẩm sắp hết hạn với giá ưu đãi tại\ncác cửa hàng gần bạn",
      "icon": Icons.shopping_bag_outlined,
      "bgIconColor": const Color(0xFFE8F9F0),
      "iconColor": const Color(0xFF00A651),
    },
    {
      "title": "Túi Smartbag bất ngờ",
      "desc": "Nhận các sản phẩm giá trị cao với chi phí rẻ.\nMỗi túi là một bất ngờ!",
      "icon": Icons.card_giftcard,
      "bgIconColor": const Color(0xFFF1F8E9),
      "iconColor": const Color(0xFF00A651),
    },
    {
      "title": "Giảm lãng phí thực phẩm",
      "desc": "Cùng cửa hàng giảm lãng phí – bảo vệ môi trường\ncho thế hệ mai sau",
      "icon": Icons.public,
      "bgIconColor": const Color(0xFFE1F5FE),
      "iconColor": const Color(0xFF0288D1),
    },
  ];

  void _onNext() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    // Trang cuối: hiện tại không làm gì cả (bạn sẽ thêm logic sau)
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) => _buildPageContent(
                  data: _onboardingData[index],
                  size: size,
                ),
              ),
            ),

            // Indicator
            SizedBox(
              height: size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => _buildDot(index: index),
                ),
              ),
            ),

            // Nút Tiếp theo / Bắt đầu ngay
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Container(
                width: size.width * 0.7,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00A651), Color(0xFF00E66D)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00A651).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _onNext,
                    borderRadius: BorderRadius.circular(30),
                    child: Center(
                      child: Text(
                        _currentPage == _onboardingData.length - 1
                            ? 'Bắt đầu ngay'
                            : 'Tiếp theo',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent({
    required Map<String, dynamic> data,
    required Size size,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.08),

          Container(
            width: size.width * 0.55,
            height: size.width * 0.55,
            decoration: BoxDecoration(
              color: data['bgIconColor'],
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              data['icon'],
              size: 80,
              color: data['iconColor'],
            ),
          ),

          const SizedBox(height: 40),

          Text(
            data['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111111),
              height: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            data['desc'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDot({required int index}) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 8,
          width: _currentPage == index ? 32 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color(0xFF00A651)
                : const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}