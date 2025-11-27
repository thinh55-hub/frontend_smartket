import '../api/api_client.dart';
import '../models/smartbag.dart';
import '../../data/mock_smartbag.dart';

class SmartbagRepositoryMock {
  Future<ApiResponse<List<Smartbag>>> fetchAll({String? keyword}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    var data = mockSmartbags;
    if (keyword != null && keyword.isNotEmpty) {
      data = data
          .where(
              (bag) => bag.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return ApiResponse.success(data);
  }

  Future<ApiResponse<Smartbag>> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 250));
    try {
      final bag = mockSmartbags.firstWhere((bag) => bag.id == id);
      return ApiResponse.success(bag);
    } catch (_) {
      return ApiResponse.failure(404, {'message': 'Smartbag not found'});
    }
  }
}
