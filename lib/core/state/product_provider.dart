import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final dynamic _repo; // Can be ProductRepository or ProductRepositoryMock
  ProductProvider(this._repo);

  List<Product> _products = [];
  bool _loading = false;
  String? _error;
  String _keyword = '';

  List<Product> get products => _products;
  bool get loading => _loading;
  String? get error => _error;
  String get keyword => _keyword;

  Future<void> fetchInitial() async {
    await search();
  }

  Future<void> search({String? keyword}) async {
    _keyword = keyword ?? _keyword;
    _loading = true;
    _error = null;
    notifyListeners();
    final resp = await _repo.search(keyword: _keyword.isEmpty ? null : _keyword);
    if (resp.ok && resp.data != null) {
      _products = resp.data!;
    } else if (resp.unauthorized) {
      _error = 'unauthorized';
      _products = [];
    } else if (resp.error != null) {
      _error = resp.error;
      _products = [];
    } else {
      _error = 'status ${resp.statusCode}';
      _products = [];
    }
    _loading = false;
    notifyListeners();
  }

  void clear() {
    _products = [];
    _keyword = '';
    notifyListeners();
  }
}
