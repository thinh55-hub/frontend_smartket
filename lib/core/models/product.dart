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
  final String? imageUrl; // asset path or network URL

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
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double? toDouble(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    int? toInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is String) return int.tryParse(v);
      return null;
    }

    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['title'] ?? 'Unnamed',
      description: json['description'],
      price: toDouble(json['sale_price'] ?? json['price']),
      oldPrice: toDouble(json['orig_price'] ?? json['old_price'] ?? json['original_price']),
      category: json['category'],
      merchantName: json['merchant_name'] ?? json['store'],
      merchantId: toInt(json['merchant_id']),
      stock: toInt(json['stock']),
      discount: toDouble(json['discount']),
      imageUrl: json['image'] ?? json['image_url'],
    );
  }
}