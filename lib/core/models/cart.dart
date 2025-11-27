class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String? imageAsset;

  const CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    this.imageAsset,
  });

  CartItem copyWith({
    String? title,
    double? price,
    int? quantity,
    String? imageAsset,
  }) {
    return CartItem(
      id: id,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageAsset: imageAsset ?? this.imageAsset,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? json['name'] ?? '') as String,
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : double.tryParse('${json['price']}') ?? 0,
      quantity: json['quantity'] is int
          ? json['quantity'] as int
          : int.tryParse('${json['quantity'] ?? 0}') ?? 0,
      imageAsset: json['imageAsset'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity': quantity,
      'imageAsset': imageAsset,
    };
  }
}

class CartStore {
  final String id;
  final String name;
  final List<CartItem> items;

  const CartStore({
    required this.id,
    required this.name,
    required this.items,
  });

  double get total => items.fold<double>(0, (sum, item) => sum + item.price * item.quantity);

  CartStore copyWith({
    String? name,
    List<CartItem>? items,
  }) {
    return CartStore(
      id: id,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }

  factory CartStore.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'];
    return CartStore(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '') as String,
      items: itemsJson is List
          ? itemsJson.map((e) => CartItem.fromJson(Map<String, dynamic>.from(e))).toList()
          : <CartItem>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
