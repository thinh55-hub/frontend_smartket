import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env.dart';
import '../storage/token_storage.dart';

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  Duration timeout = const Duration(seconds: 10);

  Future<ApiResponse<T>> get<T>(String path, {T Function(dynamic json)? parser}) async {
    return _send<T>('GET', path, parser: parser);
  }

  Future<ApiResponse<T>> post<T>(String path, {Object? body, T Function(dynamic json)? parser}) async {
    return _send<T>('POST', path, body: body, parser: parser);
  }

  Future<ApiResponse<T>> put<T>(String path, {Object? body, T Function(dynamic json)? parser}) async {
    return _send<T>('PUT', path, body: body, parser: parser);
  }

  Future<ApiResponse<T>> delete<T>(String path, {T Function(dynamic json)? parser}) async {
    return _send<T>('DELETE', path, parser: parser);
  }

  Future<ApiResponse<T>> _send<T>(String method, String path, {Object? body, T Function(dynamic json)? parser}) async {
    final uri = Uri.parse('${EnvConfig.baseUrl}$path');
    final headers = <String, String>{'Content-Type': 'application/json'};
    final token = await TokenStorage.readToken();
    if (token != null) headers['Authorization'] = 'Bearer $token';

    http.Response resp;
    try {
      switch (method) {
        case 'GET':
          resp = await _client.get(uri, headers: headers).timeout(timeout);
          break;
        case 'POST':
          resp = await _client.post(uri, headers: headers, body: body == null ? null : jsonEncode(body)).timeout(timeout);
          break;
        case 'PUT':
          resp = await _client.put(uri, headers: headers, body: body == null ? null : jsonEncode(body)).timeout(timeout);
          break;
        case 'DELETE':
          resp = await _client.delete(uri, headers: headers).timeout(timeout);
          break;
        default:
          throw UnsupportedError('Unsupported method $method');
      }
    } on TimeoutException {
      return ApiResponse.error('timeout');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }

    dynamic data;
    if (resp.body.isNotEmpty) {
      try { data = jsonDecode(resp.body); } catch (_) { data = resp.body; }
    }

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final parsed = parser != null ? parser(data) : data as T;
      return ApiResponse.success(parsed);
    }

    if (resp.statusCode == 401) {
      // optional: trigger logout callback
      return ApiResponse.unauthorized();
    }

    return ApiResponse.failure(resp.statusCode, data);
  }
}

class ApiResponse<T> {
  final T? data;
  final bool ok;
  final bool unauthorized;
  final int? statusCode;
  final String? error; // generic error (like timeout) or message
  final dynamic payload; // raw body for failures

  ApiResponse._({this.data, this.ok = false, this.unauthorized = false, this.statusCode, this.error, this.payload});

  factory ApiResponse.success(T data) => ApiResponse._(data: data, ok: true);
  factory ApiResponse.failure(int statusCode, dynamic payload) => ApiResponse._(statusCode: statusCode, payload: payload);
  factory ApiResponse.error(String message) => ApiResponse._(error: message);
  factory ApiResponse.unauthorized() => ApiResponse._(unauthorized: true, statusCode: 401);
}
