import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/locale_provider.dart';

enum HeroRangeKey { today, week, month }

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  factory AppLocalizations.of(BuildContext context) {
    final provider = context.watch<LocaleProvider>();
    return AppLocalizations(provider.locale);
  }

  bool get isVietnamese => locale.languageCode == 'vi';

  String get profileTitle => isVietnamese ? 'Hồ sơ cá nhân' : 'Profile';

  String get accountSection =>
      isVietnamese ? 'Tài khoản' : 'Account';

  String get paymentSection =>
      isVietnamese ? 'Thanh toán' : 'Payment';

  String get settingsSection =>
      isVietnamese ? 'Cài đặt' : 'Settings';

  String get supportSection =>
      isVietnamese ? 'Hỗ trợ' : 'Support';

  String get accountInfoTitle =>
      isVietnamese ? 'Thông tin tài khoản' : 'Account information';

  String get accountInfoSubtitle =>
      'Nguyễn Văn A • nguyenvana@email.com';

  String get orderHistoryTitle =>
      isVietnamese ? 'Lịch sử đơn hàng' : 'Order history';

  String get paymentMethodsTitle =>
      isVietnamese ? 'Phương thức thanh toán' : 'Payment methods';

  String get paymentMethodsSubtitle => isVietnamese
      ? 'Quản lý MoMo / Ngân hàng / Apple Pay'
      : 'Manage MoMo / Bank / Apple Pay';

  String get notificationsTitle =>
      isVietnamese ? 'Thông báo' : 'Notifications';

  String get languageTitle =>
      isVietnamese ? 'Ngôn ngữ' : 'Language';

  String get languageSubtitle =>
      isVietnamese ? 'Tiếng Việt' : 'English';

  String get helpTitle =>
      isVietnamese ? 'Trợ giúp & Hỗ trợ' : 'Help & Support';

  String get helpSubtitle => isVietnamese
      ? 'Câu hỏi thường gặp / Liên hệ'
      : 'FAQ / Contact';

  String get logoutLabel =>
      isVietnamese ? 'Đăng xuất' : 'Log out';

  String get logoutDialogTitle => logoutLabel;

  String get logoutDialogMessage => isVietnamese
      ? 'Bạn có chắc muốn đăng xuất?'
      : 'Are you sure you want to log out?';

  String get logoutCancelLabel => isVietnamese ? 'Hủy' : 'Cancel';

  // Personal info
  String get personalInfoTitle => isVietnamese ? 'Thông tin cá nhân' : 'Personal information';

  String get personalInfoSubtitle => isVietnamese
      ? 'Hoàn tất thông tin để bắt đầu sử dụng SMARTKET'
      : 'Complete your information to start using SMARTKET';

  String get personalInfoFullNameLabel => isVietnamese ? 'Họ và tên' : 'Full name';
  String get personalInfoFullNameHint => isVietnamese ? 'Nguyễn Văn A' : 'John Doe';
  String get personalInfoDOBLabel => isVietnamese ? 'Ngày sinh' : 'Date of birth';
  String get personalInfoDOBHint => isVietnamese ? 'mm/dd/yyyy' : 'mm/dd/yyyy';
  String get personalInfoEmailLabel => isVietnamese ? 'Email' : 'Email';
  String get personalInfoEmailHint => isVietnamese ? 'email@example.com' : 'email@example.com';
  String get personalInfoAddressLabel => isVietnamese ? 'Địa chỉ' : 'Address';
  String get personalInfoAddressHint => isVietnamese ? '123 Đường ABC, Quận 1, TP.HCM' : '123 Main St, District 1, HCM';
  String get personalInfoCompleteButton => isVietnamese ? 'Hoàn tất' : 'Complete';

  // Favorites
  String get favoritesTitle => isVietnamese ? 'Yêu thích' : 'Favorites';
  String get favoritesEmptyTitle => isVietnamese ? 'Chưa có cửa hàng yêu thích' : 'No favorite stores yet';
  String get favoritesEmptyMessage => isVietnamese
      ? 'Thêm cửa hàng vào danh sách yêu thích để xem ở đây'
      : 'Start adding stores to your favorites to see them here';
  String get favoritesBrowseAction => isVietnamese ? 'Duyệt cửa hàng' : 'Browse Stores';

  // Payment sheet actions
  String get paymentCancelLabel => isVietnamese ? 'Hủy' : 'Cancel';
  String get paymentDoneLabel => isVietnamese ? 'Xong' : 'Done';

    String get paymentAddCardLabel => isVietnamese ? 'Thêm thẻ mới' : 'Add new card';

  // Cart
  String get cartEmptySubtitle => isVietnamese ? 'Hãy thêm sản phẩm để bắt đầu mua sắm' : 'Add products to start shopping';
    String get cartTitle => isVietnamese ? 'Giỏ hàng' : 'Cart';
    String get cartEmptyTitle => isVietnamese ? 'Giỏ hàng đang trống' : 'Your cart is empty';
    String get cartLoadErrorTitle => isVietnamese ? 'Không thể tải giỏ hàng' : 'Could not load cart';

  // Login strings
  String get loginPhoneLabel => isVietnamese ? 'Số điện thoại' : 'Phone number';

  String get loginPhoneHint => isVietnamese ? 'Nhập số điện thoại' : 'Enter your phone number';

  String get loginPasswordLabel => isVietnamese ? 'Mật khẩu' : 'Password';

  String get loginPasswordHint => isVietnamese ? 'Nhập mật khẩu' : 'Enter your password';

  String get loginForgotPassword => isVietnamese ? 'Quên mật khẩu?' : 'Forgot password?';

  String get loginButton => isVietnamese ? 'Đăng nhập' : 'Log in';

  String get loginNoAccount => isVietnamese ? 'Chưa có tài khoản?' : 'No account yet?';

  String get loginCreateAccount => isVietnamese ? 'Tạo tài khoản' : 'Create account';

  String get loginOrConnect => isVietnamese ? 'Hoặc đăng nhập bằng' : 'Or sign in with';

  // Register strings
  String get registerTitle => isVietnamese ? 'Đăng ký tài khoản' : 'Create your account';

  String get registerPersonalInfo => isVietnamese ? 'Thông tin cá nhân' : 'Personal information';

  String get registerFullNameLabel => isVietnamese ? 'Họ và tên' : 'Full name';

  String get registerFullNameHint => isVietnamese ? 'Nhập Họ và Tên của bạn' : 'Enter your full name';

  String get registerPhoneLabel => isVietnamese ? 'Số điện thoại' : 'Phone number';

  String get registerPhoneHint => isVietnamese ? 'Nhập Số điện thoại' : 'Enter your phone number';

  String get registerEmailLabel => isVietnamese ? 'Email' : 'Email';

  String get registerEmailHint => isVietnamese ? 'Nhập địa chỉ Email' : 'Enter your email address';

  String get registerPasswordLabel => isVietnamese ? 'Đặt mật khẩu' : 'Create password';

  String get registerPasswordHint => isVietnamese ? 'Tạo mật khẩu' : 'Create a password';

  String get registerContinueButton => isVietnamese ? 'Tiếp tục' : 'Continue';

  String get registerTermsPrefix => isVietnamese
      ? 'Bằng cách tiếp tục, bạn đồng ý với\n'
      : 'By continuing you agree to our\n';

  String get registerTermsService => isVietnamese ? 'Điều khoản dịch vụ' : 'Terms of Service';

  String get registerTermsAnd => isVietnamese ? ' và ' : ' and ';

  String get registerTermsPrivacy => isVietnamese ? 'Chính sách bảo mật' : 'Privacy Policy';

  String get registerBackToLoginPrefix => isVietnamese ? 'Quay lại ' : 'Back to ';

  String get registerBackToLoginAction => isVietnamese ? 'đăng nhập' : 'login';

  String get heroRescuedTitle => isVietnamese ? 'Bạn đã cứu được' : 'You rescued';

  String get heroSavedTitle => isVietnamese ? 'Số tiền đã tiết kiệm' : 'Money saved';

  String heroRescuedSubtitle(HeroRangeKey key) {
    switch (key) {
      case HeroRangeKey.today:
        return isVietnamese ? 'Túi thực phẩm đã cứu hôm nay' : 'Food bags rescued today';
      case HeroRangeKey.week:
        return isVietnamese ? 'Túi thực phẩm đã cứu tuần này' : 'Food bags rescued this week';
      case HeroRangeKey.month:
        return isVietnamese ? 'Túi thực phẩm đã cứu tháng này' : 'Food bags rescued this month';
    }
  }

  String heroSavedSubtitle(HeroRangeKey key) {
    switch (key) {
      case HeroRangeKey.today:
        return isVietnamese ? 'Số tiền đã tiết kiệm hôm nay' : 'Money saved today';
      case HeroRangeKey.week:
        return isVietnamese ? 'Số tiền đã tiết kiệm tuần này' : 'Money saved this week';
      case HeroRangeKey.month:
        return isVietnamese ? 'Số tiền đã tiết kiệm tháng này' : 'Money saved this month';
    }
  }

  String get heroPromoHeading =>
      isVietnamese ? 'Khuyến mãi gần bạn' : 'Promos near you';

  String get heroErrorPrefix => isVietnamese ? 'Lỗi:' : 'Error:';

  String get heroNoProducts => isVietnamese ? 'Chưa có sản phẩm' : 'No products yet';

  String get smartbagSpotlightTitle =>
      isVietnamese ? 'Smartbag đáng chú ý' : 'Featured Smartbags';

  String get smartbagSpotlightSubtitle =>
      isVietnamese ? 'Săn túi thực phẩm ngon giá tốt trong ngày' : 'Score top-quality bags at a steal today';

  String get smartbagViewAll => isVietnamese ? 'Xem tất cả' : 'View all';

  String get searchPlaceholder =>
      isVietnamese ? 'Tìm sản phẩm, cửa hàng, smartbag...' : 'Search products, stores, smartbags...';

  String get exploreListLabel => isVietnamese ? 'Danh sách' : 'List';

  String get exploreMapLabel => isVietnamese ? 'Bản đồ' : 'Map';

  String get exploreNoProducts => isVietnamese ? 'Chưa có sản phẩm' : 'No products yet';

  String get splashTagline =>
      isVietnamese ? 'Tiết kiệm thực phẩm. Tiết kiệm tiền. Tiết kiệm Trái đất.' : 'Save food. Save money. Save Earth.';

  String get welcomeNextButton => isVietnamese ? 'Tiếp theo' : 'Next';

  String get welcomeStartButton => isVietnamese ? 'Bắt đầu ngay' : 'Start now';

  List<Map<String, String>> get onboardingSlides => [
        {
          'title': isVietnamese ? 'Khuyến mãi gần bạn' : 'Deals near you',
          'description': isVietnamese
              ? 'Tìm sản phẩm với giá ưu đãi tại\ncác cửa hàng gần bạn'
              : 'Discover curated deals from nearby stores',
        },
        {
          'title': isVietnamese ? 'Túi Smartbag bất ngờ' : 'Surprise Smartbags',
          'description': isVietnamese
              ? 'Nhận các sản phẩm giá trị cao với chi phí rẻ.\nMỗi túi là một bất ngờ!'
              : 'Get premium items at a fraction of the price with surprise bags.',
        },
        {
          'title': isVietnamese ? 'Giảm lãng phí thực phẩm' : 'Cut food waste',
          'description': isVietnamese
              ? 'Cùng cửa hàng giảm lãng phí – bảo vệ môi trường\ncho thế hệ mai sau'
              : 'Partner with sellers to reduce waste and protect the planet.',
        },
      ];
}
