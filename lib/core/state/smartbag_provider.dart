import 'package:flutter/foundation.dart';

import '../models/smartbag.dart';

class SmartbagProvider extends ChangeNotifier {
  final dynamic _repo; // real or mock repository
  SmartbagProvider(this._repo);

  List<Smartbag> _bags = [];
  bool _loading = false;
  String? _error;
  String _keyword = '';

  List<Smartbag> get bags => _bags;
  bool get loading => _loading;
  String? get error => _error;
  String get keyword => _keyword;

  Future<void> fetchInitial() => fetch(keyword: null);

  Future<void> fetch({String? keyword}) async {
    _keyword = keyword ?? _keyword;
    _loading = true;
    _error = null;
    notifyListeners();
    final response =
        await _repo.fetchAll(keyword: _keyword.isEmpty ? null : _keyword);
    if (response.ok && response.data != null) {
      _bags = response.data!;
    } else if (response.unauthorized) {
      _error = 'unauthorized';
      _bags = [];
    } else if (response.error != null) {
      _error = response.error;
      _bags = [];
    } else {
      _error = 'status ${response.statusCode}';
      _bags = [];
    }
    _loading = false;
    notifyListeners();
  }

  void clear() {
    _bags = [];
    _keyword = '';
    notifyListeners();
  }
}
