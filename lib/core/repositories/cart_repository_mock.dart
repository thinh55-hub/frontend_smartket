import 'dart:async';
import '../api/api_client.dart';
import '../models/cart.dart';

class CartRepositoryMock {
  Future<ApiResponse<List<CartStore>>> fetchCart() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ApiResponse.success([
      CartStore(
        id: '1',
        name: 'GL Minimart',
        items: [
          CartItem(
            id: 'mi_hao_hao',
            title: 'Mỳ Hảo Hảo Tôm Chua Cay',
            price: 3500,
            quantity: 2,
            imageAsset: 'assets/images/mi_hao_hao.png',
          ),
          CartItem(
            id: 'sua_th',
            title: 'Sữa TH True Milk 1L',
            price: 31000,
            quantity: 1,
            imageAsset: 'assets/images/sua_th.png',
          ),
          CartItem(
            id: 'haribo',
            title: 'Kẹo dẻo Haribo Goldbears 80g',
            price: 27000,
            quantity: 3,
            imageAsset: 'assets/images/haribo.png',
          ),
        ],
      ),
      CartStore(
        id: '2',
        name: 'ĐT Minimart',
        items: [
          CartItem(
            id: 'twister',
            title: 'Nước ép Twister Cam 330ml',
            price: 11000,
            quantity: 1,
            imageAsset: 'assets/images/twister.png',
          ),
          CartItem(
            id: 'oishi_snack',
            title: 'Snack Oishi Prawn Crackers 40g',
            price: 8500,
            quantity: 2,
            imageAsset: 'assets/images/oishi.png',
          ),
          CartItem(
            id: 'g7_coffee',
            title: 'Cà phê hòa tan G7 3in1 (10 gói)',
            price: 29500,
            quantity: 1,
            imageAsset: 'assets/images/g7.png',
          ),
        ],
      ),
    ]);
  }
}
