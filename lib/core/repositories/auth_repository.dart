import '../api/api_client.dart';
import '../storage/token_storage.dart';
import '../models/user.dart';

class AuthRepository {
  final ApiClient _client;
  AuthRepository(this._client);

  Future<ApiResponse<User>> login(String email, String password) async {
    final resp = await _client.post('/auth/login', body: {
      'email': email,
      'password': password,
    }, parser: (json) => json);

    if (!resp.ok) {
      if (resp.unauthorized) return ApiResponse.unauthorized();
      return ApiResponse.failure(resp.statusCode ?? 0, resp.payload);
    }

    // resp.data should be the decoded JSON. Normalize common shapes
    final json = resp.data;
    final data = (json is Map && json.containsKey('data')) ? json['data'] : json;
    final token = (data is Map && (data['token'] ?? json['token']) != null) ? (data['token'] ?? json['token']) : null;
    if (token is String) await TokenStorage.saveToken(token);
    final userJson = (data is Map && (data['user'] ?? data['profile']) != null)
        ? (data['user'] ?? data['profile'])
        : data;
    final user = User.fromJson(Map<String, dynamic>.from(userJson));
    return ApiResponse.success(user);
  }

  Future<ApiResponse<User>> register(String email, String password, {String? name}) async {
    final resp = await _client.post('/auth/register', body: {
      'email': email,
      'password': password,
      if (name != null) 'name': name,
    }, parser: (json) => json);

    if (!resp.ok) {
      if (resp.unauthorized) return ApiResponse.unauthorized();
      return ApiResponse.failure(resp.statusCode ?? 0, resp.payload);
    }

    final json = resp.data;
    final data = (json is Map && json.containsKey('data')) ? json['data'] : json;
    final token = (data is Map && (data['token'] ?? json['token']) != null) ? (data['token'] ?? json['token']) : null;
    if (token is String) await TokenStorage.saveToken(token);
    final userJson = (data is Map && (data['user'] ?? data['profile']) != null)
        ? (data['user'] ?? data['profile'])
        : data;
    final user = User.fromJson(Map<String, dynamic>.from(userJson));
    return ApiResponse.success(user);
  }

  Future<ApiResponse<User>> profile() async {
    return _client.get('/auth/profile', parser: (json) {
      final data = json['data'] ?? json;
      return User.fromJson(Map<String, dynamic>.from(data));
    });
  }

  Future<void> remoteLogout() async {
    // Fire and forget; ignore errors
    await _client.post('/auth/logout');
  }

  Future<void> logout() async {
    await remoteLogout();
    await TokenStorage.clear();
  }
}