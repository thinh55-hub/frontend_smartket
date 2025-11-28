// lib/screens/welcome_screen.dart
import 'package:flutter/material.dart';

import '../core/localization/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  static const List<_OnboardingVisual> _visualData = [
    _OnboardingVisual(
      icon: Icons.shopping_bag_outlined,
      backgroundColor: Color(0xFFE8F9F0),
      iconColor: Color(0xFF00A651),
    ),
    _OnboardingVisual(
      icon: Icons.card_giftcard,
      backgroundColor: Color(0xFFF1F8E9),
      iconColor: Color(0xFF00A651),
    ),
    _OnboardingVisual(
      icon: Icons.public,
      backgroundColor: Color(0xFFE1F5FE),
      iconColor: Color(0xFF0288D1),
    ),
  ];

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

  void _onNext() {
    final maxIndex = _visualData.length - 1;
    if (_currentPage < maxIndex) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final onboardingItems = _buildOnboardingData(strings);
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
                itemCount: onboardingItems.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) => _buildPageContent(
                  item: onboardingItems[index],
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
                  onboardingItems.length,
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
                        _currentPage == onboardingItems.length - 1
                            ? strings.welcomeStartButton
                            : strings.welcomeNextButton,
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

  Widget _buildPageContent({required OnboardingItem item, required Size size}) {
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
              color: item.backgroundColor,
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
              item.icon,
              size: 80,
              color: item.iconColor,
            ),
          ),

          const SizedBox(height: 40),

          Text(
            item.title,
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
            item.description,
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

  List<OnboardingItem> _buildOnboardingData(AppLocalizations strings) {
    final slides = strings.onboardingSlides;
    final count = slides.length < _visualData.length ? slides.length : _visualData.length;
    return List.generate(count, (index) {
      final visual = _visualData[index];
      final slide = slides[index];
      return OnboardingItem(
        title: slide['title'] ?? '',
        description: slide['description'] ?? '',
        icon: visual.icon,
        backgroundColor: visual.backgroundColor,
        iconColor: visual.iconColor,
      );
    });
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

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}

class _OnboardingVisual {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const _OnboardingVisual({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}
