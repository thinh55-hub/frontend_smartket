import 'dart:async';
import '../api/api_client.dart';
import '../models/cart.dart';

class CartRepositoryMock {
  Future<ApiResponse<List<CartStore>>> fetchCart() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ApiResponse.success([
      CartStore(
        id: 'store_gl',
        name: 'GL Minimart',
        items: [
          CartItem(
            id: 'mi-hao-hao',
            title: 'Mỳ Hảo Hảo Tôm Chua Cay',
            price: 6000,
            quantity: 2,
            imageAsset: 'assets/images/mi_hao_hao.png',
          ),
          CartItem(
            id: 'th-true-milk',
            title: 'Sữa Tươi Ít Đường TH True Milk',
            price: 12000,
            quantity: 1,
            imageAsset: 'assets/images/sua_th.png',
          ),
          CartItem(
            id: 'haribo',
            title: 'Kẹo Dẻo Haribo',
            price: 8000,
            quantity: 3,
            imageAsset: 'assets/images/haribo.png',
          ),
        ],
      ),
      CartStore(
        id: 'store_dt',
        name: 'ĐT Minimart',
        items: [
          CartItem(
            id: 'twister',
            title: 'Nước Ép Cam Twister',
            price: 12500,
            quantity: 1,
            imageAsset: 'assets/images/twister.png',
          ),
          CartItem(
            id: 'oishi',
            title: 'Oishi Snack Bí Đỏ',
            price: 5000,
            quantity: 2,
            imageAsset: 'assets/images/oishi.png',
          ),
          CartItem(
            id: 'g7',
            title: 'Cà Phê Hoà Tan G7',
            price: 21000,
            quantity: 1,
            imageAsset: 'assets/images/g7.png',
          ),
        ],
      ),
    ]);
  }
}
