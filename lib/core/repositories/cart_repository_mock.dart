import 'dart:async';
import '../api/api_client.dart';
import '../models/cart.dart';

class CartRepositoryMock {
  Future<ApiResponse<List<CartStore>>> fetchCart() async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Return an empty cart by default; items are added as the user shops.
    return ApiResponse.success(<CartStore>[]);
  }
}
