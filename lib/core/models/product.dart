class Product {
  final String id;
  final String name;
  final String? description;
  final double? price;
  final double? oldPrice;
  final String? category;
  final String? merchantName;
  final int? merchantId;
  final int? stock;
  final double? discount;

  Product({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.oldPrice,
    this.category,
    this.merchantName,
    this.merchantId,
    this.stock,
    this.discount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double? _toDouble(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    int? _toInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is String) return int.tryParse(v);
      return null;
    }

    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['title'] ?? 'Unnamed',
      description: json['description'],
      price: _toDouble(json['sale_price'] ?? json['price']),
      oldPrice: _toDouble(json['orig_price'] ?? json['old_price'] ?? json['original_price']),
      category: json['category'],
      merchantName: json['merchant_name'] ?? json['store'],
      merchantId: _toInt(json['merchant_id']),
      stock: _toInt(json['stock']),
      discount: _toDouble(json['discount']),
    );
  }
}