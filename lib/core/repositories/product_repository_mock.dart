import '../api/api_client.dart';
import '../models/product.dart';
import '../../data/mock_products.dart';

/// Mock repository that returns hardcoded data
/// No backend needed - perfect for frontend development
class ProductRepositoryMock {
  Future<ApiResponse<List<Product>>> search({
    String? keyword,
    String? category,
    int limit = 20,
    int offset = 0,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final allProducts = mockProducts;
    
    // Simple keyword filtering
    var filtered = allProducts;
    if (keyword != null && keyword.isNotEmpty) {
      filtered = allProducts
          .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    
    // Apply pagination
    final start = offset;
    final end = (start + limit).clamp(0, filtered.length);
    final paginated = filtered.sublist(start, end);
    
    return ApiResponse.success(paginated);
  }

  Future<ApiResponse<Product>> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      final product = mockProducts.firstWhere((p) => p.id == id);
      return ApiResponse.success(product);
    } catch (_) {
      return ApiResponse.failure(404, {'message': 'Product not found'});
    }
  }
}
