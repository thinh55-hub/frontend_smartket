import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

enum MainTab { home, explore, qr, smartbag, cart }

class BottomNav extends StatelessWidget {
  final MainTab current;
  final ValueChanged<MainTab> onChanged;

  const BottomNav({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_NavItem>[
      _NavItem.svg(MainTab.home, _homeIconSvg, 'Trang chủ'),
      _NavItem.svg(MainTab.explore, _exploreIconSvg, 'Khám phá'),
      _NavItem.svg(MainTab.qr, _qrIconSvg, 'Mã QR'),
      _NavItem.svg(MainTab.smartbag, _smartbagIconSvg, 'Smartbag'),
      _NavItem.svg(MainTab.cart, _exploreIconSvg, 'Giỏ hàng'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: AppRadius.r20,
          topRight: AppRadius.r20,
        ),
        boxShadow: AppShadows.light,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: items.map((item) {
          final selected = item.tab == current;
          final color = selected ? AppColors.primary : AppColors.navInactive;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(item.tab),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  item.buildIcon(color),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: GoogleFonts.lexendDeca(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  final MainTab tab;
  final String label;
  final IconData? iconData;
  final String? svgData;

  const _NavItem.icon(this.tab, this.iconData, this.label) : svgData = null;

  const _NavItem.svg(this.tab, this.svgData, this.label) : iconData = null;

  Widget buildIcon(Color color) {
    if (svgData != null) {
      return SvgPicture.string(
        svgData!,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }
    return Icon(iconData, size: 22, color: color);
  }
}
const _homeIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
<path d="M14.9919 20.9888V12.9931C14.9919 12.728 14.8866 12.4738 14.6992 12.2864C14.5117 12.099 14.2575 11.9937 13.9924 11.9937H9.99458C9.72951 11.9937 9.47529 12.099 9.28785 12.2864C9.10042 12.4738 8.99512 12.728 8.99512 12.9931V20.9888" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M2.99841 9.99471C2.99834 9.70394 3.06171 9.41665 3.1841 9.15288C3.30649 8.88912 3.48495 8.65523 3.70703 8.46753L10.7033 2.47076C11.0641 2.16583 11.5212 1.99854 11.9936 1.99854C12.466 1.99854 12.9231 2.16583 13.2839 2.47076L20.2801 8.46753C20.5022 8.65523 20.6807 8.88912 20.803 9.15288C20.9254 9.41665 20.9888 9.70394 20.9887 9.99471V18.9899C20.9887 19.52 20.7781 20.0285 20.4033 20.4033C20.0284 20.7782 19.52 20.9888 18.9898 20.9888H4.99734C4.46719 20.9888 3.95876 20.7782 3.58388 20.4033C3.20901 20.0285 2.99841 19.52 2.99841 18.9899V9.99471Z" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';
const _exploreIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
  <path d="M15.9914 9.99463C15.9914 11.0549 15.5702 12.0718 14.8205 12.8215C14.0707 13.5713 13.0539 13.9925 11.9936 13.9925C10.9333 13.9925 9.91641 13.5713 9.16667 12.8215C8.41693 12.0718 7.99573 11.0549 7.99573 9.99463" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M3.10132 6.03076H20.8857" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M3.3982 5.46416C3.13869 5.81016 2.99841 6.231 2.99841 6.66351V19.9893C2.99841 20.5195 3.20901 21.0279 3.58388 21.4028C3.95876 21.7777 4.46719 21.9883 4.99734 21.9883H18.9898C19.52 21.9883 20.0284 21.7777 20.4033 21.4028C20.7781 21.0279 20.9887 20.5195 20.9887 19.9893V6.66351C20.9887 6.231 20.8484 5.81016 20.5889 5.46416L18.59 2.79859C18.4038 2.55033 18.1624 2.34884 17.8848 2.21006C17.6073 2.07127 17.3012 1.99902 16.9909 1.99902H6.99626C6.68594 1.99902 6.37988 2.07127 6.10232 2.21006C5.82475 2.34884 5.58332 2.55033 5.39712 2.79859L3.3982 5.46416Z" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';
const _qrIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
  <path d="M6.99626 2.99829H3.99788C3.44589 2.99829 2.99841 3.44577 2.99841 3.99775V6.99614C2.99841 7.54813 3.44589 7.9956 3.99788 7.9956H6.99626C7.54825 7.9956 7.99572 7.54813 7.99572 6.99614V3.99775C7.99572 3.44577 7.54825 2.99829 6.99626 2.99829Z" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M19.9893 2.99829H16.9909C16.4389 2.99829 15.9915 3.44577 15.9915 3.99775V6.99614C15.9915 7.54813 16.4389 7.9956 16.9909 7.9956H19.9893C20.5413 7.9956 20.9888 7.54813 20.9888 6.99614V3.99775C20.9888 3.44577 20.5413 2.99829 19.9893 2.99829Z" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M6.99626 15.9915H3.99788C3.44589 15.9915 2.99841 16.4389 2.99841 16.9909V19.9893C2.99841 20.5413 3.44589 20.9888 3.99788 20.9888H6.99626C7.54825 20.9888 7.99572 20.5413 7.99572 19.9893V16.9909C7.99572 16.4389 7.54825 15.9915 6.99626 15.9915Z" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M20.9888 15.9915H17.9904C17.4602 15.9915 16.9518 16.2021 16.5769 16.5769C16.2021 16.9518 15.9915 17.4602 15.9915 17.9904V20.9888" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M20.9888 20.9888V20.9988" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M11.9935 6.99634V9.99472C11.9935 10.5249 11.7829 11.0333 11.4081 11.4082C11.0332 11.783 10.5247 11.9936 9.9946 11.9936H6.99622" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M2.99841 11.9937H3.00841" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M11.9935 2.99829H12.0035" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M11.9935 15.9915V16.0015" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M15.9915 11.9937H16.9915" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M20.9888 11.9937V12.0037" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M11.9935 20.9893V19.9893" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';
const _smartbagIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
  <path d="M19.9891 7.99561H3.99775C3.44577 7.99561 2.99829 8.44308 2.99829 8.99507V10.994C2.99829 11.546 3.44577 11.9935 3.99775 11.9935H19.9891C20.5411 11.9935 20.9886 11.546 20.9886 10.994V8.99507C20.9886 8.44308 20.5411 7.99561 19.9891 7.99561Z" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M11.9937 7.99561V20.9886" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M18.9898 11.9937V18.9899C18.9898 19.52 18.7792 20.0285 18.4043 20.4033C18.0294 20.7782 17.521 20.9888 16.9909 20.9888H6.99624C6.46609 20.9888 5.95766 20.7782 5.58279 20.4033C5.20791 20.0285 4.99731 19.52 4.99731 18.9899V11.9937" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M7.49597 7.99579C6.83329 7.99579 6.19774 7.73254 5.72915 7.26396C5.26056 6.79537 4.99731 6.15982 4.99731 5.49714C4.99731 4.83445 5.26056 4.19891 5.72915 3.73032C6.19774 3.26173 6.83329 2.99848 7.49597 2.99848C8.46014 2.98169 9.40497 3.4495 10.2072 4.34092C11.0095 5.23234 11.632 6.506 11.9935 7.99579C12.3551 6.506 12.9776 5.23234 13.7799 4.34092C14.5821 3.4495 15.527 2.98169 16.4911 2.99848C17.1538 2.99848 17.7894 3.26173 18.2579 3.73032C18.7265 4.19891 18.9898 4.83445 18.9898 5.49714C18.9898 6.15982 18.7265 6.79537 18.2579 7.26396C17.7894 7.73254 17.1538 7.99579 16.4911 7.99579" stroke="#99A1AF" stroke-width="1.99892" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';
