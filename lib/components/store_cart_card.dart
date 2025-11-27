import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/utils/formatting.dart';
import '../theme/app_theme.dart';
import 'compact_cart_item.dart';

class StoreCartCard extends StatelessWidget {
  final String storeName;
  final List<CompactCartItemData> items;
  final VoidCallback? onClose;
  final VoidCallback? onCheckout;
  final EdgeInsetsGeometry? margin;

  const StoreCartCard({
    super.key,
    required this.storeName,
    required this.items,
    this.onClose,
    this.onCheckout,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final total = items.fold<double>(0, (sum, item) => sum + item.price * item.quantity);

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: const BoxDecoration(
              color: Color(0xFFDFFFEC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _StoreIcon(),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    storeName,
                    style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close, color: AppColors.primary, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minHeight: 36, minWidth: 36),
                  splashRadius: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                ...items.asMap().entries.map((entry) {
                  final item = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: entry.key == items.length - 1 ? 0 : 12),
                    child: CompactCartItem(
                      title: item.title,
                      price: item.price,
                      quantity: item.quantity,
                      imageAsset: item.imageAsset,
                      onIncrease: item.onIncrease,
                      onDecrease: item.onDecrease,
                      onRemove: item.onRemove,
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text('Tổng cửa hàng', style: GoogleFonts.lexendDeca(fontSize: 17, color: AppColors.textSecondary)),
                    const Spacer(),
                    Text('${formatCurrency(total)} đ', style: GoogleFonts.lexendDeca(fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: onCheckout,
                  child: SizedBox(
                    width: 300,
                    height: 44,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Thanh toán',
                          style: GoogleFonts.lexendDeca(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompactCartItemData {
  final String title;
  final double price;
  final int quantity;
  final String? imageAsset;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onRemove;

  const CompactCartItemData({
    required this.title,
    required this.price,
    required this.quantity,
    this.imageAsset,
    this.onIncrease,
    this.onDecrease,
    this.onRemove,
  });
}

class _StoreIcon extends StatelessWidget {
  const _StoreIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFE8F7EE),
      ),
      child: Center(
        child: SvgPicture.string(
          _storeIconSvg,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}

const _storeIconSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none">
  <g clip-path="url(#clip0_643_1067)">
    <path d="M15.5556 16.6666H8.88893V12.2222H7.77782V16.6666H4.44449V12.2222H3.33337V16.6666C3.33337 16.9613 3.45044 17.2439 3.65881 17.4523C3.86718 17.6607 4.1498 17.7777 4.44449 17.7777H15.5556C15.8503 17.7777 16.1329 17.6607 16.3413 17.4523C16.5496 17.2439 16.6667 16.9613 16.6667 16.6666V12.2222H15.5556V16.6666Z" fill="#00A63E"/>
    <path d="M18.7722 7.37217L16.5055 2.83883C16.4135 2.65372 16.2717 2.49793 16.0961 2.38899C15.9204 2.28005 15.7178 2.22228 15.5111 2.22217H4.48887C4.28216 2.22228 4.07957 2.28005 3.90389 2.38899C3.72822 2.49793 3.58641 2.65372 3.49443 2.83883L1.22776 7.37217C1.15037 7.52744 1.11041 7.69868 1.11109 7.87217V9.58328C1.11059 9.84289 1.201 10.0945 1.36665 10.2944C1.61146 10.575 1.91381 10.7997 2.25317 10.953C2.59252 11.1064 2.96091 11.1849 3.33331 11.1833C3.94096 11.1842 4.53008 10.9741 4.99998 10.5888C5.46987 10.9743 6.05887 11.185 6.66665 11.185C7.27443 11.185 7.86342 10.9743 8.33331 10.5888C8.80321 10.9743 9.3922 11.185 9.99998 11.185C10.6078 11.185 11.1968 10.9743 11.6666 10.5888C12.1365 10.9743 12.7255 11.185 13.3333 11.185C13.9411 11.185 14.5301 10.9743 15 10.5888C15.5245 11.0195 16.1956 11.2301 16.8721 11.1762C17.5487 11.1223 18.178 10.8082 18.6278 10.2999C18.7954 10.1008 18.8878 9.84914 18.8889 9.58883V7.87217C18.8895 7.69868 18.8496 7.52744 18.7722 7.37217ZM16.6666 10.0722C16.4294 10.0716 16.1956 10.0143 15.985 9.90514C15.7743 9.79594 15.5928 9.63797 15.4555 9.44439L15 8.82217L14.55 9.44439C14.4101 9.635 14.2274 9.79 14.0165 9.89683C13.8056 10.0037 13.5725 10.0593 13.3361 10.0593C13.0997 10.0593 12.8666 10.0037 12.6557 9.89683C12.4448 9.79 12.262 9.635 12.1222 9.44439L11.6666 8.82217L11.2166 9.44439C11.0768 9.635 10.894 9.79 10.6831 9.89683C10.4723 10.0037 10.2392 10.0593 10.0028 10.0593C9.76635 10.0593 9.53326 10.0037 9.32237 9.89683C9.11148 9.79 8.92872 9.635 8.78887 9.44439L8.33331 8.82217L7.88331 9.44439C7.74347 9.635 7.5607 9.79 7.34981 9.89683C7.13892 10.0037 6.90583 10.0593 6.66943 10.0593C6.43302 10.0593 6.19993 10.0037 5.98904 9.89683C5.77815 9.79 5.59538 9.635 5.45554 9.44439L4.99998 8.82217L4.54443 9.44439C4.40719 9.63797 4.22567 9.79594 4.015 9.90514C3.80433 10.0143 3.57061 10.0716 3.33331 10.0722C3.12395 10.0747 2.91646 10.0324 2.72481 9.94807C2.53315 9.86374 2.36178 9.73936 2.2222 9.58328V7.87217L4.48887 3.33328H15.5111L17.7778 7.86661V9.56661C17.639 9.72488 17.4682 9.85182 17.2766 9.93899C17.085 10.0262 16.8771 10.0716 16.6666 10.0722Z" fill="#00A63E"/>
  </g>
  <defs>
    <clipPath id="clip0_643_1067">
      <rect width="20" height="20" fill="white"/>
    </clipPath>
  </defs>
</svg>
''';
