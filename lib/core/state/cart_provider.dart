import 'package:flutter/foundation.dart';

import '../api/api_client.dart';
import '../models/cart.dart';

class CartProvider extends ChangeNotifier {
  final dynamic _repo; // CartRepository or CartRepositoryMock
  CartProvider(this._repo);

  List<CartStore> _stores = [];
  bool _loading = false;
  String? _error;

  List<CartStore> get stores => _stores;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchCart() async {
    _loading = true;
    _error = null;
    notifyListeners();
    final ApiResponse<List<CartStore>> resp = await _repo.fetchCart();
    if (resp.ok && resp.data != null) {
      _stores = resp.data!;
    } else if (resp.unauthorized) {
      _error = 'unauthorized';
      _stores = [];
    } else if (resp.error != null) {
      _error = resp.error;
      _stores = [];
    } else {
      _error = 'status ${resp.statusCode}';
      _stores = [];
    }
    _loading = false;
    notifyListeners();
  }

  void increaseQuantity(String storeId, String itemId) {
    _updateItem(storeId, itemId, (item) => item.copyWith(quantity: item.quantity + 1));
  }

  void decreaseQuantity(String storeId, String itemId) {
    _updateItem(storeId, itemId, (item) {
      final nextQty = item.quantity > 0 ? item.quantity - 1 : 0;
      return item.copyWith(quantity: nextQty);
    });
  }

  void removeItem(String storeId, String itemId) {
    bool changed = false;
    final updatedStores = _stores.map((store) {
      if (store.id != storeId) return store;
      final updatedItems = store.items.where((item) {
        final keep = item.id != itemId;
        if (!keep) changed = true;
        return keep;
      }).toList();
      return store.copyWith(items: updatedItems);
    }).where((store) => store.items.isNotEmpty).toList();
    if (changed) {
      _stores = updatedStores;
      notifyListeners();
    }
  }

  void clear() {
    _stores = [];
    notifyListeners();
  }

  void _updateItem(String storeId, String itemId, CartItem Function(CartItem item) transform) {
    bool changed = false;
    final updatedStores = _stores.map((store) {
      if (store.id != storeId) return store;
      final updatedItems = store.items.map((item) {
        if (item.id != itemId) return item;
        changed = true;
        return transform(item);
      }).toList();
      return store.copyWith(items: updatedItems);
    }).toList();
    if (changed) {
      _stores = updatedStores;
      notifyListeners();
    }
  }
}
