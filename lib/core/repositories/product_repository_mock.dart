import '../api/api_client.dart';
import '../models/product.dart';

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
    
    final allProducts = _getMockProducts();
    
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
      final product = _getMockProducts().firstWhere((p) => p.id == id);
      return ApiResponse.success(product);
    } catch (_) {
      return ApiResponse.failure(404, {'message': 'Product not found'});
    }
  }

  List<Product> _getMockProducts() => [
    Product(
      id: '1',
      name: 'Mì Hảo Hảo Tôm Chua Cay',
      description: 'Mì gói vị tôm chua cay truyền thống',
      price: 6000,
      oldPrice: 8000,
      category: 'Thực phẩm & đồ ăn',
      merchantName: 'Gia Lạc Minimart',
      merchantId: 1,
      stock: 50,
      discount: 25.0,
    ),
    Product(
      id: '2',
      name: 'Cơm Bento Trứng Cuộn',
      description: 'Cơm hộp Nhật Bản với trứng cuộn',
      price: 35000,
      oldPrice: 50000,
      category: 'Thực phẩm & đồ ăn',
      merchantName: 'Gia Lạc Minimart',
      merchantId: 1,
      stock: 15,
      discount: 30.0,
    ),
    Product(
      id: '3',
      name: 'Bánh Mì Thịt Nguội',
      description: 'Bánh mì pate thịt nguội truyền thống',
      price: 15000,
      oldPrice: 20000,
      category: 'Bánh ngọt / Bánh mì',
      merchantName: 'Gia Lạc Minimart',
      merchantId: 1,
      stock: 30,
      discount: 25.0,
    ),
    Product(
      id: '4',
      name: 'Sữa Tươi Vinamilk 1L',
      description: 'Sữa tươi tiệt trùng không đường',
      price: 28000,
      oldPrice: 32000,
      category: 'Sữa & sản phẩm từ sữa',
      merchantName: 'Gia Lạc Minimart',
      merchantId: 1,
      stock: 25,
      discount: 12.5,
    ),
    Product(
      id: '5',
      name: 'Snack Oishi Bí Đỏ',
      description: 'Snack khoai tây vị bí đỏ',
      price: 10000,
      oldPrice: 12000,
      category: 'Snack – Bánh kẹo – Đồ ăn vặt',
      merchantName: 'Gia Lạc Minimart',
      merchantId: 1,
      stock: 100,
      discount: 16.7,
    ),
    Product(
      id: '6',
      name: 'Nước Cam Ép Twister 330ml',
      description: 'Nước cam ép tươi nguyên chất',
      price: 18000,
      oldPrice: 22000,
      category: 'Đồ uống',
      merchantName: 'Gia Lạc Minimart',
      merchantId: 1,
      stock: 40,
      discount: 18.2,
    ),
    Product(
      id: '7',
      name: 'Cà Phê Sữa Đá Highlands',
      description: 'Cà phê sữa đá đóng chai',
      price: 25000,
      oldPrice: 30000,
      category: 'Đồ uống',
      merchantName: 'Highlands Coffee',
      merchantId: 2,
      stock: 20,
      discount: 16.7,
    ),
    Product(
      id: '8',
      name: 'Chuối Già Hữu Cơ 1kg',
      description: 'Chuối già hữu cơ Đà Lạt',
      price: 32000,
      oldPrice: 38000,
      category: 'Trái cây – Rau củ',
      merchantName: 'Gia Lạc Minimart',
      merchantId: 1,
      stock: 12,
      discount: 15.8,
    ),
    Product(
      id: '9',
      name: 'Thịt Heo Ba Chỉ 500g',
      description: 'Thịt heo ba chỉ tươi ngon',
      price: 65000,
      oldPrice: 75000,
      category: 'Thịt – Hải sản',
      merchantName: 'Gia Lạc Minimart',
      merchantId: 1,
      stock: 8,
      discount: 13.3,
    ),
    Product(
      id: '10',
      name: 'Gạo ST25 5kg',
      description: 'Gạo thơm ST25 chất lượng cao',
      price: 180000,
      oldPrice: 200000,
      category: 'Đồ khô – Gia vị – Mì gói',
      merchantName: 'Gia Lạc Minimart',
      merchantId: 1,
      stock: 5,
      discount: 10.0,
    ),
  ];
}
