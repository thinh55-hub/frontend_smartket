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
    }, parser: (json) {
      // Backend wraps data? Try common shapes
      final data = json['data'] ?? json;
      final token = data['token'] ?? json['token'];
      if (token is String) await TokenStorage.saveToken(token);
      final userJson = data['user'] ?? data['profile'] ?? data; // fallback
      return User.fromJson(Map<String, dynamic>.from(userJson));
    });
    return resp;
  }

  Future<ApiResponse<User>> register(String email, String password, {String? name}) async {
    final resp = await _client.post('/auth/register', body: {
      'email': email,
      'password': password,
      if (name != null) 'name': name,
    }, parser: (json) {
      final data = json['data'] ?? json;
      final token = data['token'] ?? json['token'];
      if (token is String) await TokenStorage.saveToken(token);
      final userJson = data['user'] ?? data['profile'] ?? data; 
      return User.fromJson(Map<String, dynamic>.from(userJson));
    });
    return resp;
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