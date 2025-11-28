import 'dart:math';

import '../core/models/smartbag.dart';

final _random = Random();

const List<String> _smartbagDescriptions = [
  'Combo bánh ngọt kèm đồ uống nóng, lý tưởng cho buổi sáng bận rộn. Bạn sẽ nhận được nhiều loại bánh được làm mới trong ngày, thay đổi theo nguồn hàng mỗi sáng. Đồ uống nóng có thể là cà phê, trà hoặc ca cao tùy vào cửa hàng chuẩn bị. Túi Smartbag luôn được đóng gói gọn gàng, tiện mang đi làm hoặc đi học. Số lượng có hạn theo từng khung giờ nên hãy đặt sớm để không bị hết túi nhé.',
  'Túi bữa sáng đủ chất với sữa, bánh mì và topping ngọt nhẹ. Các món bên trong có thể thay đổi mỗi ngày, mang đến cảm giác bất ngờ thú vị. Bạn có thể dùng ngay hoặc mang theo đến văn phòng để dùng dần trong buổi sáng. Tất cả sản phẩm đều có hạn sử dụng rõ ràng và được bảo quản đúng tiêu chuẩn. Đây là lựa chọn tiết kiệm thời gian nhưng vẫn đảm bảo năng lượng cho ngày mới.',
  'Set salad tươi và nước ép trái cây, phù hợp cho người ăn healthy. Rau củ được sơ chế sạch sẽ, giữ trọn độ giòn và màu sắc bắt mắt. Nước sốt đi kèm được để riêng, giúp bạn dễ dàng trộn ngay trước khi ăn. Nước ép trái cây được ép trong ngày, hạn dùng ngắn để đảm bảo độ tươi. Túi Smartbag này rất thích hợp cho bữa trưa nhẹ nhàng hoặc bữa xế lành mạnh.',
  'Bento trưa đầy đủ tinh bột, đạm và rau cho cả ngày năng lượng. Món chính sẽ thay đổi theo ngày, có thể là cơm, mì hoặc mì Ý đơn giản. Kèm theo là món phụ như rau xào, salad hoặc món chiên nướng vừa ăn. Các phần bento được đóng hộp kỹ lưỡng, thuận tiện hâm nóng lại nếu cần. Đây là lựa chọn phù hợp cho dân văn phòng muốn tiết kiệm mà vẫn no lâu.',
];

final List<Smartbag> mockSmartbags = [
  Smartbag(
    id: 'sb-1',
    title: 'Bánh ngọt & cà phê',
    storeName: 'GL Minimart',
    price: 27000,
    oldPrice: 37000,
    pickupTime: '8:00 - 11:30 hôm nay',
    distance: '0.6 km',
    tag: 'Sweet Treat',
    imageAsset: 'assets/images/smartbag_image.jpg',
    stock: 1 + _random.nextInt(6),
    description: _smartbagDescriptions[0],
  ),
  Smartbag(
    id: 'sb-2',
    title: 'Sữa tươi + bánh mì',
    storeName: 'ĐT Minimart',
    price: 32000,
    oldPrice: 45000,
    pickupTime: '9:00 - 12:00 hôm nay',
    distance: '0.9 km',
    tag: 'Breakfast',
    imageAsset: 'assets/images/smartbag_image.jpg',
    stock: 1 + _random.nextInt(6),
    description: _smartbagDescriptions[1],
  ),
  Smartbag(
    id: 'sb-3',
    title: 'Combo salad & nước ép',
    storeName: 'Freshie Bar',
    price: 45000,
    oldPrice: 60000,
    pickupTime: '10:00 - 13:00 hôm nay',
    distance: '1.1 km',
    tag: 'Healthy',
    imageAsset: 'assets/images/smartbag_image.jpg',
    stock: 1 + _random.nextInt(6),
    description: _smartbagDescriptions[2],
  ),
  Smartbag(
    id: 'sb-4',
    title: 'Bento trưa ngẫu nhiên',
    storeName: 'Gia Lạc Minimart',
    price: 38000,
    oldPrice: 52000,
    pickupTime: '11:00 - 14:00 hôm nay',
    distance: '1.4 km',
    tag: 'Lunch Deal',
    imageAsset: 'assets/images/smartbag_image.jpg',
    stock: 1 + _random.nextInt(6),
    description: _smartbagDescriptions[3],
  ),
];
