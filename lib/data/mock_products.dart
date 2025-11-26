import '../core/models/product.dart';

/// Mock product data aligned with Figma product detail pages.
/// Includes core pricing + merchant info; extended detail text map below.
final List<Product> mockProducts = [
  Product(
    id: 'sua_th',
    name: 'Sữa TH True Milk 1L',
    description: 'Sữa tươi tiệt trùng TH True Milk nguyên chất giàu dinh dưỡng, bổ sung năng lượng mỗi ngày.',
    price: 31000,
    oldPrice: 38000,
    merchantName: 'GL Minimart',
    stock: 42,
    category: 'Sữa & sản phẩm từ sữa',
    imageUrl: 'assets/images/sua_th.png',
  ),
  Product(
    id: 'mi_hao_hao',
    name: 'Mì Hảo Hảo Tôm Chua Cay',
    description: 'Mì gói Hảo Hảo vị tôm chua cay đậm đà, bữa ăn nhanh tiện lợi tiết kiệm thời gian.',
    price: 3500,
    oldPrice: 4500,
    merchantName: 'GL Minimart',
    stock: 120,
    category: 'Đồ khô – Gia vị – Mì gói',
    imageUrl: 'assets/images/mi_hao_hao.png',
  ),
  Product(
    id: 'haribo',
    name: 'Kẹo dẻo Haribo Goldbears 80g',
    description: 'Kẹo dẻo vị trái cây nhiều màu sắc, mềm dai hấp dẫn cho mọi lứa tuổi.',
    price: 27000,
    oldPrice: 32000,
    merchantName: 'GL Minimart',
    stock: 64,
    category: 'Snack – Bánh kẹo – Đồ ăn vặt',
    imageUrl: 'assets/images/haribo.png',
  ),
  Product(
    id: 'twister',
    name: 'Nước ép Twister Cam 330ml',
    description: 'Nước ép cam Twister thơm ngon, bổ sung vitamin C, giải khát tức thì.',
    price: 11000,
    oldPrice: 14000,
    merchantName: 'GL Minimart',
    stock: 55,
    category: 'Đồ uống',
    imageUrl: 'assets/images/twister.png',
  ),
  Product(
    id: 'oishi_snack',
    name: 'Snack Oishi Prawn Crackers 40g',
    description: 'Bánh phồng tôm Oishi giòn tan vị tôm đặc trưng, món ăn vặt quen thuộc.',
    price: 8500,
    oldPrice: 10000,
    merchantName: 'GL Minimart',
    stock: 73,
    category: 'Snack – Bánh kẹo – Đồ ăn vặt',
    imageUrl: 'assets/images/oishi.png',
  ),
  Product(
    id: 'g7_coffee',
    name: 'Cà phê hòa tan G7 3in1 (10 gói)',
    description: 'Cà phê hòa tan G7 3in1 hương vị đậm đà, tiện lợi cho buổi sáng năng động.',
    price: 29500,
    oldPrice: 35000,
    merchantName: 'GL Minimart',
    stock: 38,
    category: 'Đồ uống',
    imageUrl: 'assets/images/g7.png',
  ),
];

/// Extended detail fields that may appear in the Figma page.
/// Keyed by product id for richer presentation sections.
final Map<String, Map<String, String>> mockProductExtended = {
  'sua_th': {
    'origin': 'Nghệ An, Việt Nam',
    'nutrition': 'Giàu Canxi, Vitamin A, D, không chất bảo quản.',
    'storage': 'Bảo quản nơi khô ráo, thoáng mát. Ngon hơn khi dùng lạnh.',
    'usage': 'Uống trực tiếp, lắc đều trước khi dùng.'
  },
  'mi_hao_hao': {
    'origin': 'Việt Nam',
    'nutrition': 'Carb, chất béo, gia vị tôm chua cay.',
    'storage': 'Để nơi khô ráo tránh ánh nắng trực tiếp.',
    'usage': 'Cho vắt mì vào 400ml nước sôi, nấu 3 phút, thêm gói gia vị.'
  },
  'haribo': {
    'origin': 'Đức',
    'nutrition': 'Đường, gelatin, hương liệu trái cây tự nhiên.',
    'storage': 'Để nơi mát, tránh nhiệt độ cao làm chảy kẹo.',
    'usage': 'Dùng trực tiếp, không cần chế biến.'
  },
  'twister': {
    'origin': 'Việt Nam',
    'nutrition': 'Vitamin C tự nhiên từ nước ép cam.',
    'storage': 'Bảo quản nơi thoáng mát, dùng ngay sau khi mở nắp.',
    'usage': 'Lắc nhẹ trước khi uống, ngon hơn khi ướp lạnh.'
  },
  'oishi_snack': {
    'origin': 'Việt Nam',
    'nutrition': 'Tinh bột, dầu thực vật, hương vị tôm.',
    'storage': 'Để kín sau khi mở, tránh ẩm.',
    'usage': 'Ăn trực tiếp, dùng kèm sốt tuỳ thích.'
  },
  'g7_coffee': {
    'origin': 'Buôn Ma Thuột, Việt Nam',
    'nutrition': 'Caffeine tự nhiên, đường và bột kem.',
    'storage': 'Để nơi khô ráo, tránh ánh nắng.',
    'usage': 'Đổ gói vào 70-80ml nước nóng, khuấy đều và thưởng thức.'
  },
};
