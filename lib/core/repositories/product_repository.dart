import '../api/api_client.dart';
import '../models/product.dart';

class ProductRepository {
  final ApiClient _client;
  ProductRepository(this._client);

  Future<ApiResponse<List<Product>>> search({
    String? keyword,
    String? category,
    int limit = 20,
    int offset = 0,
  }) async {
    final params = <String, String>{
      'limit': limit.toString(),
      'offset': offset.toString(),
      if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      if (category != null && category.isNotEmpty) 'category': category,
    };
    final query = params.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&');
    return _client.get('/products/search?$query', parser: (json) {
      final data = json['data'];
      if (data is List) {
        return data.map((e) => Product.fromJson(Map<String, dynamic>.from(e))).toList();
      }
      return <Product>[];
    });
  }

  Future<ApiResponse<Product>> getById(String id) async {
    return _client.get('/products/$id', parser: (json) {
      final data = json['data'] ?? json;
      return Product.fromJson(Map<String, dynamic>.from(data));
    });
  }
}