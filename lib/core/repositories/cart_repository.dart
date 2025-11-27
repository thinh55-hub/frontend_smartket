import '../api/api_client.dart';
import '../models/cart.dart';

class CartRepository {
  final ApiClient _client;
  CartRepository(this._client);

  Future<ApiResponse<List<CartStore>>> fetchCart() async {
    return _client.get('/cart', parser: (json) {
      dynamic data = json;
      if (json is Map<String, dynamic>) {
        data = json['data'] ?? json['stores'] ?? json;
      }
      if (data is List) {
        return data.map((e) => CartStore.fromJson(Map<String, dynamic>.from(e))).toList();
      }
      return <CartStore>[];
    });
  }
}
